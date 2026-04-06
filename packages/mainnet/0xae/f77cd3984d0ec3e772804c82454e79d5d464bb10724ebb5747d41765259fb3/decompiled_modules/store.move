module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store {
    struct Store has key {
        id: 0x2::object::UID,
        game_company: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        is_active: bool,
        games_count: u64,
        total_sales_count: u64,
        created_at: u64,
    }

    struct StoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        game_company: address,
        name: 0x1::string::String,
    }

    struct StoreUpdated has copy, drop {
        store_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct StoreActiveToggled has copy, drop {
        store_id: 0x2::object::ID,
        is_active: bool,
    }

    public fun create_store(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::developer_role())) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = 0x2::object::new(arg5);
        let v3 = Store{
            id                : v2,
            game_company      : arg1,
            name              : arg2,
            description       : arg3,
            is_active         : true,
            games_count       : 0,
            total_sales_count : 0,
            created_at        : 0x2::clock::timestamp_ms(arg4),
        };
        let v4 = StoreCreated{
            store_id     : 0x2::object::uid_to_inner(&v2),
            game_company : arg1,
            name         : v3.name,
        };
        0x2::event::emit<StoreCreated>(v4);
        0x2::transfer::share_object<Store>(v3);
    }

    public fun get_store_info(arg0: &Store) : (address, 0x1::string::String, 0x1::string::String, bool, u64, u64, u64) {
        (arg0.game_company, arg0.name, arg0.description, arg0.is_active, arg0.games_count, arg0.total_sales_count, arg0.created_at)
    }

    public(friend) fun increment_store_games_count(arg0: &mut Store) {
        arg0.games_count = arg0.games_count + 1;
    }

    public(friend) fun increment_store_sales(arg0: &mut Store) {
        arg0.total_sales_count = arg0.total_sales_count + 1;
    }

    public fun is_store_active(arg0: &Store) : bool {
        arg0.is_active
    }

    public fun store_game_company(arg0: &Store) : address {
        arg0.game_company
    }

    public fun store_id(arg0: &Store) : 0x2::object::ID {
        0x2::object::id<Store>(arg0)
    }

    public(friend) fun store_uid(arg0: &Store) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun store_uid_mut(arg0: &mut Store) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun toggle_store_active(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Store, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.game_company || 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role()), 1);
        arg1.is_active = !arg1.is_active;
        let v1 = StoreActiveToggled{
            store_id  : 0x2::object::id<Store>(arg1),
            is_active : arg1.is_active,
        };
        0x2::event::emit<StoreActiveToggled>(v1);
    }

    public fun update_store(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Store, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.game_company || 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role()), 1);
        arg1.name = arg2;
        arg1.description = arg3;
        let v1 = StoreUpdated{
            store_id    : 0x2::object::id<Store>(arg1),
            name        : arg1.name,
            description : arg1.description,
        };
        0x2::event::emit<StoreUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

