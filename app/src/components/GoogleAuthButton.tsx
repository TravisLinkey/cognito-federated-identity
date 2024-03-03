import {signIn, signOut, useSession} from "next-auth/react";
import GoogleButton from "react-google-button";

const GoogleAuthButton: React.FC = () => {
  const {data: session} = useSession();

  return (
    <div>
      {session ? <h1>Success! You have logged in!</h1> : undefined}
      <div>{!session ? <GoogleButton onClick={() => signIn("google")} /> : <button onClick={() => signOut()}>Sign out</button>}</div>
    </div>
  );
};

export default GoogleAuthButton;
