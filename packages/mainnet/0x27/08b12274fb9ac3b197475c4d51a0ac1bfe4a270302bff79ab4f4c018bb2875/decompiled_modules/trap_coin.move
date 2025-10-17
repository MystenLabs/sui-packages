module 0x2708b12274fb9ac3b197475c4d51a0ac1bfe4a270302bff79ab4f4c018bb2875::trap_coin {
    struct TRAP_COIN has drop {
        dummy_field: bool,
    }

    struct TrapTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TRAP_COIN>,
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
        is_active: bool,
        created_at: u64,
    }

    struct TrapCoinWrapper has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<TRAP_COIN>,
        value_display: u64,
        trap_id: u64,
        target_victim: address,
        creator: address,
        is_published: bool,
    }

    struct TrapCreated has copy, drop {
        trap_id: u64,
        victim_address: address,
        display_value: u64,
        creator: address,
        timestamp: u64,
    }

    struct BotTrapped has copy, drop {
        trap_id: u64,
        bot_address: address,
        gas_sponsor: address,
        estimated_gas_cost: u64,
        timestamp: u64,
    }

    public fun batch_create_traps(arg0: &mut TrapTreasury, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.deployer, 1);
        assert!(arg2 <= 100, 2);
        let v0 = 0;
        while (v0 < arg2) {
            create_trap_for_victim(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public fun convert_trap_to_sui(arg0: &mut TrapTreasury, arg1: 0x2::coin::Coin<TRAP_COIN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<TRAP_COIN>(&arg1);
        0x2::coin::burn<TRAP_COIN>(&mut arg0.treasury_cap, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.deployer);
        expensive_gas_operation(v0);
        expensive_gas_operation(v0 * 2);
        arg0.total_bots_trapped = arg0.total_bots_trapped + 1;
        arg0.gas_consumed_by_bots = arg0.gas_consumed_by_bots + 400000000;
        let v1 = BotTrapped{
            trap_id            : v0,
            bot_address        : 0x2::tx_context::sender(arg3),
            gas_sponsor        : 0x2::tx_context::sender(arg3),
            estimated_gas_cost : 400000000,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BotTrapped>(v1);
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    public fun create_and_publish_trap(arg0: &mut TrapTreasury, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.deployer, 102);
        arg0.total_traps_created = arg0.total_traps_created + 1;
        let v0 = arg0.total_traps_created;
        let v1 = TrapCoinWrapper{
            id            : 0x2::object::new(arg4),
            balance       : 0x2::coin::into_balance<TRAP_COIN>(0x2::coin::mint<TRAP_COIN>(&mut arg0.treasury_cap, arg3, arg4)),
            value_display : arg3,
            trap_id       : v0,
            target_victim : arg1,
            creator       : 0x2::tx_context::sender(arg4),
            is_published  : true,
        };
        let v2 = TrapInfo{
            trap_id        : v0,
            victim_address : arg1,
            object_id      : 0x2::object::id<TrapCoinWrapper>(&v1),
            is_active      : true,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::table::add<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg2, v2);
        let v3 = TrapCreated{
            trap_id        : v0,
            victim_address : arg1,
            display_value  : arg3,
            creator        : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TrapCreated>(v3);
        0x2::transfer::public_transfer<TrapCoinWrapper>(v1, arg1);
    }

    fun create_trap_for_victim(arg0: &mut TrapTreasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.total_traps_created = arg0.total_traps_created + 1;
        let v0 = arg0.total_traps_created;
        let v1 = TrapCoinWrapper{
            id            : 0x2::object::new(arg3),
            balance       : 0x2::coin::into_balance<TRAP_COIN>(0x2::coin::mint<TRAP_COIN>(&mut arg0.treasury_cap, arg2, arg3)),
            value_display : arg2,
            trap_id       : v0,
            target_victim : arg1,
            creator       : 0x2::tx_context::sender(arg3),
            is_published  : true,
        };
        let v2 = TrapCreated{
            trap_id        : v0,
            victim_address : arg1,
            display_value  : arg2,
            creator        : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TrapCreated>(v2);
        0x2::transfer::public_transfer<TrapCoinWrapper>(v1, arg1);
    }

    public fun deactivate_trap(arg0: &mut TrapTreasury, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 201);
        if (0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)) {
            0x2::table::borrow_mut<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg1).is_active = false;
        };
    }

    fun expensive_gas_operation(arg0: u64) {
        let v0 = 0;
        while (v0 < 150000) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = 0;
            while (v2 < 200) {
                0x1::vector::push_back<u64>(&mut v1, arg0 * v2);
                v2 = v2 + 1;
            };
            let v3 = 0;
            while (v3 < 100) {
                if (0x1::vector::length<u64>(&v1) > 10) {
                    0x1::vector::pop_back<u64>(&mut v1);
                    0x1::vector::remove<u64>(&mut v1, 0);
                };
                0x1::vector::push_back<u64>(&mut v1, v3 * arg0);
                let v4 = 0;
                while (v4 < 0x1::vector::length<u64>(&v1)) {
                    let v5 = arg0 + *0x1::vector::borrow<u64>(&v1, v4) * (v4 + 1) ^ arg0 << 8;
                    arg0 = v5 * 17;
                    v4 = v4 + 1;
                };
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun get_deployer(arg0: &TrapTreasury) : address {
        arg0.deployer
    }

    public fun get_trap_by_name(arg0: &TrapTreasury, arg1: 0x1::string::String) : (u64, address, 0x2::object::ID, bool) {
        if (0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)) {
            let v4 = 0x2::table::borrow<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1);
            (v4.trap_id, v4.victim_address, v4.object_id, v4.is_active)
        } else {
            (0, @0x0, 0x2::object::id_from_address(@0x0), false)
        }
    }

    public fun get_trap_info(arg0: &TrapCoinWrapper) : (u64, address, u64, bool) {
        (arg0.trap_id, arg0.target_victim, arg0.value_display, arg0.is_published)
    }

    public fun get_treasury_stats(arg0: &TrapTreasury) : (u64, u64, u64) {
        (arg0.total_traps_created, arg0.total_bots_trapped, arg0.gas_consumed_by_bots)
    }

    public fun get_victim_publisher(arg0: &TrapTreasury) : address {
        arg0.victim_publisher
    }

    fun init(arg0: TRAP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAP_COIN>(arg0, 9, b"TRAP", b"Trap Coin", b"Defense mechanism against drain bots", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRAP_COIN>>(v1);
        let v2 = TrapTreasury{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            deployer             : 0x2::tx_context::sender(arg1),
            victim_publisher     : 0x2::tx_context::sender(arg1),
            total_traps_created  : 0,
            total_bots_trapped   : 0,
            gas_consumed_by_bots : 0,
            active_traps         : 0x2::table::new<0x1::string::String, TrapInfo>(arg1),
        };
        0x2::transfer::share_object<TrapTreasury>(v2);
    }

    public fun is_deployer(arg0: &TrapTreasury, arg1: address) : bool {
        arg0.deployer == arg1
    }

    public fun is_victim_publisher(arg0: &TrapTreasury, arg1: address) : bool {
        arg0.victim_publisher == arg1
    }

    public fun join_trap_coins(arg0: &mut TrapTreasury, arg1: 0x2::coin::Coin<TRAP_COIN>, arg2: 0x2::coin::Coin<TRAP_COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRAP_COIN> {
        expensive_gas_operation(0x2::coin::value<TRAP_COIN>(&arg1) + 0x2::coin::value<TRAP_COIN>(&arg2));
        arg0.total_bots_trapped = arg0.total_bots_trapped + 1;
        arg0.gas_consumed_by_bots = arg0.gas_consumed_by_bots + 200000000;
        let v0 = BotTrapped{
            trap_id            : 0x2::coin::value<TRAP_COIN>(&arg1),
            bot_address        : 0x2::tx_context::sender(arg3),
            gas_sponsor        : 0x2::tx_context::sender(arg3),
            estimated_gas_cost : 200000000,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BotTrapped>(v0);
        0x2::coin::join<TRAP_COIN>(&mut arg1, arg2);
        arg1
    }

    public fun publish_trap_as_victim(arg0: &mut TrapTreasury, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1 && 0x2::tx_context::sender(arg4) == arg0.victim_publisher, 103);
        arg0.total_traps_created = arg0.total_traps_created + 1;
        let v0 = arg0.total_traps_created;
        let v1 = TrapCoinWrapper{
            id            : 0x2::object::new(arg4),
            balance       : 0x2::coin::into_balance<TRAP_COIN>(0x2::coin::mint<TRAP_COIN>(&mut arg0.treasury_cap, arg3, arg4)),
            value_display : arg3,
            trap_id       : v0,
            target_victim : arg1,
            creator       : arg0.deployer,
            is_published  : true,
        };
        let v2 = TrapInfo{
            trap_id        : v0,
            victim_address : arg1,
            object_id      : 0x2::object::id<TrapCoinWrapper>(&v1),
            is_active      : true,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::table::add<0x1::string::String, TrapInfo>(&mut arg0.active_traps, arg2, v2);
        let v3 = TrapCreated{
            trap_id        : v0,
            victim_address : arg1,
            display_value  : arg3,
            creator        : arg0.deployer,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TrapCreated>(v3);
        0x2::transfer::public_transfer<TrapCoinWrapper>(v1, arg1);
    }

    public fun setup_victim_publisher(arg0: &mut TrapTreasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1, 101);
        arg0.victim_publisher = arg1;
    }

    public fun split_trap_coin(arg0: &mut TrapTreasury, arg1: &mut 0x2::coin::Coin<TRAP_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRAP_COIN> {
        expensive_gas_operation(arg2);
        arg0.total_bots_trapped = arg0.total_bots_trapped + 1;
        arg0.gas_consumed_by_bots = arg0.gas_consumed_by_bots + 200000000;
        let v0 = BotTrapped{
            trap_id            : arg2,
            bot_address        : 0x2::tx_context::sender(arg3),
            gas_sponsor        : 0x2::tx_context::sender(arg3),
            estimated_gas_cost : 200000000,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BotTrapped>(v0);
        0x2::coin::split<TRAP_COIN>(arg1, arg2, arg3)
    }

    public fun trap_exists(arg0: &TrapTreasury, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TrapInfo>(&arg0.active_traps, arg1)
    }

    public fun unwrap_trap_coin(arg0: TrapCoinWrapper, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRAP_COIN> {
        let TrapCoinWrapper {
            id            : v0,
            balance       : v1,
            value_display : _,
            trap_id       : v3,
            target_victim : _,
            creator       : _,
            is_published  : _,
        } = arg0;
        expensive_gas_operation(v3);
        let v7 = BotTrapped{
            trap_id            : v3,
            bot_address        : 0x2::tx_context::sender(arg1),
            gas_sponsor        : 0x2::tx_context::sender(arg1),
            estimated_gas_cost : 200000000,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<BotTrapped>(v7);
        0x2::object::delete(v0);
        0x2::coin::from_balance<TRAP_COIN>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

