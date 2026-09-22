create table if not exists person(
    user_id uuid primary key default gen_random_uuid(),
    username varchar(50) not null,
    email varchar(100) not null unique,
    password_hash varchar(255) not null,
    wallet_balance decimal(10, 2) not null default 0.00,
    created_at timestamp not null default current_timestamp,
    constraint wallet_balance_positive check (wallet_balance >=0)
);
create table if not exists publisher(
    publisher_id uuid primary key default gen_random_uuid(),
    publisher_name varchar(50) unique not null,
    website varchar(255),
    support_email varchar(100) not null
);
create type app_type as enum('game', 'dlc', 'soundtrack');
create table if not exists app(
    app_id uuid primary key default gen_random_uuid(),
    publisher_id uuid not null references publisher(publisher_id),
    parent_game_id uuid references app(app_id),
    title varchar(150) not null,
    app_type app_type not null,
    description text,
    price decimal(10, 2) not null,
    release_date date not null,
    constraint game_price_positive check(price>=0)
);
create table if not exists category(
    category_id uuid primary key default gen_random_uuid(),
    category_name varchar(50) not null unique,
    description text
);
create table if not exists app_category(
    category_id uuid not null references category(category_id) on delete cascade,
    app_id uuid not null references app(app_id) on delete cascade,
    primary key(category_id, app_id)
);