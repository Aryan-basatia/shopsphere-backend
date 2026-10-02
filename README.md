# ShopSphere — E-Commerce Backend

Spring Boot 3 REST API for an online store: products, users, orders.
Built as part of my Java Full Stack roadmap (Oct–Dec 2026).

## Tech Stack

| Layer | Tech |
|---|---|
| Language | Java 17 |
| Framework | Spring Boot 3.x (Spring 6) |
| Persistence | Hibernate / JPA (Spring Data JPA — coming Milestone 2) |
| Database | MySQL 8 |
| Build | Maven |
| Security | Spring Security + JWT (Milestone 4) |
| Frontend | React (Milestone 6) |

## Features (roadmap)

- [x] **M1** — Project setup, MySQL schema, Git repo
- [ ] **M2** — Product entity + JPA repository + REST CRUD (GET/POST/PUT/DELETE)
- [ ] **M3** — Service layer, DTOs, validation, global exception handling, Swagger
- [ ] **M4** — User auth: Spring Security + JWT (USER / ADMIN roles)
- [ ] **M5** — Cart + Order entities, relationships, order placement API
- [ ] **M6** — React frontend (product list/detail, Axios)
- [ ] **M7** — React auth (login/signup, protected routes)
- [ ] **M9** — Admin panel + order history
- [ ] **M10** — Tests (JUnit + Mockito), Docker, deploy

## Database Schema

4 tables. Relationships: `users 1—N orders 1—N order_items N—1 products`

| Table | Purpose | Key columns |
|---|---|---|
| `users` | Customers and admins | id, name, email (unique), password, role, created_at |
| `products` | Catalogue | id, name, price, stock, category |
| `orders` | One row per order | id, **user_id → users.id**, order_date, status |
| `order_items` | Products inside an order | id, **order_id → orders.id**, **product_id → products.id**, quantity, price |

> `orders` is used instead of `order` because `ORDER` is a reserved SQL keyword.

## Getting Started

### 1. Clone

```bash
git clone https://github.com/<your-username>/shopsphere-backend.git
cd shopsphere-backend
```

### 2. Create the database

```bash
mysql -u root -p < db/shopsphere_schema.sql
```

This creates the `shopsphere` database, all 4 tables, and seed data
(5 users, 8 products, 6 orders, 10 order items) with deliberate gaps for testing JOINs.

### 3. Configure credentials

Copy the sample and fill in your local MySQL password:

```bash
cp src/main/resources/application.properties.example src/main/resources/application.properties
```

Or set them as environment variables (recommended):

```bash
export DB_USERNAME=root
export DB_PASSWORD=yourpassword
```

### 4. Run

```bash
mvn spring-boot:run
# or
mvn clean package && java -jar target/shopsphere-backend-0.0.1-SNAPSHOT.jar
```

App starts on `http://localhost:8080`.
Health check: `http://localhost:8080/actuator/health` → `{"status":"UP"}`

## API (updated as milestones land)

| Method | Endpoint | Description | Status |
|---|---|---|---|
| GET | `/actuator/health` | App + DB health | ✅ M1 |
| GET | `/api/products` | List all products | 🔜 M2 |
| GET | `/api/products/{id}` | Get one product | 🔜 M2 |
| POST | `/api/products` | Create product (ADMIN) | 🔜 M2 |
| PUT | `/api/products/{id}` | Update product (ADMIN) | 🔜 M2 |
| DELETE | `/api/products/{id}` | Delete product (ADMIN) | 🔜 M2 |
| POST | `/api/auth/register` | Register user | 🔜 M4 |
| POST | `/api/auth/login` | Login, returns JWT | 🔜 M4 |
| POST | `/api/orders` | Place an order | 🔜 M5 |

## Project Structure

```
shopsphere-backend/
├── db/
│   └── shopsphere_schema.sql        # schema + seed data
├── src/main/java/com/<you>/shopsphere/
│   ├── ShopSphereApplication.java   # @SpringBootApplication
│   ├── controller/                  # REST endpoints (M2+)
│   ├── service/                     # business logic (M3+)
│   ├── repository/                  # Spring Data JPA interfaces (M2+)
│   ├── entity/                      # @Entity classes (M2+)
│   └── dto/                         # request/response objects (M3+)
├── src/main/resources/
│   ├── application.properties
│   └── static/
└── pom.xml
```

## Author

**Aryan Basatia** — B.Tech CSE, 5th semester, JMIETI Radaur (Kurukshetra University)
Learning Java Full Stack: Java + DSA → Spring Boot → Project → React
