module 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::subscription {
    struct SUBSCRIPTION has drop {
        dummy_field: bool,
    }

    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        curator: address,
        market_open: u64,
        market_only_whitelist: u64,
        market_close: u64,
        soft_cap: u64,
        total_priority_cap: u64,
        cap_per_address: u64,
        tick_spacing: u32,
        initialize_price_x64: u128,
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
        total_claimable_y: u64,
        admin_public_key: vector<u8>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
        timestamp_last_ms: u64,
    }

    struct Proof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        contributed_y: u64,
    }

    struct MarketCreated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        market_open: u64,
        market_only_whitelist: u64,
        market_close: u64,
        total_claimable_x: u64,
        soft_cap: u64,
        total_priority_cap: u64,
        cap_per_address: u64,
        initialize_price_x64: u128,
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

    public fun add_priority_caps<T0, T1>(arg0: &mut Market<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.curator == 0x2::tx_context::sender(arg3), 10);
        add<T0, T1>(arg0, arg1, arg2);
    }

    fun calculate_ticks(arg0: u32) : (u32, u32) {
        let v0 = 443636 - 443636 % arg0;
        (4294967295 - v0 + 1, v0)
    }

    public fun claim<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Proof<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.is_finalized, 9);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 8);
        let v0 = (((arg0.total_claimable_x as u128) * (arg1.contributed_y as u128) / (arg0.contributed as u128)) as u64);
        let Proof {
            id            : v1,
            market_id     : _,
            contributed_y : v3,
        } = arg1;
        let v4 = v1;
        0x2::object::delete(v4);
        let v5 = MarketClaimed<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v4),
            contributed_y  : v3,
            clamable_x     : v0,
            recipient      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MarketClaimed<T0, T1>>(v5);
        (0x2::coin::take<T0>(&mut arg0.balance_x, v0, arg2), 0x2::coin::take<T1>(&mut arg0.balance_y, (((arg0.total_claimable_y as u128) * (arg1.contributed_y as u128) / (arg0.contributed as u128)) as u64), arg2))
    }

    fun collect_finalize_market_fee<T0, T1>(arg0: &0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::MainConfig, arg1: &mut Market<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, arg1.contributed * 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::finalize_market_fee_bps(arg0) / 10000), arg2), 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::fee_recipient(arg0));
    }

    fun collect_open_market_fee<T0>(arg0: &0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::MainConfig, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::open_market_fee(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::fee_recipient(arg0));
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
        arg0.timestamp_last_ms = v1;
        let v5 = Proof<T0, T1>{
            id            : 0x2::object::new(arg5),
            market_id     : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            contributed_y : v4,
        };
        let v6 = MarketContributed<T0, T1>{
            market_address       : 0x2::object::uid_to_address(&arg0.id),
            timestamp            : v1,
            amount               : v4,
            coin_y_address       : 0x2::object::id_address<0x2::coin::Coin<T1>>(&arg1),
            sender               : v0,
            proof_address        : 0x2::object::id_address<Proof<T0, T1>>(&v5),
            reached_priority_cap : v3,
        };
        0x2::event::emit<MarketContributed<T0, T1>>(v6);
        (v5, arg1)
    }

    public fun create_market<T0, T1>(arg0: &0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: bool, arg13: 0x2::coin::Coin<T0>, arg14: 0x2::coin::Coin<T1>, arg15: vector<address>, arg16: vector<u64>, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        validate_params(arg0, arg5, arg9, arg10, 0x2::coin::value<T0>(&arg13), arg12, arg4);
        collect_open_market_fee<T1>(arg0, arg14);
        let v0 = Market<T0, T1>{
            id                    : 0x2::object::new(arg18),
            curator               : 0x2::tx_context::sender(arg18),
            market_open           : arg1,
            market_only_whitelist : arg2,
            market_close          : arg3,
            soft_cap              : arg5,
            total_priority_cap    : arg7,
            cap_per_address       : arg8,
            tick_spacing          : arg6,
            initialize_price_x64  : arg9,
            add_liquidity_bps     : arg10,
            lp_lock_period        : arg11,
            is_auto_add_liquidity : arg12,
            balance_x             : 0x2::coin::into_balance<T0>(arg13),
            balance_y             : 0x2::balance::zero<T1>(),
            priority_caps         : 0x2::table::new<address, u64>(arg18),
            contributions         : 0x2::table::new<address, u64>(arg18),
            is_finalized          : false,
            contributed           : 0,
            total_claimable_x     : arg4,
            total_claimable_y     : 0,
            admin_public_key      : arg17,
            signatures            : 0x2::table::new<vector<u8>, bool>(arg18),
            timestamp_last_ms     : 0,
        };
        let v1 = &mut v0;
        add<T0, T1>(v1, arg15, arg16);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
        let v2 = MarketCreated<T0, T1>{
            market_address        : 0x2::object::uid_to_address(&v0.id),
            market_open           : arg1,
            market_only_whitelist : arg2,
            market_close          : arg3,
            total_claimable_x     : arg4,
            soft_cap              : arg5,
            total_priority_cap    : arg7,
            cap_per_address       : arg8,
            initialize_price_x64  : arg9,
            add_liquidity_bps     : arg10,
            lp_lock_period        : arg11,
            is_auto_add_liquidity : arg12,
            admin_public_key      : arg17,
        };
        0x2::event::emit<MarketCreated<T0, T1>>(v2);
    }

    fun effective_amount<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.contributed > arg0.total_priority_cap) {
            v0 = arg0.total_priority_cap - arg0.contributed;
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

    public fun finalize_market<T0, T1>(arg0: &0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::MainConfig, arg1: &mut Market<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x2::balance::value<T1>(&arg1.balance_y) >= arg1.soft_cap && v0 > arg1.market_close, 9);
        if (v0 < arg1.market_close + 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::curator_finalizing_cooldown(arg0)) {
            assert!(arg1.curator == 0x2::tx_context::sender(arg7), 10);
        };
        assert!(!arg1.is_finalized, 2);
        arg1.is_finalized = true;
        let v1 = @0x0;
        let v2 = 0;
        if (arg1.is_auto_add_liquidity) {
            let v3 = arg1.add_liquidity_bps * arg1.soft_cap / 10000;
            let v4 = ((18446744073709551616 * (v3 as u128) / arg1.initialize_price_x64) as u64);
            let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
            let v6 = 0x1::ascii::as_bytes(&v5);
            let v7 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            let v8 = 0x1::ascii::as_bytes(&v7);
            let v9 = 0;
            let v10 = false;
            while (v9 < 0x1::vector::length<u8>(v6)) {
                let v11 = *0x1::vector::borrow<u8>(v6, v9);
                let v12 = *0x1::vector::borrow<u8>(v8, v9);
                if (v12 < v11) {
                    break
                };
                if (v12 > v11) {
                    v10 = true;
                    break
                };
                v9 = v9 + 1;
            };
            if (v10) {
                let v13 = sqrt(340282366920938463463374607431768211456 * (v3 as u256) / (v4 as u256));
                v2 = v13;
                let (v14, v15) = calculate_ticks(arg1.tick_spacing);
                let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg2, arg3, arg1.tick_spacing, v13, 0x1::string::utf8(b""), v14, v15, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v4), arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v3), arg7), arg4, arg5, true, arg6, arg7);
                let v19 = v16;
                let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v19);
                let v21 = 0x2::object::id_to_address(&v20);
                v1 = v21;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v18));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v17));
                0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_lp_vault_created<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg1.id), 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::vault::new_lp_vault<T0, T1>(v19, arg1.lp_lock_period + v0, arg1.curator, arg1.admin_public_key, 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::admin_key_id(arg0), arg7), arg1.curator, v21, v13, v3, v4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v19));
            } else {
                let v22 = sqrt(340282366920938463463374607431768211456 * (v4 as u256) / (v3 as u256));
                v2 = v22;
                let (v23, v24) = calculate_ticks(arg1.tick_spacing);
                let (v25, v26, v27) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg2, arg3, arg1.tick_spacing, v22, 0x1::string::utf8(b""), v23, v24, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v3), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v4), arg7), arg5, arg4, false, arg6, arg7);
                let v28 = v25;
                let v29 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v28);
                let v30 = 0x2::object::id_to_address(&v29);
                v1 = v30;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v26));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v27));
                0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::emit_lp_vault_created<T0, T1>(0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::events::get_id(&arg1.id), 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::vault::new_lp_vault<T0, T1>(v28, arg1.lp_lock_period + v0, arg1.curator, arg1.admin_public_key, 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::admin_key_id(arg0), arg7), arg1.curator, v30, v22, v3, v4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v28));
            };
        };
        collect_finalize_market_fee<T0, T1>(arg0, arg1, arg7);
        let v31 = arg1.soft_cap - arg1.soft_cap * 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::finalize_market_fee_bps(arg0) / 10000;
        let v32 = v31;
        if (arg1.is_auto_add_liquidity) {
            v32 = v31 - arg1.soft_cap * arg1.add_liquidity_bps / 10000;
        };
        arg1.total_claimable_y = 0x2::balance::value<T1>(&arg1.balance_y);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, 0x2::balance::value<T0>(&arg1.balance_x) - arg1.total_claimable_x), arg7), arg1.curator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v32), arg7), arg1.curator);
        let v33 = MarketFinalized<T0, T1>{
            market_address     : 0x2::object::id_address<Market<T0, T1>>(arg1),
            finalize_time      : v0,
            lp_unlock_time     : v0 + arg1.lp_lock_period,
            cetus_pool_address : v1,
            initialize_price   : v2,
        };
        0x2::event::emit<MarketFinalized<T0, T1>>(v33);
    }

    fun init(arg0: SUBSCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_priority_address<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.priority_caps, arg1)
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
        } = arg1;
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = MarketRefunded<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v3),
            contributed_y  : v2,
            recipient      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketRefunded<T0, T1>>(v4);
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

    fun validate_params(arg0: &0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::MainConfig, arg1: u64, arg2: u128, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        assert!(arg3 + 0xae012e163e956a1c4f61b326dc8e7159381bfeb5f81fc755f6a915ce63332fa6::main::finalize_market_fee_bps(arg0) <= 10000, 1);
        let v0 = 0;
        if (arg5) {
            v0 = ((18446744073709551616 * ((arg1 * arg3 / 10000) as u128) / arg2) as u64);
        };
        assert!(arg6 + v0 <= arg4, 1);
    }

    // decompiled from Move bytecode v6
}

