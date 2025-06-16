module 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    struct AdminCapability has store, key {
        id: 0x2::object::UID,
    }

    struct MainConfig has store, key {
        id: 0x2::object::UID,
        fee_recipient: address,
        open_market_fee: u64,
        finalize_market_fee_bps: u64,
        curator_finalizing_cooldown: u64,
        admin_key_id: address,
    }

    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        curator: address,
        market_open: u64,
        market_only_whitelist: u64,
        market_close: u64,
        soft_cap: u64,
        hard_cap: u64,
        tick_spacing: u32,
        total_priority_cap: u64,
        cap_per_address: u64,
        presale_rate_x64: u128,
        initialize_price_x64: u128,
        priority_rate_x64: u128,
        add_liquidity_bps: u64,
        lp_lock_period: u64,
        is_auto_add_liquidity: bool,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        priority_caps: 0x2::table::Table<address, u64>,
        contributions: 0x2::table::Table<address, u64>,
        is_finalized: bool,
        contributed: u64,
        total_claimable_x: u64,
        admin_public_key: vector<u8>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
        timestamp_last_ms: u64,
    }

    struct Proof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        contributed_y: u64,
        claimable_x: u64,
    }

    struct Locker<T0> has store, key {
        id: 0x2::object::UID,
        item: T0,
        unlock_at: u64,
    }

    struct MarketCreated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        market_open: u64,
        market_only_whitelist: u64,
        market_close: u64,
        soft_cap: u64,
        hard_cap: u64,
        tick_spacing: u32,
        total_priority_cap: u64,
        cap_per_address: u64,
        presale_rate_x64: u128,
        initialize_price_x64: u128,
        priority_rate_x64: u128,
        add_liquidity_bps: u64,
        lp_lock_period: u64,
        is_auto_add_liquidity: bool,
        admin_public_key: vector<u8>,
    }

    struct PriorityCapsUpdated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
    }

    struct MarketContributed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        timestamp: u64,
        amount: u64,
        coin_y_address: address,
        sender: address,
        proof_address: address,
        reached_priority_cap: bool,
    }

    struct MarketFinalized<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        finalize_time: u64,
        lp_unlock_time: u64,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct MarketClaimed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        clamable_x: u64,
        recipient: address,
    }

    struct MarketRefunded<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        recipient: address,
    }

    struct LpVaultCreated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        lp_vault_address: address,
        curator: address,
        pool_address: address,
        initialize_price: u128,
        amount_y: u64,
        amount_x: u64,
        position_id: 0x2::object::ID,
    }

    fun add<T0, T1>(arg0: &mut Market<T0, T1>, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (0x2::table::contains<address, u64>(&arg0.priority_caps, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.priority_caps, v0) = v1;
                continue
            };
            0x2::table::add<address, u64>(&mut arg0.priority_caps, v0, v1);
        };
        let v2 = PriorityCapsUpdated<T0, T1>{market_address: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<PriorityCapsUpdated<T0, T1>>(v2);
    }

    public fun add_priority_caps<T0, T1>(arg0: &AdminCapability, arg1: &mut Market<T0, T1>, arg2: vector<address>, arg3: vector<u64>) {
        add<T0, T1>(arg1, arg2, arg3);
    }

    public fun admin_key_id(arg0: &MainConfig) : address {
        arg0.admin_key_id
    }

    fun calculate_ticks(arg0: u128, arg1: u32) : (u32, u32) {
        let v0 = 443636 - 443636 % arg1;
        (4294967295 - v0 + 1, v0)
    }

    public fun claim<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Proof<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_finalized, 9);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 8);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : v2,
            claimable_x   : v3,
        } = arg1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = MarketClaimed<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v4),
            contributed_y  : v2,
            clamable_x     : v3,
            recipient      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MarketClaimed<T0, T1>>(v5);
        0x2::coin::take<T0>(&mut arg0.balance_x, arg1.claimable_x, arg2)
    }

    fun collect_finalize_market_fee<T0, T1>(arg0: &MainConfig, arg1: &mut Market<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, arg1.contributed * arg0.finalize_market_fee_bps / 10000), arg2), arg0.fee_recipient);
    }

    fun collect_open_market_fee<T0>(arg0: &MainConfig, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.open_market_fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.fee_recipient);
    }

    public fun contribute<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Proof<T0, T1>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.is_finalized, 2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.market_open && v1 <= arg0.market_close, 3);
        let v2 = false;
        let v3 = false;
        if (v1 < arg0.market_only_whitelist && arg0.contributed < arg0.total_priority_cap) {
            assert!(is_priority_address<T0, T1>(arg0, v0), 4);
            v2 = true;
        } else {
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.signatures, arg3), 11);
            assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.admin_public_key, &arg2) == true, 12);
            0x2::table::add<vector<u8>, bool>(&mut arg0.signatures, arg3, true);
        };
        let v4 = effective_amount<T0, T1>(arg0, v0, 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1)), v2);
        arg0.contributed = arg0.contributed + v4;
        if (v2 && arg0.contributed == arg0.total_priority_cap) {
            v3 = true;
        };
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v4, arg5)));
        let v5 = arg0.presale_rate_x64;
        if (v2) {
            v5 = arg0.priority_rate_x64;
        };
        let v6 = ((18446744073709551616 * (v4 as u128) / v5) as u64);
        arg0.total_claimable_x = arg0.total_claimable_x + v6;
        arg0.timestamp_last_ms = v1;
        let v7 = Proof<T0, T1>{
            id            : 0x2::object::new(arg5),
            market_id     : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            contributed_y : v4,
            claimable_x   : v6,
        };
        let v8 = MarketContributed<T0, T1>{
            market_address       : 0x2::object::uid_to_address(&arg0.id),
            timestamp            : v1,
            amount               : v4,
            coin_y_address       : 0x2::object::id_address<0x2::coin::Coin<T1>>(&arg1),
            sender               : v0,
            proof_address        : 0x2::object::id_address<Proof<T0, T1>>(&v7),
            reached_priority_cap : v3,
        };
        0x2::event::emit<MarketContributed<T0, T1>>(v8);
        (v7, arg1)
    }

    public fun create_market<T0, T1>(arg0: &MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: 0x2::coin::Coin<T0>, arg16: 0x2::coin::Coin<T1>, arg17: vector<address>, arg18: vector<u64>, arg19: vector<u8>, arg20: &mut 0x2::tx_context::TxContext) {
        validate_params(arg0, arg4, arg5, arg7, arg11, arg9, arg10, arg12, 0x2::coin::value<T0>(&arg15), arg14);
        collect_open_market_fee<T1>(arg0, arg16);
        let v0 = Market<T0, T1>{
            id                    : 0x2::object::new(arg20),
            curator               : 0x2::tx_context::sender(arg20),
            market_open           : arg1,
            market_only_whitelist : arg2,
            market_close          : arg3,
            soft_cap              : arg4,
            hard_cap              : arg5,
            tick_spacing          : arg6,
            total_priority_cap    : arg7,
            cap_per_address       : arg8,
            presale_rate_x64      : arg9,
            initialize_price_x64  : arg10,
            priority_rate_x64     : arg11,
            add_liquidity_bps     : arg12,
            lp_lock_period        : arg13,
            is_auto_add_liquidity : arg14,
            balance_x             : 0x2::coin::into_balance<T0>(arg15),
            balance_y             : 0x2::balance::zero<T1>(),
            priority_caps         : 0x2::table::new<address, u64>(arg20),
            contributions         : 0x2::table::new<address, u64>(arg20),
            is_finalized          : false,
            contributed           : 0,
            total_claimable_x     : 0,
            admin_public_key      : arg19,
            signatures            : 0x2::table::new<vector<u8>, bool>(arg20),
            timestamp_last_ms     : 0,
        };
        let v1 = &mut v0;
        add<T0, T1>(v1, arg17, arg18);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
        let v2 = MarketCreated<T0, T1>{
            market_address        : 0x2::object::uid_to_address(&v0.id),
            market_open           : arg1,
            market_only_whitelist : arg2,
            market_close          : arg3,
            soft_cap              : arg4,
            hard_cap              : arg5,
            tick_spacing          : arg6,
            total_priority_cap    : arg7,
            cap_per_address       : arg8,
            presale_rate_x64      : arg9,
            initialize_price_x64  : arg10,
            priority_rate_x64     : arg11,
            add_liquidity_bps     : arg12,
            lp_lock_period        : arg13,
            is_auto_add_liquidity : arg14,
            admin_public_key      : arg19,
        };
        0x2::event::emit<MarketCreated<T0, T1>>(v2);
    }

    public fun curator_finalizing_cooldown(arg0: &MainConfig) : u64 {
        arg0.curator_finalizing_cooldown
    }

    fun effective_amount<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.contributed > arg0.total_priority_cap) {
            v0 = arg0.total_priority_cap - arg0.contributed;
        };
        if (v0 + arg0.contributed > arg0.hard_cap) {
            v0 = arg0.hard_cap - arg0.contributed;
        };
        if (!0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        if (arg3 && v0 + *v1 > *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1) - *v1;
        };
        if (arg0.cap_per_address == 0) {
            return v0
        };
        if (!arg3 && v0 + *v1 > arg0.cap_per_address) {
            v0 = arg0.cap_per_address - *v1;
        };
        assert!(v0 != 0, 5);
        *v1 = *v1 + v0;
        v0
    }

    public fun fee_recipient(arg0: &MainConfig) : address {
        arg0.fee_recipient
    }

    public fun finalize_market<T0, T1>(arg0: &MainConfig, arg1: &mut Market<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::LpVault<T0, T1> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::balance::value<T1>(&arg1.balance_y);
        assert!(v1 == arg1.hard_cap || v1 >= arg1.soft_cap && v0 > arg1.market_close, 9);
        if (v1 == arg1.hard_cap && v0 < arg1.timestamp_last_ms + arg0.curator_finalizing_cooldown || v0 < arg1.market_close + arg0.curator_finalizing_cooldown) {
            assert!(arg1.curator == 0x2::tx_context::sender(arg7), 10);
        };
        assert!(!arg1.is_finalized, 2);
        arg1.is_finalized = true;
        let v2 = @0x0;
        let v3 = 0;
        let v4 = 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::new_lp_vault<T0, T1>(0x2::bag::new(arg7), arg1.curator, arg1.admin_public_key, arg0.admin_key_id, arg7);
        if (arg1.is_auto_add_liquidity) {
            let v5 = arg1.add_liquidity_bps * v1 / 10000;
            let v6 = ((18446744073709551616 * (v5 as u128) / arg1.initialize_price_x64) as u64);
            let v7 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
            let v8 = 0x1::ascii::as_bytes(&v7);
            let v9 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            let v10 = 0x1::ascii::as_bytes(&v9);
            let v11 = 0;
            let v12 = false;
            while (v11 < 0x1::vector::length<u8>(v8)) {
                let v13 = *0x1::vector::borrow<u8>(v8, v11);
                let v14 = *0x1::vector::borrow<u8>(v10, v11);
                if (v14 < v13) {
                    break
                };
                if (v14 > v13) {
                    v12 = true;
                    break
                };
                v11 = v11 + 1;
            };
            if (v12) {
                let v15 = sqrt(340282366920938463463374607431768211456 * (v5 as u256) / (v6 as u256));
                v3 = v15;
                let (v16, v17) = calculate_ticks(v15, arg1.tick_spacing);
                let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg2, arg3, arg1.tick_spacing, v15, 0x1::string::utf8(b""), v16, v17, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v6), arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v5), arg7), arg4, arg5, true, arg6, arg7);
                let v21 = v18;
                let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v21);
                let v23 = 0x2::object::id_to_address(&v22);
                v2 = v23;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v20));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v19));
                0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::add_position<T0, T1>(&mut v4, v21);
                let v24 = 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::id<T0, T1>(&v4);
                let v25 = LpVaultCreated<T0, T1>{
                    market_address   : 0x2::object::id_address<Market<T0, T1>>(arg1),
                    lp_vault_address : 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::id_to_address(&v24),
                    curator          : arg1.curator,
                    pool_address     : v23,
                    initialize_price : v15,
                    amount_y         : v5,
                    amount_x         : v6,
                    position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v21),
                };
                0x2::event::emit<LpVaultCreated<T0, T1>>(v25);
            } else {
                let v26 = sqrt(340282366920938463463374607431768211456 * (v6 as u256) / (v5 as u256));
                v3 = v26;
                let (v27, v28) = calculate_ticks(v26, arg1.tick_spacing);
                let (v29, v30, v31) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg2, arg3, arg1.tick_spacing, v26, 0x1::string::utf8(b""), v27, v28, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v5), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v6), arg7), arg5, arg4, false, arg6, arg7);
                let v32 = v29;
                let v33 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v32);
                let v34 = 0x2::object::id_to_address(&v33);
                v2 = v34;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v30));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v31));
                0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::add_position<T0, T1>(&mut v4, v32);
                let v35 = 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::id<T0, T1>(&v4);
                let v36 = LpVaultCreated<T0, T1>{
                    market_address   : 0x2::object::id_address<Market<T0, T1>>(arg1),
                    lp_vault_address : 0xd80f208a6efaf5274b0ff8a916a4b6a4c5576091f7c14fd0ab507d7df2bdd7ac::vault::id_to_address(&v35),
                    curator          : arg1.curator,
                    pool_address     : v34,
                    initialize_price : v26,
                    amount_y         : v5,
                    amount_x         : v6,
                    position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v32),
                };
                0x2::event::emit<LpVaultCreated<T0, T1>>(v36);
            };
        };
        collect_finalize_market_fee<T0, T1>(arg0, arg1, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, 0x2::balance::value<T0>(&arg1.balance_x) - arg1.total_claimable_x), arg7), arg1.curator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.balance_y), arg7), arg1.curator);
        let v37 = MarketFinalized<T0, T1>{
            market_address     : 0x2::object::id_address<Market<T0, T1>>(arg1),
            finalize_time      : v0,
            lp_unlock_time     : v0 + arg1.lp_lock_period,
            cetus_pool_address : v2,
            initialize_price   : v3,
        };
        0x2::event::emit<MarketFinalized<T0, T1>>(v37);
        v4
    }

    public fun finalize_market_fee_bps(arg0: &MainConfig) : u64 {
        arg0.finalize_market_fee_bps
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: &AdminCapability, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MainConfig{
            id                          : 0x2::object::new(arg5),
            fee_recipient               : 0x2::tx_context::sender(arg5),
            open_market_fee             : arg1,
            finalize_market_fee_bps     : arg2,
            curator_finalizing_cooldown : arg3,
            admin_key_id                : arg4,
        };
        0x2::transfer::share_object<MainConfig>(v0);
    }

    public fun is_priority_address<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.priority_caps, arg1)
    }

    fun lock<T0>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Locker<T0> {
        Locker<T0>{
            id        : 0x2::object::new(arg2),
            item      : arg0,
            unlock_at : arg1,
        }
    }

    public fun open_market_fee(arg0: &MainConfig) : u64 {
        arg0.open_market_fee
    }

    public fun refund<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Proof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.market_close, 6);
        assert!(arg0.contributed < arg0.soft_cap, 7);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 8);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : v2,
            claimable_x   : _,
        } = arg1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = MarketRefunded<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v4),
            contributed_y  : v2,
            recipient      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketRefunded<T0, T1>>(v5);
        0x2::coin::take<T1>(&mut arg0.balance_y, arg1.contributed_y, arg3)
    }

    public fun refund_to_curator<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.curator == 0x2::tx_context::sender(arg2), 10);
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.market_close, 6);
        assert!(arg0.contributed < arg0.soft_cap, 7);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_x), arg2)
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun unlock<T0>(arg0: Locker<T0>, arg1: &0x2::clock::Clock) : T0 {
        let Locker {
            id        : v0,
            item      : v1,
            unlock_at : v2,
        } = arg0;
        assert!(v2 <= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::object::delete(v0);
        v1
    }

    fun validate_params(arg0: &MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: bool) {
        assert!(arg1 <= arg2, 1);
        assert!(arg3 <= arg2, 1);
        assert!(arg7 + arg0.finalize_market_fee_bps <= 10000, 1);
        let v0 = 0;
        if (arg9) {
            v0 = ((18446744073709551616 * ((arg2 * arg7 / 10000) as u128) / arg6) as u64);
        };
        assert!(((18446744073709551616 * (arg3 as u128) / arg4) as u64) + ((18446744073709551616 * ((arg2 - arg3) as u128) / arg5) as u64) + v0 <= arg8, 1);
    }

    // decompiled from Move bytecode v6
}

