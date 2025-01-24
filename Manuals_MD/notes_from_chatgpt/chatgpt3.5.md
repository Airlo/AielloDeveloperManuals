## 代码篇

##### json与yaml相互转换

```c++
#include <fstream>
#include <iostream>
#include <sstream>

#include "rapidjson/document.h"
#include "rapidjson/prettywriter.h"
#include "rapidjson/stringbuffer.h"
#include "yaml-cpp/yaml.h"

// 将 JSON 文件转换为 YAML 文件
void json2yaml(const std::string& json_file, const std::string& yaml_file) {
  std::ifstream ifs(json_file);
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  std::string json_str = buffer.str();
  rapidjson::Document doc;
  doc.Parse(json_str.c_str());
  rapidjson::StringBuffer sb;
  rapidjson::PrettyWriter<rapidjson::StringBuffer> writer(sb);
  doc.Accept(writer);
  YAML::Node yaml_node = YAML::Load(sb.GetString());
  std::ofstream ofs(yaml_file);
  ofs << yaml_node;
}

// 将 YAML 文件转换为 JSON 文件
void yaml2json(const std::string& yaml_file, const std::string& json_file) {
  YAML::Node yaml_node = YAML::LoadFile(yaml_file);
  std::stringstream ss;
  ss << yaml_node;
  std::string yaml_str = ss.str();
  rapidjson::Document doc;
  doc.Parse(yaml_str.c_str());
  rapidjson::StringBuffer sb;
  rapidjson::PrettyWriter<rapidjson::StringBuffer> writer(sb);
  doc.Accept(writer);
  std::ofstream ofs(json_file);
  ofs << sb.GetString();
}

int main() {
  // 示例：将 JSON 文件转换为 YAML 文件
  json2yaml("input.json", "output.yaml");

  // 示例：将 YAML 文件转换为 JSON 文件
  yaml2json("input.yaml", "output.json");

  return 0;
}

```

##### 将json转换为yaml并更改名称

```json
#include <fstream>
#include <iostream>
#include <sstream>

#include "rapidjson/document.h"
#include "rapidjson/prettywriter.h"
#include "rapidjson/stringbuffer.h"
#include "yaml-cpp/yaml.h"

// 递归遍历 JSON 对象，将指定名称的字段修改为新名称
void rename_json_field(rapidjson::Value& value, const std::string& old_name, const std::string& new_name) {
  if (value.IsObject()) {
    for (auto& member : value.GetObject()) {
      if (member.name == old_name) {
        member.name = rapidjson::StringRef(new_name.c_str());
      }
      rename_json_field(member.value, old_name, new_name);
    }
  } else if (value.IsArray()) {
    for (auto& item : value.GetArray()) {
      rename_json_field(item, old_name, new_name);
    }
  }
}

// 将 JSON 文件转换为 YAML 文件，并根据需要修改字段名称
void json2yaml_rename_field(const std::string& json_file, const std::string& yaml_file, const std::string& old_name, const std::string& new_name) {
  std::ifstream ifs(json_file);
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  std::string json_str = buffer.str();
  rapidjson::Document doc;
  doc.Parse(json_str.c_str());
  rename_json_field(doc, old_name, new_name);
  rapidjson::StringBuffer sb;
  rapidjson::PrettyWriter<rapidjson::StringBuffer> writer(sb);
  doc.Accept(writer);
  YAML::Node yaml_node = YAML::Load(sb.GetString());
  std::ofstream ofs(yaml_file);
  ofs << yaml_node;
}

int main() {
  // 示例：将 JSON 文件转换为 YAML 文件，并修改字段名称
  json2yaml_rename_field("input.json", "output.yaml", "name", "new_name");

  return 0;
}
```

在以上示例代码中，`rename_json_field` 函数用于递归遍历 JSON 对象，将指定名称的字段修改为新名称。在调用 `json2yaml_rename_field` 函数时，我们可以传入需要修改的字段名称，以及新的字段名称。`json2yaml_rename_field` 函数首先将 JSON 文件解析为 rapidjson::Document 对象，然后调用 `rename_json_field` 函数修改指定名称的字段名称，最后将 rapidjson::Document 对象序列化为 YAML 文件。需要注意的是，在修改字段名称时，如果有多个字段名称为指定名称，它们都会被修改为新名称。