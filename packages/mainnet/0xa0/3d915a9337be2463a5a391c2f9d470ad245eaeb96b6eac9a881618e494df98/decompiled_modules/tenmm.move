module 0xa03d915a9337be2463a5a391c2f9d470ad245eaeb96b6eac9a881618e494df98::tenmm {
    struct TENMM has drop {
        dummy_field: bool,
    }

    struct GenesisLock has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<TENMM>,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        rewards: 0x2::balance::Balance<TENMM>,
        cap: 0x2::coin::TreasuryCap<TENMM>,
        total_minted: u64,
        block_height: u64,
        last_block_ts: u64,
    }

    struct FeePot has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Market has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tenmm: 0x2::balance::Balance<TENMM>,
    }

    struct Holder has copy, drop, store {
        principal: u64,
        owed: u64,
        joined_ts: u64,
        last_settled_block: u64,
    }

    struct HolderRegistry has key {
        id: 0x2::object::UID,
        holders: 0x2::table::Table<address, Holder>,
        addresses: vector<address>,
        total_principal: u64,
    }

    public fun block_height(arg0: &RewardPool) : u64 {
        arg0.block_height
    }

    public fun block_time_secs() : u64 {
        600
    }

    public entry fun buy(arg0: &mut RewardPool, arg1: &mut Market, arg2: &mut FeePot, arg3: &mut HolderRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 0);
        let v1 = v0 * 30 / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg6)));
        let v2 = v0 - v1;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui);
        let v4 = 0x2::balance::value<TENMM>(&arg1.tenmm);
        let v5 = if (v2 > 0) {
            if (v3 > 0) {
                v4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 5);
        let v6 = v4 * v2 / (v3 + v2);
        assert!(v6 > 0 && v6 <= v4, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v7 = 0x2::tx_context::sender(arg6);
        settle_or_add(arg3, arg0, v7, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v8 = 0x2::table::borrow_mut<address, Holder>(&mut arg3.holders, v7);
        v8.principal = v8.principal + v6;
        arg3.total_principal = arg3.total_principal + v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(0x2::coin::from_balance<TENMM>(0x2::balance::split<TENMM>(&mut arg1.tenmm, v6), arg6), v7);
    }

    public entry fun claim(arg0: &mut RewardPool, arg1: &mut HolderRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Holder>(&arg1.holders, v0), 3);
        settle(arg1, arg0, v0, 0x2::clock::timestamp_ms(arg2) / 1000);
        let v1 = 0x2::table::borrow_mut<address, Holder>(&mut arg1.holders, v0);
        let v2 = v1.owed;
        v1.owed = 0;
        if (v2 > 0) {
            assert!(v2 <= 0x2::balance::value<TENMM>(&arg0.rewards), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(0x2::coin::from_balance<TENMM>(0x2::balance::split<TENMM>(&mut arg0.rewards, v2), arg3), v0);
        };
    }

    public fun decimals() : u8 {
        8
    }

    fun distribute_mined_rewards(arg0: &mut HolderRegistry, arg1: &mut RewardPool, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.addresses)) {
            let v1 = *0x1::vector::borrow<address>(&arg0.addresses, v0);
            let v2 = 0x2::table::borrow_mut<address, Holder>(&mut arg0.holders, v1);
            let v3 = reward_quote(v2.principal, arg0.total_principal, arg2, arg3, v2.joined_ts, arg4);
            v2.last_settled_block = arg3;
            if (v3 > 0) {
                assert!(v3 <= 0x2::balance::value<TENMM>(&arg1.rewards), 5);
                0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(0x2::coin::from_balance<TENMM>(0x2::balance::split<TENMM>(&mut arg1.rewards, v3), arg5), v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun emission_between(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        let v0 = arg0;
        let v1 = 0;
        while (v0 < arg1) {
            let v2 = (v0 / 210000 + 1) * 210000;
            let v3 = if (arg1 < v2) {
                arg1
            } else {
                v2
            };
            v1 = v1 + (v3 - arg0) * subsidy_at_height(arg0);
            v0 = v3;
        };
        v1
    }

    fun emission_between_slots(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        let v0 = arg0 + 1;
        let v1 = 0;
        while (v0 <= arg1) {
            if (v0 % arg2 == 0) {
                v1 = v1 + subsidy_at_height(v0 - 1);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun fee_bps() : u64 {
        30
    }

    public fun genesis_amount() : u64 {
        5000000000
    }

    public fun halving_interval() : u64 {
        210000
    }

    public fun holder_principal(arg0: &HolderRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, Holder>(&arg0.holders, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Holder>(&arg0.holders, arg1).principal
    }

    fun init(arg0: TENMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENMM>(arg0, 8, b"10MM", b"10MinMine", b"Bitcoin-style ten-minute mining coin with a 21 million hard cap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/2SECSUI/10MinMine/main/site/public/10mmLogo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENMM>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = GenesisLock{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<TENMM>(0x2::coin::mint<TENMM>(&mut v2, 5000000000, arg1)),
        };
        0x2::transfer::freeze_object<GenesisLock>(v3);
        let v4 = RewardPool{
            id            : 0x2::object::new(arg1),
            rewards       : 0x2::balance::zero<TENMM>(),
            cap           : v2,
            total_minted  : 5000000000,
            block_height  : 0,
            last_block_ts : 0,
        };
        let v5 = FeePot{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v6 = Market{
            id    : 0x2::object::new(arg1),
            sui   : 0x2::balance::zero<0x2::sui::SUI>(),
            tenmm : 0x2::balance::zero<TENMM>(),
        };
        let v7 = HolderRegistry{
            id              : 0x2::object::new(arg1),
            holders         : 0x2::table::new<address, Holder>(arg1),
            addresses       : 0x1::vector::empty<address>(),
            total_principal : 0,
        };
        0x2::transfer::share_object<RewardPool>(v4);
        0x2::transfer::share_object<FeePot>(v5);
        0x2::transfer::share_object<Market>(v6);
        0x2::transfer::share_object<HolderRegistry>(v7);
    }

    public fun initial_subsidy() : u64 {
        5000000000
    }

    public fun max_catch_up_blocks() : u64 {
        1008
    }

    public fun max_supply() : u64 {
        2100000000000000
    }

    public entry fun mine(arg0: &mut RewardPool, arg1: &mut HolderRegistry, arg2: &mut FeePot, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = arg0.last_block_ts == 0;
        let v2 = if (v0 > arg0.last_block_ts) {
            v0 - arg0.last_block_ts
        } else {
            0
        };
        let v3 = if (v1) {
            1
        } else {
            v2 / 600
        };
        let v4 = v3;
        if (v3 > 1008) {
            v4 = 1008;
        };
        assert!(v4 > 0, 2);
        let v5 = arg0.block_height;
        let v6 = v5 + v4;
        let v7 = emission_between(v5, v6);
        arg0.block_height = v6;
        let v8 = if (v1) {
            v0
        } else {
            arg0.last_block_ts + v4 * 600
        };
        arg0.last_block_ts = v8;
        if (v7 > 0) {
            assert!(arg0.total_minted + v7 <= 2100000000000000, 1);
            arg0.total_minted = arg0.total_minted + v7;
            if (arg1.total_principal == 0) {
                let v9 = 0x2::tx_context::sender(arg4);
                settle_or_add(arg1, arg0, v9, v0);
                let v10 = 0x2::table::borrow_mut<address, Holder>(&mut arg1.holders, v9);
                v10.principal = v10.principal + v7;
                v10.last_settled_block = v6;
                arg1.total_principal = arg1.total_principal + v7;
                0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(0x2::coin::mint<TENMM>(&mut arg0.cap, v7, arg4), v9);
            } else {
                0x2::balance::join<TENMM>(&mut arg0.rewards, 0x2::coin::into_balance<TENMM>(0x2::coin::mint<TENMM>(&mut arg0.cap, v7, arg4)));
                distribute_mined_rewards(arg1, arg0, v5, v6, v0, arg4);
            };
        };
        let v11 = if (0x2::balance::value<0x2::sui::SUI>(&arg2.balance) >= 1000000) {
            1000000
        } else {
            0
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance, v11), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public fun owed_rewards(arg0: &HolderRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, Holder>(&arg0.holders, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Holder>(&arg0.holders, arg1).owed
    }

    public entry fun protocol_transfer(arg0: &mut RewardPool, arg1: &mut HolderRegistry, arg2: 0x2::coin::Coin<TENMM>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Holder>(&arg1.holders, v0), 3);
        let v1 = 0x2::coin::value<TENMM>(&arg2);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        settle_or_add(arg1, arg0, v0, v2);
        settle_or_add(arg1, arg0, arg3, v2);
        let v3 = 0x2::table::borrow_mut<address, Holder>(&mut arg1.holders, v0);
        assert!(v1 <= v3.principal, 0);
        v3.principal = v3.principal - v1;
        let v4 = 0x2::table::borrow_mut<address, Holder>(&mut arg1.holders, arg3);
        v4.principal = v4.principal + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(arg2, arg3);
    }

    public entry fun push_rewards(arg0: &mut RewardPool, arg1: &mut HolderRegistry, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, Holder>(&arg1.holders, v1)) {
                settle(arg1, arg0, v1, 0x2::clock::timestamp_ms(arg3) / 1000);
                let v2 = 0x2::table::borrow<address, Holder>(&arg1.holders, v1).owed;
                let v3 = if (v2 > 0x2::balance::value<TENMM>(&arg0.rewards)) {
                    0x2::balance::value<TENMM>(&arg0.rewards)
                } else {
                    v2
                };
                if (v3 > 0) {
                    let v4 = 0x2::table::borrow_mut<address, Holder>(&mut arg1.holders, v1);
                    v4.owed = v4.owed - v3;
                    0x2::transfer::public_transfer<0x2::coin::Coin<TENMM>>(0x2::coin::from_balance<TENMM>(0x2::balance::split<TENMM>(&mut arg0.rewards, v3), arg4), v1);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun reward_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<TENMM>(&arg0.rewards)
    }

    public fun reward_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg3 <= arg2
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg5 > arg4) {
            arg5 - arg4
        } else {
            0
        };
        let v2 = v1 / 31536000;
        let v3 = if (v2 >= 10) {
            11
        } else {
            v2 + 1
        };
        (((emission_between_slots(arg2, arg3, v3) as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    public entry fun seed_liquidity(arg0: &mut Market, arg1: &RewardPool, arg2: &mut HolderRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<TENMM>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 0);
        let v0 = 0x2::coin::value<TENMM>(&arg4);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, Holder>(&arg2.holders, v1), 3);
        settle(arg2, arg1, v1, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v2 = 0x2::table::borrow_mut<address, Holder>(&mut arg2.holders, v1);
        assert!(v0 <= v2.principal, 0);
        v2.principal = v2.principal - v0;
        arg2.total_principal = arg2.total_principal - v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0x2::balance::join<TENMM>(&mut arg0.tenmm, 0x2::coin::into_balance<TENMM>(arg4));
    }

    public entry fun sell(arg0: &mut RewardPool, arg1: &mut Market, arg2: &mut HolderRegistry, arg3: 0x2::coin::Coin<TENMM>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Holder>(&arg2.holders, v0), 3);
        settle(arg2, arg0, v0, 0x2::clock::timestamp_ms(arg4) / 1000);
        let v1 = 0x2::coin::value<TENMM>(&arg3);
        let v2 = 0x2::table::borrow_mut<address, Holder>(&mut arg2.holders, v0);
        assert!(v1 <= v2.principal, 0);
        v2.principal = v2.principal - v1;
        let v3 = v2.owed;
        v2.owed = 0;
        arg2.total_principal = arg2.total_principal - v1;
        let v4 = 0x2::coin::into_balance<TENMM>(arg3);
        if (v3 > 0) {
            assert!(v3 <= 0x2::balance::value<TENMM>(&arg0.rewards), 5);
            0x2::balance::join<TENMM>(&mut v4, 0x2::balance::split<TENMM>(&mut arg0.rewards, v3));
        };
        let v5 = 0x2::balance::value<TENMM>(&v4);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui);
        let v7 = 0x2::balance::value<TENMM>(&arg1.tenmm);
        let v8 = if (v5 > 0) {
            if (v6 > 0) {
                v7 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 5);
        let v9 = v6 * v5 / (v7 + v5);
        assert!(v9 > 0 && v9 <= v6, 5);
        0x2::balance::join<TENMM>(&mut arg1.tenmm, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, v9), arg5), v0);
    }

    fun settle(arg0: &mut HolderRegistry, arg1: &RewardPool, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, Holder>(&mut arg0.holders, arg2);
        v0.owed = v0.owed + reward_quote(v0.principal, arg0.total_principal, v0.last_settled_block, arg1.block_height, v0.joined_ts, arg3);
        v0.last_settled_block = arg1.block_height;
    }

    fun settle_or_add(arg0: &mut HolderRegistry, arg1: &RewardPool, arg2: address, arg3: u64) {
        if (0x2::table::contains<address, Holder>(&arg0.holders, arg2)) {
            settle(arg0, arg1, arg2, arg3);
        } else {
            let v0 = Holder{
                principal          : 0,
                owed               : 0,
                joined_ts          : arg3,
                last_settled_block : arg1.block_height,
            };
            0x2::table::add<address, Holder>(&mut arg0.holders, arg2, v0);
            0x1::vector::push_back<address>(&mut arg0.addresses, arg2);
        };
    }

    public fun subsidy_at_height(arg0: u64) : u64 {
        let v0 = arg0 / 210000;
        if (v0 >= 64) {
            return 0
        };
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 * 2;
            v2 = v2 + 1;
        };
        5000000000 / v1
    }

    public fun total_minted(arg0: &RewardPool) : u64 {
        arg0.total_minted
    }

    public fun unit() : u64 {
        100000000
    }

    // decompiled from Move bytecode v7
}

