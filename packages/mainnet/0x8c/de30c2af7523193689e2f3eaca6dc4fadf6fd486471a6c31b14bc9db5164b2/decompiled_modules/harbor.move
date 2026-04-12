module 0x8cde30c2af7523193689e2f3eaca6dc4fadf6fd486471a6c31b14bc9db5164b2::harbor {
    struct Harbor has key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
        vessel_limit: u64,
        vessel_count: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        created_at: u64,
        last_movement: u64,
        total_in: u64,
        total_out: u64,
    }

    struct HarborCap has store, key {
        id: 0x2::object::UID,
        harbor_id: 0x2::object::ID,
        owner: address,
        tier: u8,
    }

    struct HarborOpened has copy, drop {
        harbor_id: address,
        owner: address,
        tier: u8,
        opened_at: u64,
    }

    struct HarborFueled has copy, drop {
        harbor_id: address,
        amount: u64,
        balance: u64,
        fueled_at: u64,
    }

    struct HarborDrained has copy, drop {
        harbor_id: address,
        amount: u64,
        balance: u64,
        drained_at: u64,
    }

    struct HarborUpgraded has copy, drop {
        harbor_id: address,
        old_tier: u8,
        new_tier: u8,
        new_limit: u64,
        upgraded_at: u64,
    }

    struct HarborCrumbled has copy, drop {
        harbor_id: address,
        balance_lost: u64,
        crumbled_at: u64,
    }

    public fun balance(arg0: &Harbor) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun drain(arg0: &mut Harbor, arg1: &HarborCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg1.harbor_id == 0x2::object::id<Harbor>(arg0), 2);
        assert!(is_alive(arg0, arg3), 1);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg2, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.last_movement = v0;
        arg0.total_out = arg0.total_out + arg2;
        let v1 = 0x2::object::id<Harbor>(arg0);
        let v2 = HarborDrained{
            harbor_id  : 0x2::object::id_to_address(&v1),
            amount     : arg2,
            balance    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance),
            drained_at : v0,
        };
        0x2::event::emit<HarborDrained>(v2);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg4)
    }

    public fun expires_at(arg0: &Harbor) : u64 {
        arg0.last_movement + 31536000000
    }

    public fun fuel(arg0: &mut Harbor, arg1: &HarborCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.harbor_id == 0x2::object::id<Harbor>(arg0), 2);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        arg0.last_movement = v1;
        arg0.total_in = arg0.total_in + v0;
        let v2 = 0x2::object::id<Harbor>(arg0);
        let v3 = HarborFueled{
            harbor_id : 0x2::object::id_to_address(&v2),
            amount    : v0,
            balance   : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance),
            fueled_at : v1,
        };
        0x2::event::emit<HarborFueled>(v3);
    }

    public fun has_balance(arg0: &Harbor, arg1: u64) : bool {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg1
    }

    public fun has_vessel_capacity(arg0: &Harbor) : bool {
        arg0.vessel_count < arg0.vessel_limit
    }

    public fun is_alive(arg0: &Harbor, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.last_movement + 31536000000
    }

    public fun last_movement(arg0: &Harbor) : u64 {
        arg0.last_movement
    }

    public fun minimum_balance() : u64 {
        100000
    }

    public fun open(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : HarborCap {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else {
            arg1 == 4
        };
        assert!(v0, 5);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        assert!(v1 >= tier_cost(arg1) + 100000, 6);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = Harbor{
            id            : 0x2::object::new(arg3),
            owner         : v2,
            tier          : arg1,
            vessel_limit  : tier_limit(arg1),
            vessel_count  : 0,
            balance       : 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0),
            created_at    : v3,
            last_movement : v3,
            total_in      : v1,
            total_out     : 0,
        };
        let v5 = 0x2::object::id<Harbor>(&v4);
        let v6 = HarborOpened{
            harbor_id : 0x2::object::id_to_address(&v5),
            owner     : v2,
            tier      : arg1,
            opened_at : v3,
        };
        0x2::event::emit<HarborOpened>(v6);
        let v7 = HarborCap{
            id        : 0x2::object::new(arg3),
            harbor_id : v5,
            owner     : v2,
            tier      : arg1,
        };
        0x2::transfer::transfer<Harbor>(v4, v2);
        v7
    }

    public fun owner(arg0: &Harbor) : address {
        arg0.owner
    }

    public fun register_vessel(arg0: &mut Harbor, arg1: &HarborCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.harbor_id == 0x2::object::id<Harbor>(arg0), 2);
        assert!(is_alive(arg0, arg2), 1);
        assert!(arg0.vessel_count < arg0.vessel_limit, 4);
        arg0.vessel_count = arg0.vessel_count + 1;
        arg0.last_movement = 0x2::clock::timestamp_ms(arg2);
    }

    public fun release_vessel(arg0: &mut Harbor, arg1: &HarborCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.harbor_id == 0x2::object::id<Harbor>(arg0), 2);
        if (arg0.vessel_count > 0) {
            arg0.vessel_count = arg0.vessel_count - 1;
        };
    }

    public fun tier(arg0: &Harbor) : u8 {
        arg0.tier
    }

    public fun tier_1() : u8 {
        1
    }

    public fun tier_2() : u8 {
        2
    }

    public fun tier_3() : u8 {
        3
    }

    public fun tier_4() : u8 {
        4
    }

    fun tier_cost(arg0: u8) : u64 {
        if (arg0 == 1) {
            50000
        } else if (arg0 == 2) {
            100000
        } else if (arg0 == 3) {
            200000
        } else {
            500000
        }
    }

    fun tier_limit(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            5
        } else if (arg0 == 3) {
            10
        } else {
            20
        }
    }

    public fun total_in(arg0: &Harbor) : u64 {
        arg0.total_in
    }

    public fun total_out(arg0: &Harbor) : u64 {
        arg0.total_out
    }

    public fun upgrade(arg0: &mut Harbor, arg1: &mut HarborCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.harbor_id == 0x2::object::id<Harbor>(arg0), 2);
        assert!(arg0.tier < 4, 7);
        let v0 = arg0.tier + 1;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) >= tier_cost(v0), 3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        arg0.tier = v0;
        arg0.vessel_limit = tier_limit(v0);
        arg0.last_movement = v1;
        arg1.tier = v0;
        let v2 = 0x2::object::id<Harbor>(arg0);
        let v3 = HarborUpgraded{
            harbor_id   : 0x2::object::id_to_address(&v2),
            old_tier    : arg0.tier,
            new_tier    : v0,
            new_limit   : arg0.vessel_limit,
            upgraded_at : v1,
        };
        0x2::event::emit<HarborUpgraded>(v3);
    }

    public fun vessel_count(arg0: &Harbor) : u64 {
        arg0.vessel_count
    }

    public fun vessel_limit(arg0: &Harbor) : u64 {
        arg0.vessel_limit
    }

    // decompiled from Move bytecode v6
}

