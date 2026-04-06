module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game {
    struct Game has key {
        id: 0x2::object::UID,
        store_id: 0x2::object::ID,
        game_company: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        cover_image_url: 0x1::option::Option<0x1::string::String>,
        is_active: bool,
        products_count: u64,
        sales_count: u64,
        created_at: u64,
    }

    struct GameCreated has copy, drop {
        game_id: 0x2::object::ID,
        store_id: 0x2::object::ID,
        game_company: address,
        name: 0x1::string::String,
    }

    struct GameUpdated has copy, drop {
        game_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct GameActiveToggled has copy, drop {
        game_id: 0x2::object::ID,
        is_active: bool,
    }

    public fun create_game(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::is_store_active(arg1), 2);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_id(arg1);
        let v4 = Game{
            id              : v2,
            store_id        : v3,
            game_company    : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_game_company(arg1),
            name            : arg2,
            description     : arg3,
            cover_image_url : arg4,
            is_active       : true,
            products_count  : 0,
            sales_count     : 0,
            created_at      : 0x2::clock::timestamp_ms(arg5),
        };
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::increment_store_games_count(arg1);
        let v5 = GameCreated{
            game_id      : 0x2::object::uid_to_inner(&v2),
            store_id     : v3,
            game_company : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_game_company(arg1),
            name         : v4.name,
        };
        0x2::event::emit<GameCreated>(v5);
        0x2::transfer::share_object<Game>(v4);
    }

    public fun game_game_company(arg0: &Game) : address {
        arg0.game_company
    }

    public fun game_id(arg0: &Game) : 0x2::object::ID {
        0x2::object::id<Game>(arg0)
    }

    public fun game_store_id(arg0: &Game) : 0x2::object::ID {
        arg0.store_id
    }

    public(friend) fun game_uid(arg0: &Game) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun game_uid_mut(arg0: &mut Game) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_game_info(arg0: &Game) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x1::string::String>, bool, u64, u64, u64) {
        (arg0.store_id, arg0.game_company, arg0.name, arg0.description, arg0.cover_image_url, arg0.is_active, arg0.products_count, arg0.sales_count, arg0.created_at)
    }

    public(friend) fun increment_game_products(arg0: &mut Game) {
        arg0.products_count = arg0.products_count + 1;
    }

    public(friend) fun increment_game_sales(arg0: &mut Game) {
        arg0.sales_count = arg0.sales_count + 1;
    }

    public fun is_game_active(arg0: &Game) : bool {
        arg0.is_active
    }

    public fun toggle_game_active(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Game, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg1.game_company) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        arg1.is_active = arg2;
        let v2 = GameActiveToggled{
            game_id   : 0x2::object::id<Game>(arg1),
            is_active : arg1.is_active,
        };
        0x2::event::emit<GameActiveToggled>(v2);
    }

    public fun update_game(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (v0 == arg1.game_company) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.cover_image_url = arg4;
        let v2 = GameUpdated{
            game_id     : 0x2::object::id<Game>(arg1),
            name        : arg1.name,
            description : arg1.description,
        };
        0x2::event::emit<GameUpdated>(v2);
    }

    public(friend) fun validate_game_store(arg0: &Game, arg1: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::Store) {
        assert!(arg0.store_id == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store::store_id(arg1), 3);
    }

    // decompiled from Move bytecode v7
}

