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
  ARGUMENT = "Argument"
}

return _M
