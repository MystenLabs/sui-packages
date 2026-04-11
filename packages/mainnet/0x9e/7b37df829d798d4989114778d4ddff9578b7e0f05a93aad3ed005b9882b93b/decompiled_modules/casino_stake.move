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

    // decompiled from Move bytecode v7
}

