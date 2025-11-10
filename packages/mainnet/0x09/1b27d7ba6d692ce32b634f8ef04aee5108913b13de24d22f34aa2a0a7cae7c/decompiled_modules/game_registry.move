module 0x91b27d7ba6d692ce32b634f8ef04aee5108913b13de24d22f34aa2a0a7cae7c::game_registry {
    struct GameRegistry has key {
        id: 0x2::object::UID,
        total_games: u64,
        active_games: 0x2::table::Table<address, u64>,
        protocol_fee_bps: u64,
        treasury: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RegistryCreated has copy, drop {
        registry_id: address,
        admin: address,
        initial_fee_bps: u64,
    }

    struct GameCreated has copy, drop {
        creator: address,
        game_number: u64,
        timestamp: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
        updated_by: address,
    }

    public fun get_creator_game_count(arg0: &GameRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.active_games, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.active_games, arg1)
        } else {
            0
        }
    }

    public fun get_protocol_fee_bps(arg0: &GameRegistry) : u64 {
        arg0.protocol_fee_bps
    }

    public fun get_total_games(arg0: &GameRegistry) : u64 {
        arg0.total_games
    }

    public fun get_treasury(arg0: &GameRegistry) : address {
        arg0.treasury
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = GameRegistry{
            id               : 0x2::object::new(arg0),
            total_games      : 0,
            active_games     : 0x2::table::new<address, u64>(arg0),
            protocol_fee_bps : 250,
            treasury         : v0,
        };
        let v3 = RegistryCreated{
            registry_id     : 0x2::object::uid_to_address(&v2.id),
            admin           : v0,
            initial_fee_bps : 250,
        };
        0x2::event::emit<RegistryCreated>(v3);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<GameRegistry>(v2);
    }

    public fun register_game(arg0: &mut GameRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, u64>(&arg0.active_games, v0)) {
            0x2::table::add<address, u64>(&mut arg0.active_games, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.active_games, v0);
        *v1 = *v1 + 1;
        arg0.total_games = arg0.total_games + 1;
        let v2 = GameCreated{
            creator     : v0,
            game_number : arg0.total_games,
            timestamp   : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<GameCreated>(v2);
    }

    public fun set_protocol_fee(arg0: &mut GameRegistry, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 0);
        arg0.protocol_fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg0.protocol_fee_bps,
            new_fee_bps : arg2,
            updated_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun set_treasury(arg0: &mut GameRegistry, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

