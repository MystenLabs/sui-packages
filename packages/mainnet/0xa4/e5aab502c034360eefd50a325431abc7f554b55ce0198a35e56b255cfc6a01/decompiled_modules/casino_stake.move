module 0x9f01c4e45d80a37ef1053b341bbbe5dcc84a02a09e1a7f4fb59e5806b5da22b5::casino_stake {
    struct CasinoStake has key {
        id: 0x2::object::UID,
        player: address,
        amount: u64,
        tier: u8,
        lock_until: u64,
        staked_at: u64,
        balance: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
    }

    struct StakeRegistry has key {
        id: 0x2::object::UID,
        stakes: 0x2::table::Table<0x2::object::ID, StakeRecord>,
        count: u64,
    }

    struct StakeRecord has drop, store {
        player: address,
        amount: u64,
        tier: u8,
        lock_until: u64,
        staked_at: u64,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        player: address,
        amount: u64,
        tier: u8,
        lock_until: u64,
        staked_at: u64,
    }

    struct StakeRemoved has copy, drop {
        stake_id: 0x2::object::ID,
        player: address,
        amount: u64,
        tier: u8,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct StakeRegistered has copy, drop {
        stake_id: 0x2::object::ID,
        player: address,
        amount: u64,
        tier: u8,
    }

    public entry fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeRegistry{
            id     : 0x2::object::new(arg0),
            stakes : 0x2::table::new<0x2::object::ID, StakeRecord>(arg0),
            count  : 0,
        };
        let v1 = RegistryCreated{registry_id: 0x2::object::id<StakeRegistry>(&v0)};
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<StakeRegistry>(v0);
    }

    public entry fun register_existing_stake(arg0: &mut StakeRegistry, arg1: &CasinoStake, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CasinoStake>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, StakeRecord>(&arg0.stakes, v0), 3);
        let v1 = StakeRecord{
            player     : arg1.player,
            amount     : arg1.amount,
            tier       : arg1.tier,
            lock_until : arg1.lock_until,
            staked_at  : arg1.staked_at,
        };
        0x2::table::add<0x2::object::ID, StakeRecord>(&mut arg0.stakes, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = StakeRegistered{
            stake_id : v0,
            player   : arg1.player,
            amount   : arg1.amount,
            tier     : arg1.tier,
        };
        0x2::event::emit<StakeRegistered>(v2);
    }

    public fun registry_contains(arg0: &StakeRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, StakeRecord>(&arg0.stakes, arg1)
    }

    public fun registry_count(arg0: &StakeRegistry) : u64 {
        arg0.count
    }

    public entry fun stake(arg0: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 1);
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0);
        assert!(v0 >= 10000000000000, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (arg1 == 1) {
            7
        } else if (arg1 == 2) {
            30
        } else {
            90
        };
        let v3 = v1 + v2 * 86400000;
        let v4 = CasinoStake{
            id         : 0x2::object::new(arg3),
            player     : 0x2::tx_context::sender(arg3),
            amount     : v0,
            tier       : arg1,
            lock_until : v3,
            staked_at  : v1,
            balance    : 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg0),
        };
        let v5 = StakeCreated{
            stake_id   : 0x2::object::id<CasinoStake>(&v4),
            player     : 0x2::tx_context::sender(arg3),
            amount     : v0,
            tier       : arg1,
            lock_until : v3,
            staked_at  : v1,
        };
        0x2::event::emit<StakeCreated>(v5);
        0x2::transfer::transfer<CasinoStake>(v4, 0x2::tx_context::sender(arg3));
    }

    public fun stake_amount(arg0: &CasinoStake) : u64 {
        arg0.amount
    }

    public fun stake_lock_until(arg0: &CasinoStake) : u64 {
        arg0.lock_until
    }

    public fun stake_player(arg0: &CasinoStake) : address {
        arg0.player
    }

    public fun stake_tier(arg0: &CasinoStake) : u8 {
        arg0.tier
    }

    public entry fun stake_v2(arg0: &mut StakeRegistry, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 3, 1);
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (arg2 == 1) {
            7
        } else if (arg2 == 2) {
            30
        } else {
            90
        };
        let v3 = v1 + v2 * 86400000;
        let v4 = CasinoStake{
            id         : 0x2::object::new(arg4),
            player     : 0x2::tx_context::sender(arg4),
            amount     : v0,
            tier       : arg2,
            lock_until : v3,
            staked_at  : v1,
            balance    : 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1),
        };
        let v5 = 0x2::object::id<CasinoStake>(&v4);
        let v6 = StakeRecord{
            player     : 0x2::tx_context::sender(arg4),
            amount     : v0,
            tier       : arg2,
            lock_until : v3,
            staked_at  : v1,
        };
        0x2::table::add<0x2::object::ID, StakeRecord>(&mut arg0.stakes, v5, v6);
        arg0.count = arg0.count + 1;
        let v7 = StakeCreated{
            stake_id   : v5,
            player     : 0x2::tx_context::sender(arg4),
            amount     : v0,
            tier       : arg2,
            lock_until : v3,
            staked_at  : v1,
        };
        0x2::event::emit<StakeCreated>(v7);
        0x2::transfer::transfer<CasinoStake>(v4, 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake(arg0: CasinoStake, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lock_until, 0);
        let CasinoStake {
            id         : v0,
            player     : v1,
            amount     : v2,
            tier       : v3,
            lock_until : _,
            staked_at  : _,
            balance    : v6,
        } = arg0;
        let v7 = v0;
        let v8 = StakeRemoved{
            stake_id : 0x2::object::uid_to_inner(&v7),
            player   : v1,
            amount   : v2,
            tier     : v3,
        };
        0x2::event::emit<StakeRemoved>(v8);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v6, arg2), v1);
    }

    public entry fun unstake_v2(arg0: &mut StakeRegistry, arg1: CasinoStake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.lock_until, 0);
        let CasinoStake {
            id         : v0,
            player     : v1,
            amount     : v2,
            tier       : v3,
            lock_until : _,
            staked_at  : _,
            balance    : v6,
        } = arg1;
        let v7 = v0;
        let v8 = 0x2::object::uid_to_inner(&v7);
        if (0x2::table::contains<0x2::object::ID, StakeRecord>(&arg0.stakes, v8)) {
            0x2::table::remove<0x2::object::ID, StakeRecord>(&mut arg0.stakes, v8);
            arg0.count = arg0.count - 1;
        };
        let v9 = StakeRemoved{
            stake_id : v8,
            player   : v1,
            amount   : v2,
            tier     : v3,
        };
        0x2::event::emit<StakeRemoved>(v9);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v6, arg3), v1);
    }

    // decompiled from Move bytecode v7
}

