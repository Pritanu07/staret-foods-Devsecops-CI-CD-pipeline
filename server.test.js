const request = require('supertest');
const server = require('./server');

describe('Express App', () => {
  afterAll(() => {
    server.close();
  });

  it('should respond with "Welcome to staret-foods" when hitting the root endpoint', async () => {
    const response = await request(server).get('/');
    expect(response.status).toBe(200);
    
  });

/*   it('should respond with "Hello from /test Node!" when hitting the /test endpoint', async () => {
    const response = await request(server).get('/test');
    expect(response.status).toBe(200);
    expect(response.text).toBe('Hello from /test Node!');
  }); */
});