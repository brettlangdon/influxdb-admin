#= require vendor/jquery-2.0.3
#= require vendor/angular
#= require_self

adminApp = angular.module "adminApp", []

adminApp.controller "AdminIndexCtrl", ["$scope", "$location", "$q", "$timeout", ($scope, $location, $q, $timeout) ->
  $scope.data = []
  $scope.search = ".*"
  $scope.selectedPane = "data"

  $scope.fetchSeries = () ->
    $q.when(window.parent.influxdb.query(
      "SELECT * FROM /" + $scope.search + "/ LIMIT 1"
    )).then (response) ->
      $scope.data = response.sort (a, b) ->
        if a.name == b.name
          return 0
        return if a.name < b.name then -1 else 1
  $scope.fetchSeries()

  if $scope.username && $scope.password && $scope.database
    $scope.authenticate()
]

$(document).ready ()->
    $(document).foundation()
