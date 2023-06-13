using System;
using Xunit;

namespace GithubActions.Api.UnitTests;

public class UnitTest1
{
    [Fact]
    public void Test1()
    {
        Assert.True(true);
    }
    
    [Fact]
    public void Test2()
    {
        Assert.True(true);
    }
    
    [Fact]
    public void Test3()
    {
        Assert.True(true);
    }
    
    [Fact]
    public void Test4()
    {
        var weatherForecast = new WeatherForecast
        {
            Date = DateTime.Today,
            Summary = "wooo",
            TemperatureC = 100
        };
        
        Assert.True(true);
        Assert.Equal(weatherForecast.Date, weatherForecast.Date);
        Assert.Equal(weatherForecast.Summary, weatherForecast.Summary);
        Assert.Equal(weatherForecast.TemperatureC, weatherForecast.TemperatureC);
        Assert.Equal(weatherForecast.TemperatureF, weatherForecast.TemperatureF);
    }
}