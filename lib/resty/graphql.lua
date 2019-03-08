--
-- Copyright 2019 The HongJiang Library Authors. All right reserved.
-- Use of this source that is governed by a Apache-style
-- license that can be found in the LICENSE file.
--
-- The primary `resty.graphql` module includes everything you need to
-- define a GraphQL schema and fulfill GraphQL requests.
--
-- @author hjboss <hongjiangproject@gmail.com> 2019-03 $
--
local _M = {version = "0.0.1"}

-- The set of allowed kind values for AST nodes.
local KIND = {
  NAME = "Name",
  DOCUMENT = "Document",
  OPERATION_DEFINITION = "OperationDefinition",
  VARIABLE_DEFINITION = "VariableDefinition",
  SELECTION_SET = "SelectionSet",
  FIELD = "Field",
  ARGUMENT = "Argument",
  FRAGMENT_SPREAD = "FragmentSpread",
  INLINE_FRAGMENT = "InlineFragment",
  FRAGMENT_DEFINITION = "FragmentDefinition",
  VARIABLE = "Variable",
  INT = "IntValue",
  FLOAT = "FloatValue",
  STRING = "StringValue",
  BOOLEAN = "BooleanValue",
  NULL = "NullValue",
  ENUM = "EnumValue",
  LIST = "ListValue",
  OBJECT = "ObjectValue",
  OBJECT_FIELD = "ObjectField",
  DIRECTIVE = "Directive",
  NAMED_TYPE = "NamedType",
  LIST_TYPE = "ListType",
  NON_NULL_TYPE = "NonNullType",
  SCHEMA_DEFINITION = "SchemaDefinition",
  OPERATION_TYPE_DEFINITION = "OperationTypeDefinition",
  SCALAR_TYPE_DEFINITION = "ScalarTypeDefinition",
  OBJECT_TYPE_DEFINITION = "ObjectTypeDefinition",
  FIELD_DEFINITION = "FieldDefinition",
  INPUT_VALUE_DEFINITION = "InputValueDefinition",
  INTERFACE_TYPE_DEFINITION = "InterfaceTypeDefinition",
  UNION_TYPE_DEFINITION = "UnionTypeDefinition",
  ENUM_TYPE_DEFINITION = "EnumTypeDefinition",
  ENUM_VALUE_DEFINITION = "EnumValueDefinition",
  INPUT_OBJECT_TYPE_DEFINITION = "InputObjectTypeDefinition",
  DIRECTIVE_DEFINITION = "DirectiveDefinition",
  SCHEMA_EXTENSION = "SchemaExtension",
  SCALAR_TYPE_EXTENSION = "ScalarTypeExtension",
  OBJECT_TYPE_EXTENSION = "ObjectTypeExtension",
  INTERFACE_TYPE_EXTENSION = "InterfaceTypeExtension",
  UNION_TYPE_EXTENSION = "UnionTypeExtension",
  ENUM_TYPE_EXTENSION = "EnumTypeExtension",
  INPUT_OBJECT_TYPE_EXTENSION = "InputObjectTypeExtension"
}

-- The set of allowed directive location values.
local DIRECTIVE_LOCATION = {
  QUERY = "QUERY",
  MUTATION = "MUTATION",
  SUBSCRIPTION = "SUBSCRIPTION",
  FIELD = "FIELD",
  FRAGMENT_DEFINITION = "FRAGMENT_DEFINITION",
  FRAGMENT_SPREAD = "FRAGMENT_SPREAD",
  INLINE_FRAGMENT = "INLINE_FRAGMENT",
  VARIABLE_DEFINITION = "VARIABLE_DEFINITION",
  SCHEMA = "SCHEMA",
  SCALAR = "SCALAR",
  OBJECT = "OBJECT",
  FIELD_DEFINITION = "FIELD_DEFINITION",
  ARGUMENT_DEFINITION = "ARGUMENT_DEFINITION",
  INTERFACE = "INTERFACE",
  UNION = "UNION",
  ENUM = "ENUM",
  ENUM_VALUE = "ENUM_VALUE",
  INPUT_OBJECT = "INPUT_OBJECT",
  INPUT_FIELD_DEFINITION = "INPUT_FIELD_DEFINITION"
}

-- A representation of source input to GraphQL.
local function Source(configures)
  configures.body = configures.body or ""
  configures.name = configures.name or "GraphQL request"
  configures.locationOffset = configures.locationOffset or {line = 1, column = 1}

  assert(configures.locationOffset.line > 0, "line in locationOffset is 1-indexed and must be positive")
  assert(configures.locationOffset.column > 0, "column in locationOffset is 1-indexed and must be positive")

  return configures
end

-- Determine the type of an AST node.
local function isExecutableDefinitionNode(node)
  return node.kind == KIND.OPERATION_DEFINITION or node.kind == KIND.FRAGMENT_DEFINITION
end

local function isSelectionNode(node)
  return node.kind == KIND.FIELD or node.kind == KIND.FRAGMENT_SPREAD or node.kind == KIND.INLINE_FRAGMENT
end

local function isValueNode(node)
  return node.kind == KIND.VARIABLE or node.kind == KIND.INT or node.kind == KIND.FLOAT or node.kind == KIND.STRING or
    node.kind == KIND.BOOLEAN or
    node.kind == KIND.NULL or
    node.kind == KIND.ENUM or
    node.kind == KIND.LIST or
    node.kind == KIND.OBJECT
end

local function isTypeNode(node)
  return node.kind == KIND.NAMED_TYPE or node.kind == KIND.LIST_TYPE or node.kind == KIND.NON_NULL_TYPE
end

local function isTypeExtensionNode(node)
  return node.kind == KIND.SCALAR_TYPE_EXTENSION or node.kind == KIND.OBJECT_TYPE_EXTENSION or
    node.kind == KIND.INTERFACE_TYPE_EXTENSION or
    node.kind == KIND.UNION_TYPE_EXTENSION or
    node.kind == KIND.ENUM_TYPE_EXTENSION or
    node.kind == KIND.INPUT_OBJECT_TYPE_EXTENSION
end

local function isTypeDefinitionNode(node)
  return node.kind == KIND.SCALAR_TYPE_DEFINITION or node.kind == KIND.OBJECT_TYPE_DEFINITION or
    node.kind == KIND.INTERFACE_TYPE_DEFINITION or
    node.kind == KIND.UNION_TYPE_DEFINITION or
    node.kind == KIND.ENUM_TYPE_DEFINITION or
    node.kind == KIND.INPUT_OBJECT_TYPE_DEFINITION
end

local function isTypeSystemExtensionNode(node)
  return node.kind == KIND.SCHEMA_EXTENSION or isTypeExtensionNode(node)
end

local function isTypeSystemDefinitionNode(node)
  return node.kind == KIND.SCHEMA_DEFINITION or isTypeDefinitionNode(node) or node.kind == KIND.DIRECTIVE_DEFINITION
end

local function isDefinitionNode(node)
  return isExecutableDefinitionNode(node) or isTypeSystemDefinitionNode(node) or isTypeExtensionNode(node)
end

return _M
