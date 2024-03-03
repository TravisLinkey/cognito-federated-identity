import GoogleAuthButton from "@/components/GoogleAuthButton";
import styles from "./index.module.css";

export default function Home() {
  return (
    <section className={styles.auth}>
      <form>
        <h1>Login Page</h1>
        <div className={styles.actions}>
          <GoogleAuthButton />
        </div>
      </form>
    </section>
  );
}
