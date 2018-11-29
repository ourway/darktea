import React from "react";
import { Header, Segment, Form, Button } from "semantic-ui-react";
import { Link } from "react-router-dom";

const LoginSection = () => {
  return (
    <div>
      <p>
        {" "}
        Please login usign your username and password. In case you don't
        remember your password, For now, nothing we can do about it.
      </p>

      <div />

      <p>
        {" "}
        If you do not have Darktea account, please{" "}
        <strong>
          <u>
            <Link to="/about">signup here</Link>
          </u>
        </strong>
        .
      </p>

      <Segment clearing basic>
        <Form inverted>
          <Form.Group widths="equal">
            <Form.Input type='text'  fluid  label="Username" placeholder="Your username here" />
            <Form.Input type='password' fluid label="Password" placeholder="Your password please" />
          </Form.Group>
          <Form.Checkbox label="Remember me" />
          <Button type="submit">Submit</Button>
        </Form>
      </Segment>
    </div>
  );
};

export default LoginSection;
