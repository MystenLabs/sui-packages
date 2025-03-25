module 0xcc1e7d279081dfa555c33a2c989c4ba120575a989657cf8d6a0e13f7381db45d::plhh {
    struct PLHH has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InfoEvent has copy, drop {
        message: vector<u8>,
        value: u64,
    }

    struct PreSaleConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PLHH>,
        current_phase: u8,
        phase_start_time: u64,
        total_sold: u64,
        market_cap_usd_cents: u64,
        presale_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        phase_prices: vector<u64>,
        phase_token_allocations: vector<u64>,
        phase_tokens_sold: vector<u64>,
    }

    struct StakeInfo has drop, store {
        amount: u64,
        start_epoch: u64,
        duration: u8,
        last_claim_epoch: u64,
    }

    struct StakePool has key {
        id: 0x2::object::UID,
        total_staked: u64,
        reward_pool: 0x2::balance::Balance<PLHH>,
        stakes: 0x2::table::Table<address, vector<StakeInfo>>,
        staker_list: vector<address>,
        last_distribution_epoch: u64,
    }

    struct TokensPurchased has copy, drop {
        buyer: address,
        amount: u64,
        phase: u8,
        price: u64,
        sui_price: u64,
    }

    struct PhaseAdvanced has copy, drop {
        new_phase: u8,
        start_time: u64,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        threshold_reached: u64,
    }

    public entry fun add_rewards(arg0: &mut StakePool, arg1: &mut 0x2::coin::Coin<PLHH>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<PLHH>(arg1) >= arg2, 21);
        0x2::balance::join<PLHH>(&mut arg0.reward_pool, 0x2::coin::into_balance<PLHH>(0x2::coin::split<PLHH>(arg1, arg2, arg3)));
    }

    public entry fun advance_phase(arg0: &mut PreSaleConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        assert!(arg0.current_phase < 9, 0);
        arg0.current_phase = arg0.current_phase + 1;
        arg0.phase_start_time = 0x2::tx_context::epoch(arg2);
        let v0 = PhaseAdvanced{
            new_phase  : arg0.current_phase,
            start_time : arg0.phase_start_time,
        };
        0x2::event::emit<PhaseAdvanced>(v0);
    }

    fun calculate_apy_rate(arg0: u8) : u64 {
        (arg0 as u64) * 1100
    }

    fun calculate_rewards(arg0: &StakeInfo, arg1: u64) : u64 {
        let v0 = arg1 - arg0.last_claim_epoch;
        if (v0 == 0) {
            return 0
        };
        (((arg0.amount as u128) * (calculate_apy_rate(arg0.duration) as u128) * (v0 as u128) / (365 as u128) / 10000) as u64)
    }

    public entry fun change_admin(arg0: &mut PreSaleConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 8);
        arg0.admin = arg2;
    }

    fun check_burn_thresholds(arg0: &mut PreSaleConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.market_cap_usd_cents;
        let v1 = 0;
        let v2 = 0;
        if (v0 >= 88800000000) {
            v1 = 10000000000000000;
            v2 = 88800000000;
        } else if (v0 >= 8800000000) {
            v1 = arg0.total_sold * 500 / 10000;
            v2 = 8800000000;
        } else if (v0 >= 2800000000) {
            v1 = arg0.total_sold * 300 / 10000;
            v2 = 2800000000;
        } else if (v0 >= 800000000) {
            v1 = arg0.total_sold * 200 / 10000;
            v2 = 800000000;
        };
        if (v1 > 0) {
            0x2::coin::burn<PLHH>(&mut arg0.treasury_cap, 0x2::coin::mint<PLHH>(&mut arg0.treasury_cap, v1, arg1));
            let v3 = TokensBurned{
                amount            : v1,
                threshold_reached : v2,
            };
            0x2::event::emit<TokensBurned>(v3);
        };
    }

    public entry fun claim_rewards(arg0: &mut StakePool, arg1: &mut PreSaleConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<StakeInfo>>(&arg0.stakes, v0), 22);
        let v1 = 0x2::table::borrow_mut<address, vector<StakeInfo>>(&mut arg0.stakes, v0);
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0;
        let v4 = 0x1::vector::length<StakeInfo>(v1);
        let v5 = InfoEvent{
            message : b"Total stakes being processed",
            value   : v4,
        };
        0x2::event::emit<InfoEvent>(v5);
        let v6 = 0;
        while (v6 < v4) {
            let v7 = 0x1::vector::borrow_mut<StakeInfo>(v1, v6);
            let v8 = calculate_rewards(v7, v2);
            v3 = v3 + v8;
            v7.last_claim_epoch = v2;
            let v9 = InfoEvent{
                message : b"Processing stake index",
                value   : v6,
            };
            0x2::event::emit<InfoEvent>(v9);
            let v10 = InfoEvent{
                message : b"Rewards for this stake",
                value   : v8,
            };
            0x2::event::emit<InfoEvent>(v10);
            v6 = v6 + 1;
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PLHH>>(0x2::coin::mint<PLHH>(&mut arg1.treasury_cap, v3, arg2), v0);
            let v11 = InfoEvent{
                message : b"Total rewards minted and claimed",
                value   : v3,
            };
            0x2::event::emit<InfoEvent>(v11);
        } else {
            let v12 = InfoEvent{
                message : b"No rewards available to claim",
                value   : 0,
            };
            0x2::event::emit<InfoEvent>(v12);
        };
    }

    public fun get_estimated_rewards(arg0: &StakePool, arg1: address, arg2: &0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<address, vector<StakeInfo>>(&arg0.stakes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<StakeInfo>>(&arg0.stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeInfo>(v0)) {
            v1 = v1 + calculate_rewards(0x1::vector::borrow<StakeInfo>(v0, v2), 0x2::tx_context::epoch(arg2));
            v2 = v2 + 1;
        };
        let v3 = InfoEvent{
            message : b"Total stakes found for staker",
            value   : v1,
        };
        0x2::event::emit<InfoEvent>(v3);
        v1
    }

    public entry fun get_stakes(arg0: &StakePool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        if (!0x2::table::contains<address, vector<StakeInfo>>(&arg0.stakes, arg1)) {
            let v0 = InfoEvent{
                message : b"Staker has no active stakes",
                value   : 0,
            };
            0x2::event::emit<InfoEvent>(v0);
            return 0x1::vector::empty<u64>()
        };
        let v1 = 0x2::table::borrow<address, vector<StakeInfo>>(&arg0.stakes, arg1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::length<StakeInfo>(v1);
        let v4 = InfoEvent{
            message : b"Total stakes found for staker",
            value   : v3,
        };
        0x2::event::emit<InfoEvent>(v4);
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<StakeInfo>(v1, v5);
            let v7 = InfoEvent{
                message : b"Processing stake index",
                value   : v5,
            };
            0x2::event::emit<InfoEvent>(v7);
            let v8 = InfoEvent{
                message : b"Stake amount",
                value   : v6.amount,
            };
            0x2::event::emit<InfoEvent>(v8);
            0x1::vector::push_back<u64>(&mut v2, v6.amount);
            v5 = v5 + 1;
        };
        let v9 = InfoEvent{
            message : b"Completed retrieving stakes",
            value   : v3,
        };
        0x2::event::emit<InfoEvent>(v9);
        v2
    }

    fun init(arg0: PLHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLHH>(arg0, 9, b"PLHH", b"Peace, Love & Harmony Coin", b"A Real-World Asset-backed cryptocurrency built on the SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7gy5m5dlxtbhhuulhyt7u6vhk5e7rjvjjmdmui5lr4aofdtnzmq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLHH>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = PreSaleConfig{
            id                      : 0x2::object::new(arg1),
            treasury_cap            : v0,
            current_phase           : 1,
            phase_start_time        : 0x2::tx_context::epoch(arg1),
            total_sold              : 0,
            market_cap_usd_cents    : 0,
            presale_funds           : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                   : 0x2::tx_context::sender(arg1),
            phase_prices            : vector[8, 12, 16, 20, 24, 28, 32, 36, 40],
            phase_token_allocations : vector[11111111000000000, 22222222000000000, 25000000000000000, 33333333000000000, 35555555000000000, 44444444000000000, 45678901000000000, 46654434000000000, 1000000000000000000],
            phase_tokens_sold       : vector[0, 0, 0, 0, 0, 0, 0, 0, 0],
        };
        0x2::transfer::share_object<PreSaleConfig>(v3);
    }

    public entry fun init_staking_pool(arg0: &PreSaleConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        let v0 = StakePool{
            id                      : 0x2::object::new(arg2),
            total_staked            : 0,
            reward_pool             : 0x2::balance::zero<PLHH>(),
            stakes                  : 0x2::table::new<address, vector<StakeInfo>>(arg2),
            staker_list             : 0x1::vector::empty<address>(),
            last_distribution_epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::share_object<StakePool>(v0);
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun purchase_tokens(arg0: &mut PreSaleConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        if (v0 >= arg0.phase_start_time + 1468800) {
            if (arg0.current_phase < 9) {
                arg0.current_phase = arg0.current_phase + 1;
                arg0.phase_start_time = v0;
                let v1 = PhaseAdvanced{
                    new_phase  : arg0.current_phase,
                    start_time : arg0.phase_start_time,
                };
                0x2::event::emit<PhaseAdvanced>(v1);
            };
        };
        assert!(arg0.current_phase <= 9, 0);
        assert!(v0 >= arg0.phase_start_time, 1);
        let v2 = *0x1::vector::borrow<u64>(&arg0.phase_prices, ((arg0.current_phase - 1) as u64));
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg4, arg1, 600);
        let v4 = ((arg0.current_phase - 1) as u64);
        let v5 = *0x1::vector::borrow<u64>(&arg0.phase_tokens_sold, v4);
        assert!(v5 + arg3 <= *0x1::vector::borrow<u64>(&arg0.phase_token_allocations, v4), 0);
        *0x1::vector::borrow_mut<u64>(&mut arg0.phase_tokens_sold, v4) = v5 + arg3;
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6);
        let v9 = if (v8) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v6)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6)
        };
        let v10 = if (v8) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7) * pow10((v9 as u8))
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7) / pow10((v9 as u8))
        };
        let v11 = v10 / 10000000;
        let v12 = (((v2 as u128) * 100000000 / 100 * 1000000000 / (v11 as u128) * (arg3 as u128) / 1000000000 * 10) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v12, 21);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.presale_funds, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v12));
        0x2::transfer::public_transfer<0x2::coin::Coin<PLHH>>(0x2::coin::mint<PLHH>(&mut arg0.treasury_cap, arg3, arg6), 0x2::tx_context::sender(arg6));
        arg0.total_sold = arg0.total_sold + arg3;
        arg0.market_cap_usd_cents = arg0.total_sold * v2 / 1000000000;
        let v13 = TokensPurchased{
            buyer     : 0x2::tx_context::sender(arg6),
            amount    : arg3,
            phase     : arg0.current_phase,
            price     : v2,
            sui_price : v11,
        };
        0x2::event::emit<TokensPurchased>(v13);
        check_burn_thresholds(arg0, arg6);
    }

    public entry fun purchase_tokens_fiat(arg0: &mut PreSaleConfig, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: address, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 8);
        let v0 = *0x1::vector::borrow<u64>(&arg0.phase_prices, ((arg0.current_phase - 1) as u64));
        assert!(arg1 >= v0 * arg2 / 100, 21);
        0x2::transfer::public_transfer<0x2::coin::Coin<PLHH>>(0x2::coin::mint<PLHH>(&mut arg0.treasury_cap, arg2, arg6), arg4);
        arg0.total_sold = arg0.total_sold + arg2;
        arg0.market_cap_usd_cents = arg0.total_sold * v0 / 1000000000;
        let v1 = TokensPurchased{
            buyer     : arg4,
            amount    : arg2,
            phase     : arg0.current_phase,
            price     : v0,
            sui_price : 0,
        };
        0x2::event::emit<TokensPurchased>(v1);
        let v2 = InfoEvent{
            message : arg3,
            value   : arg1,
        };
        0x2::event::emit<InfoEvent>(v2);
        check_burn_thresholds(arg0, arg6);
    }

    public entry fun reset_phase_time(arg0: &mut PreSaleConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        arg0.phase_start_time = 0x2::tx_context::epoch(arg2);
        let v0 = PhaseAdvanced{
            new_phase  : arg0.current_phase,
            start_time : arg0.phase_start_time,
        };
        0x2::event::emit<PhaseAdvanced>(v0);
    }

    public entry fun show_available_funds_admin(arg0: &PreSaleConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        let v0 = InfoEvent{
            message : b"Available presale funds",
            value   : 0x2::balance::value<0x2::sui::SUI>(&arg0.presale_funds),
        };
        0x2::event::emit<InfoEvent>(v0);
    }

    public entry fun stake(arg0: &mut StakePool, arg1: u64, arg2: u8, arg3: &mut 0x2::coin::Coin<PLHH>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 8, 20);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<PLHH>(arg3) >= arg1, 21);
        0x2::balance::join<PLHH>(&mut arg0.reward_pool, 0x2::coin::into_balance<PLHH>(0x2::coin::split<PLHH>(arg3, arg1, arg4)));
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = StakeInfo{
            amount           : arg1,
            start_epoch      : v1,
            duration         : arg2,
            last_claim_epoch : v1,
        };
        if (!0x2::table::contains<address, vector<StakeInfo>>(&arg0.stakes, v0)) {
            let v3 = 0x1::vector::empty<StakeInfo>();
            0x1::vector::push_back<StakeInfo>(&mut v3, v2);
            0x2::table::add<address, vector<StakeInfo>>(&mut arg0.stakes, v0, v3);
            0x1::vector::push_back<address>(&mut arg0.staker_list, v0);
        } else {
            0x1::vector::push_back<StakeInfo>(0x2::table::borrow_mut<address, vector<StakeInfo>>(&mut arg0.stakes, v0), v2);
        };
        arg0.total_staked = arg0.total_staked + arg1;
    }

    public entry fun unstake(arg0: &mut StakePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<StakeInfo>>(&arg0.stakes, v0), 22);
        let v1 = 0x2::table::borrow_mut<address, vector<StakeInfo>>(&mut arg0.stakes, v0);
        assert!(arg1 < 0x1::vector::length<StakeInfo>(v1), 23);
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0x1::vector::borrow<StakeInfo>(v1, arg1);
        let v4 = (v3.duration as u64) * 365;
        let v5 = v2 - v3.start_epoch;
        let v6 = 0x1::vector::remove<StakeInfo>(v1, arg1);
        let v7 = if (v5 >= v4) {
            0
        } else if (v5 < 30) {
            40
        } else if (v5 < 90) {
            30
        } else if (v5 < 180) {
            25
        } else if (v5 < 365) {
            20
        } else {
            0
        };
        let v8 = calculate_rewards(&v6, v2);
        arg0.total_staked = arg0.total_staked - v6.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<PLHH>>(0x2::coin::from_balance<PLHH>(0x2::balance::split<PLHH>(&mut arg0.reward_pool, v6.amount + v8 - v8 * v7 / 100), arg2), v0);
        if (0x1::vector::is_empty<StakeInfo>(v1)) {
            0x2::table::remove<address, vector<StakeInfo>>(&mut arg0.stakes, v0);
            let v9 = 0;
            let v10 = false;
            while (v9 < 0x1::vector::length<address>(&arg0.staker_list) && !v10) {
                if (*0x1::vector::borrow<address>(&arg0.staker_list, v9) == v0) {
                    0x1::vector::remove<address>(&mut arg0.staker_list, v9);
                    v10 = true;
                    continue
                };
                v9 = v9 + 1;
            };
        };
    }

    public entry fun withdraw_funds(arg0: &mut PreSaleConfig, arg1: &AdminCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 8);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.presale_funds)
        };
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.presale_funds), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.presale_funds, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

