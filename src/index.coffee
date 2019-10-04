import {cloneDeep} from 'lodash'

isValidFetchingAction = (action) => action.types && action.meta && action.meta.fetch && action.meta.fetch.url

export default (store) -> (next) -> (action) ->
  return next(action) unless isValidFetchingAction(action)

  action = cloneDeep(action)

  {token} = store.getState()

  action.meta.fetch.headers ||= {}
  action.meta.fetch.headers['Authorization'] = token if token

  return next(action)
