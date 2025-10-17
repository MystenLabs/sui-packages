module 0x7813f0b03f6ddae7c234349df62816feb570abe0ee0760a749b22afec9e87e48::sui_trap {
    struct SUI_TRAP has drop {
        dummy_field: bool,
    }

    struct SuiTrapCoin has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        trap_id: u64,
        is_active: bool,
        creator: address,
        trap_name: 0x1::string::String,
    }

    struct TrapTreasury has key {
        id: 0x2::object::UID,
        deployer: address,
        victim_publisher: address,
        total_traps_created: u64,
        total_bots_trapped: u64,
        gas_consumed_by_bots: u64,
        active_traps: 0x2::table::Table<0x1::string::String, TrapInfo>,
    }

    struct TrapInfo has store {
        trap_id: u64,
        victim_address: address,
        object_id: 0x2::object::ID,
        sui_value: u64,
        is_active: bool,
        created_at: u64,
    }

    struct TrapCreated has copy, drop {
        trap_id: u64,
        trap_name: 0x1::string::String,
        sui_value: u64,
        victim_address: address,
        creator: address,
        timestamp: u64,
    }

    struct BotTrapped has copy, drop {
        trap_id: u64,
        bot_address: address,
        trap_name: 0x1::string::String,
        gas_cost: u64,
        sui_value_stolen: u64,
        timestamp: u64,
    }

    public fun create_sui_trap(arg0: &mut TrapTreasury, arg1: address, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.deployer, 102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        arg0.total_traps_created = arg0.total_traps_created + 1;
        let v1 = arg0.total_traps_created;
        let v2 = SuiTrapCoin{
            id          : 0x2::object::new(arg4),
            sui_balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            trap_id     : v1,
            is_active   : true,
            creator     : 0x2::tx_context::sender(arg4),
            trap_name   : arg2,
        };
        let v3 = TrapInfo{
            trap_id        : v1,
            victim_address : arg1,
            object_id      : 0x2::object::id<SuiTrapCoin>(&v2),
            sui_value      : v0,
            is_active      : true,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::table::add<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg2, v3);
        let v4 = TrapCreated{
            trap_id        : v1,
            trap_name      : arg2,
            sui_value      : v0,
            victim_address : arg1,
            creator        : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TrapCreated>(v4);
        0x2::transfer::public_transfer<SuiTrapCoin>(v2, arg1);
    }

    public fun create_sui_trap_as_victim(arg0: &mut TrapTreasury, arg1: address, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1 && 0x2::tx_context::sender(arg4) == arg0.victim_publisher, 103);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        arg0.total_traps_created = arg0.total_traps_created + 1;
        let v1 = arg0.total_traps_created;
        let v2 = SuiTrapCoin{
            id          : 0x2::object::new(arg4),
            sui_balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            trap_id     : v1,
            is_active   : true,
            creator     : arg0.deployer,
            trap_name   : arg2,
        };
        let v3 = TrapInfo{
            trap_id        : v1,
            victim_address : arg1,
            object_id      : 0x2::object::id<SuiTrapCoin>(&v2),
            sui_value      : v0,
            is_active      : true,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::table::add<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg2, v3);
        let v4 = TrapCreated{
            trap_id        : v1,
            trap_name      : arg2,
            sui_value      : v0,
            victim_address : arg1,
            creator        : arg0.deployer,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TrapCreated>(v4);
        0x2::transfer::public_transfer<SuiTrapCoin>(v2, arg1);
    }

    public fun deactivate_trap(arg0: &mut TrapTreasury, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 201);
        if (0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)) {
            0x2::table::borrow_mut<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg1).is_active = false;
        };
    }

    fun expensive_gas_operation(arg0: u64, arg1: u64) {
        let v0 = if (arg1 >= 100000000) {
            200000
        } else {
            150000
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::empty<u64>();
            let v3 = 0;
            while (v3 < 300) {
                0x1::vector::push_back<u64>(&mut v2, arg0 * arg1 * v3);
                v3 = v3 + 1;
            };
            let v4 = 0;
            while (v4 < 150) {
                if (0x1::vector::length<u64>(&v2) > 15) {
                    0x1::vector::pop_back<u64>(&mut v2);
                    0x1::vector::remove<u64>(&mut v2, 0);
                };
                0x1::vector::push_back<u64>(&mut v2, v4 * arg0 * arg1);
                let v5 = arg0 + arg1;
                let v6 = 0;
                while (v6 < 0x1::vector::length<u64>(&v2)) {
                    let v7 = *0x1::vector::borrow<u64>(&v2, v6);
                    let v8 = (v5 + v7 * (v6 + 1) * arg1 ^ arg0 << 8) * 17;
                    v5 = v8 + v7 * arg1;
                    v6 = v6 + 1;
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun get_trap_by_name(arg0: &TrapTreasury, arg1: 0x1::string::String) : (u64, address, 0x2::object::ID, u64, bool) {
        if (0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)) {
            let v5 = 0x2::table::borrow<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1);
            (v5.trap_id, v5.victim_address, v5.object_id, v5.sui_value, v5.is_active)
        } else {
            (0, @0x0, 0x2::object::id_from_address(@0x0), 0, false)
        }
    }

    public fun get_trap_info(arg0: &SuiTrapCoin) : (u64, u64, address, 0x1::string::String, bool) {
        (arg0.trap_id, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.creator, arg0.trap_name, arg0.is_active)
    }

    public fun get_trap_sui_value(arg0: &SuiTrapCoin) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_treasury_stats(arg0: &TrapTreasury) : (u64, u64, u64) {
        (arg0.total_traps_created, arg0.total_bots_trapped, arg0.gas_consumed_by_bots)
    }

    fun init(arg0: SUI_TRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TrapTreasury{
            id                   : 0x2::object::new(arg1),
            deployer             : 0x2::tx_context::sender(arg1),
            victim_publisher     : 0x2::tx_context::sender(arg1),
            total_traps_created  : 0,
            total_bots_trapped   : 0,
            gas_consumed_by_bots : 0,
            active_traps         : 0x2::table::new<0x1::string::String, TrapInfo>(arg1),
        };
        0x2::transfer::share_object<TrapTreasury>(v0);
    }

    public fun is_deployer(arg0: &TrapTreasury, arg1: address) : bool {
        arg0.deployer == arg1
    }

    public fun is_victim_publisher(arg0: &TrapTreasury, arg1: address) : bool {
        arg0.victim_publisher == arg1
    }

    public fun setup_victim_publisher(arg0: &mut TrapTreasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 101);
        arg0.victim_publisher = arg1;
    }

    public fun transfer_sui_trap(arg0: SuiTrapCoin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let SuiTrapCoin {
            id          : v0,
            sui_balance : v1,
            trap_id     : v2,
            is_active   : _,
            creator     : _,
            trap_name   : v5,
        } = arg0;
        let v6 = v1;
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        expensive_gas_operation(v2, v7);
        let v8 = BotTrapped{
            trap_id          : v2,
            bot_address      : 0x2::tx_context::sender(arg2),
            trap_name        : v5,
            gas_cost         : 200000000,
            sui_value_stolen : v7,
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<BotTrapped>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), arg1);
        0x2::object::delete(v0);
    }

    public fun trap_exists(arg0: &TrapTreasury, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)
    }

    public fun unwrap_sui_trap(arg0: SuiTrapCoin, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let SuiTrapCoin {
            id          : v0,
            sui_balance : v1,
            trap_id     : v2,
            is_active   : _,
            creator     : _,
            trap_name   : v5,
        } = arg0;
        let v6 = v1;
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        expensive_gas_operation(v2, v7);
        expensive_gas_operation(v2 * 2, v7 * 2);
        let v8 = BotTrapped{
            trap_id          : v2,
            bot_address      : 0x2::tx_context::sender(arg1),
            trap_name        : v5,
            gas_cost         : 400000000,
            sui_value_stolen : v7,
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<BotTrapped>(v8);
        0x2::object::delete(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1)
    }

    // decompiled from Move bytecode v6
}

