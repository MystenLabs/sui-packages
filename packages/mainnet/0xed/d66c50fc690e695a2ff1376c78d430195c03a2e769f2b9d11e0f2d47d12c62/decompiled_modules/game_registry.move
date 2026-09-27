module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry {
    struct GameRegistry has key {
        id: 0x2::object::UID,
        registration_renounced: bool,
        games: 0x2::table::Table<0x1::type_name::TypeName, GameRecord>,
    }

    struct GameRecord has drop, store {
        name: 0x1::string::String,
        enabled: bool,
        enabled_locked: bool,
    }

    struct GameRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        game_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        admin: address,
    }

    struct GameEnabledChanged has copy, drop {
        registry_id: 0x2::object::ID,
        game_type: 0x1::type_name::TypeName,
        enabled: bool,
        admin: address,
    }

    struct GameEnabledLocked has copy, drop {
        registry_id: 0x2::object::ID,
        game_type: 0x1::type_name::TypeName,
        enabled_at_lock: bool,
        admin: address,
    }

    struct GameRegistrationRenounced has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : GameRegistry {
        GameRegistry{
            id                     : 0x2::object::new(arg0),
            registration_renounced : false,
            games                  : 0x2::table::new<0x1::type_name::TypeName, GameRecord>(arg0),
        }
    }

    public fun admin_lock_game_enabled<T0: drop>(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameRegistry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg1.games, v0), 3);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, GameRecord>(&mut arg1.games, v0);
        assert!(!v1.enabled_locked, 5);
        assert!(v1.enabled == arg2, 8);
        v1.enabled_locked = true;
        let v2 = GameEnabledLocked{
            registry_id     : 0x2::object::id<GameRegistry>(arg1),
            game_type       : v0,
            enabled_at_lock : v1.enabled,
            admin           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GameEnabledLocked>(v2);
    }

    public fun admin_register_game<T0: drop>(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.registration_renounced, 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg1.games, v0), 2);
        let v1 = GameRecord{
            name           : arg2,
            enabled        : true,
            enabled_locked : false,
        };
        0x2::table::add<0x1::type_name::TypeName, GameRecord>(&mut arg1.games, v0, v1);
        let v2 = GameRegistered{
            registry_id : 0x2::object::id<GameRegistry>(arg1),
            game_type   : v0,
            name        : arg2,
            admin       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GameRegistered>(v2);
    }

    public fun admin_renounce_game_registration(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.registration_renounced, 6);
        arg1.registration_renounced = true;
        let v0 = GameRegistrationRenounced{
            registry_id : 0x2::object::id<GameRegistry>(arg1),
            admin       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GameRegistrationRenounced>(v0);
    }

    public fun admin_set_game_enabled<T0: drop>(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameRegistry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg1.games, v0), 3);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, GameRecord>(&mut arg1.games, v0);
        assert!(!v1.enabled_locked, 4);
        v1.enabled = arg2;
        let v2 = GameEnabledChanged{
            registry_id : 0x2::object::id<GameRegistry>(arg1),
            game_type   : v0,
            enabled     : arg2,
            admin       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GameEnabledChanged>(v2);
    }

    public fun assert_game_authorized<T0: drop>(arg0: &GameRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0), 7);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0).enabled, 7);
    }

    public fun game_enabled_locked<T0: drop>(arg0: &GameRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0) && 0x2::table::borrow<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0).enabled_locked
    }

    public fun is_game_enabled<T0: drop>(arg0: &GameRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0) && 0x2::table::borrow<0x1::type_name::TypeName, GameRecord>(&arg0.games, v0).enabled
    }

    public fun is_game_registered<T0: drop>(arg0: &GameRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, GameRecord>(&arg0.games, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun registration_renounced(arg0: &GameRegistry) : bool {
        arg0.registration_renounced
    }

    public(friend) fun share(arg0: GameRegistry) {
        0x2::transfer::share_object<GameRegistry>(arg0);
    }

    // decompiled from Move bytecode v7
}

