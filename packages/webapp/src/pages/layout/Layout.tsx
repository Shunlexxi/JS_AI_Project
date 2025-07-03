import { Outlet, NavLink, Link } from 'react-router-dom';

import github from '../../assets/github.svg';
import mlsaLogo from '../../assets/mlsa-logo.svg';

import styles from './Layout.module.css';

const Layout = () => {
  return (
    <div className={styles.layout}>
      <header className={styles.header}>
        <div className={styles.headerContainer}>
          <Link to="/" className={styles.headerTitleContainer}>
            <img src={mlsaLogo} alt="MLSA Logo" width="24" height="24" style={{ marginRight: '8px' }} />
            <h3 className={styles.headerTitle}>MLSA LearnBot</h3>
          </Link>
          <nav>
            <ul className={styles.headerNavList}>
              <li>
                <NavLink
                  to="/"
                  className={({ isActive }) => (isActive ? styles.headerNavPageLinkActive : styles.headerNavPageLink)}
                >
                  Chat
                </NavLink>
              </li>
              <li className={styles.headerNavLeftMargin}>
                <NavLink
                  to="/qa"
                  className={({ isActive }) => (isActive ? styles.headerNavPageLinkActive : styles.headerNavPageLink)}
                >
                  Ask a question
                </NavLink>
              </li>
              <li className={styles.headerNavLeftMargin}>
                <a
                  href="https://github.com/Shunlexxi/JS_AI_Project"
                  target={'_blank'}
                  title="Github repository link"
                  rel="noreferrer"
                >
                  <img
                    src={github}
                    alt="Github logo"
                    aria-label="MLSA LearnBot Github repository link"
                    width="20px"
                    height="20px"
                    className={styles.githubLogo}
                  />
                </a>
              </li>
            </ul>
          </nav>
          <h4 className={styles.headerRightText}>Force for good!</h4>
        </div>
      </header>

      <Outlet />
    </div>
  );
};

export default Layout;
