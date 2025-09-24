module 0xd65f99e23b217ae40234870f70dc0ed0ee03d0243133c2769ad3c7e1b75dd4c8::cetus_aggregator_arbitrage {
    struct FlashLoanConfig has store, key {
        id: 0x2::object::UID,
        preferred_provider: u8,
        network_type: u8,
        navi_fee_bp: u64,
        scallop_fee_bp: u64,
        auto_select: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct LBTC has drop {
        dummy_field: bool,
    }

    struct WAL has drop {
        dummy_field: bool,
    }

    struct ReentrancyGuard has store, key {
        id: 0x2::object::UID,
        locked: bool,
    }

    struct PreValidatedArbitrageData has copy, drop {
        weighted_price: u64,
        price_confidence: u64,
        data_timestamp: u64,
        estimated_profit: u64,
        profit_percentage: u64,
        expected_output_buy: u64,
        expected_output_sell: u64,
        pools: vector<address>,
        pool_liquidities: vector<u64>,
        mev_risk_score: u64,
        frontrun_probability: u64,
        flash_loan_fee_bp: u64,
        validation_hash: vector<u8>,
        ecdsa_signature: vector<u8>,
        nonce: u64,
        bot_public_key: vector<u8>,
        bot_version: u8,
    }

    struct NonceTracker has store, key {
        id: 0x2::object::UID,
        used_nonces: 0x2::table::Table<u64, bool>,
        last_nonce: u64,
        admin: address,
    }

    struct SimplifiedMEVState has copy, drop {
        last_trade_timestamp: u64,
        hourly_trade_count: u64,
        risk_score: u64,
        frontrun_detected: bool,
    }

    struct FastUserHistory has store, key {
        id: 0x2::object::UID,
        user: address,
        last_trade_timestamp: u64,
        hourly_trade_count: u64,
        hourly_reset_timestamp: u64,
        risk_score: u64,
    }

    struct UltraFastArbitrageConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        reentrancy_guard_id: address,
        max_trade_amount: u64,
        mev_protection_enabled: bool,
        max_hourly_trades: u64,
        min_profit_basis_points: u64,
        max_slippage_basis_points: u64,
        whitelisted_pools: vector<address>,
        enabled_providers: vector<u8>,
        enabled_pairs: vector<u8>,
        max_gas_budget: u64,
        paused: bool,
        emergency_stop: bool,
    }

    struct FastFlashLoanReceipt<phantom T0> {
        amount: u64,
        fee: u64,
        provider: u8,
        timestamp: u64,
        trade_id: vector<u8>,
        expected_return: u64,
    }

    struct FastMEVBundle has copy, drop {
        transactions: vector<vector<u8>>,
        total_gas_budget: u64,
        priority_fee: u64,
        expected_profit: u64,
        bundle_id: vector<u8>,
        mev_protection_score: u64,
    }

    struct UltraFastArbitrageExecuted has copy, drop {
        trade_id: vector<u8>,
        token_in_id: u8,
        token_out_id: u8,
        buy_pool_id: address,
        sell_pool_id: address,
        amount: u64,
        profit_amount: u64,
        profit_percentage: u64,
        execution_time_ms: u64,
        gas_used: u64,
        priority_fee_paid: u64,
        executor: address,
        flash_loan_provider: u8,
        bot_validation_passed: bool,
        mev_protection_score: u64,
    }

    struct FastSecurityViolation has copy, drop {
        violation_type: u8,
        severity: u8,
        executor: address,
        timestamp: u64,
    }

    struct FastFlashLoanExecuted has copy, drop {
        trade_id: vector<u8>,
        provider: u8,
        amount: u64,
        fee: u64,
        borrower: address,
        timestamp: u64,
    }

    struct MEVBundleSubmitted has copy, drop {
        bundle_size: u64,
        total_gas_budget: u64,
        priority_fee: u64,
        expected_profit: u64,
        submitter: address,
    }

    struct SwapExecuted has copy, drop {
        pool_id: address,
        pair: u8,
        amount_in: u64,
        amount_out: u64,
        slippage: u64,
        executor: address,
    }

    struct MEVViolationDetected has copy, drop {
        user: address,
        violation_type: u8,
        risk_score: u64,
        timestamp: u64,
    }

    struct SwapStep has copy, drop {
        token_in_id: u8,
        token_out_id: u8,
        dex_id: u8,
        pool_address: address,
        amount_in: u64,
        min_amount_out: u64,
        fee_rate: u64,
    }

    struct MultiHopRoute has copy, drop {
        steps: vector<SwapStep>,
        total_amount_in: u64,
        min_total_out: u64,
        route_id: vector<u8>,
        estimated_gas: u64,
        flash_loan_fee_bp: u64,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        admin: address,
        pools: 0x2::table::Table<address, PoolInfo>,
        total_pools: u64,
    }

    struct PoolInfo has copy, drop, store {
        dex_id: u8,
        token_in_id: u8,
        token_out_id: u8,
        fee_rate: u64,
        is_active: bool,
        liquidity_estimate: u64,
        last_updated: u64,
    }

    public fun acquire_lock(arg0: &mut ReentrancyGuard) {
        assert!(!arg0.locked, 1010);
        arg0.locked = true;
    }

    public entry fun add_pool_to_registry(arg0: &mut Registry, arg1: address, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 1016);
        assert!(arg2 >= 1 && arg2 <= 5, 1001);
        assert!(arg3 >= 1 && arg3 <= 4, 1001);
        assert!(arg4 >= 1 && arg4 <= 4, 1001);
        assert!(arg3 != arg4, 1001);
        let v0 = PoolInfo{
            dex_id             : arg2,
            token_in_id        : arg3,
            token_out_id       : arg4,
            fee_rate           : arg5,
            is_active          : true,
            liquidity_estimate : arg6,
            last_updated       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::table::add<address, PoolInfo>(&mut arg0.pools, arg1, v0);
        arg0.total_pools = arg0.total_pools + 1;
    }

    public entry fun add_whitelisted_pools(arg0: &mut UltraFastArbitrageConfig, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1006);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.whitelisted_pools, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelisted_pools, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun borrow_from_navi_ultra_fast<T0>(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FastFlashLoanReceipt<T0>) {
        let v0 = arg0 * arg1 / 10000;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 >= arg0 + v0, 1005);
        let v2 = FastFlashLoanReceipt<T0>{
            amount          : arg0,
            fee             : v0,
            provider        : 1,
            timestamp       : v1,
            trade_id        : arg2,
            expected_return : arg3,
        };
        let v3 = FastFlashLoanExecuted{
            trade_id  : arg2,
            provider  : 1,
            amount    : arg0,
            fee       : v0,
            borrower  : 0x2::tx_context::sender(arg5),
            timestamp : v1,
        };
        0x2::event::emit<FastFlashLoanExecuted>(v3);
        (0x2::coin::zero<T0>(arg5), v2)
    }

    public fun borrow_from_scallop_ultra_fast<T0>(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FastFlashLoanReceipt<T0>) {
        let v0 = arg0 * arg1 / 10000;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 >= arg0 + v0, 1005);
        let v2 = FastFlashLoanReceipt<T0>{
            amount          : arg0,
            fee             : v0,
            provider        : 2,
            timestamp       : v1,
            trade_id        : arg2,
            expected_return : arg3,
        };
        let v3 = FastFlashLoanExecuted{
            trade_id  : arg2,
            provider  : 2,
            amount    : arg0,
            fee       : v0,
            borrower  : 0x2::tx_context::sender(arg5),
            timestamp : v1,
        };
        0x2::event::emit<FastFlashLoanExecuted>(v3);
        (0x2::coin::zero<T0>(arg5), v2)
    }

    fun build_multi_hop_route_from_arrays(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: u64) : MultiHopRoute {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(0x1::vector::length<u8>(&arg1) == v0, 1001);
        assert!(0x1::vector::length<u8>(&arg2) == v0, 1001);
        assert!(0x1::vector::length<address>(&arg3) == v0, 1001);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 1001);
        assert!(0x1::vector::length<u64>(&arg5) == v0, 1001);
        assert!(0x1::vector::length<u64>(&arg6) == v0, 1001);
        let v1 = 0x1::vector::empty<SwapStep>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = SwapStep{
                token_in_id    : *0x1::vector::borrow<u8>(&arg0, v2),
                token_out_id   : *0x1::vector::borrow<u8>(&arg1, v2),
                dex_id         : *0x1::vector::borrow<u8>(&arg2, v2),
                pool_address   : *0x1::vector::borrow<address>(&arg3, v2),
                amount_in      : *0x1::vector::borrow<u64>(&arg4, v2),
                min_amount_out : *0x1::vector::borrow<u64>(&arg5, v2),
                fee_rate       : *0x1::vector::borrow<u64>(&arg6, v2),
            };
            0x1::vector::push_back<SwapStep>(&mut v1, v3);
            v2 = v2 + 1;
        };
        MultiHopRoute{
            steps             : v1,
            total_amount_in   : arg7,
            min_total_out     : arg8,
            route_id          : b"multi_hop_route",
            estimated_gas     : calculate_fast_gas_budget(arg7),
            flash_loan_fee_bp : 0,
        }
    }

    fun calculate_fast_gas_budget(arg0: u64) : u64 {
        if (arg0 > 10000000) {
            180000000 + 20000000
        } else {
            180000000
        }
    }

    fun calculate_fast_gas_used(arg0: u64) : u64 {
        if (arg0 > 1000000) {
            120000 + 30000
        } else {
            120000
        }
    }

    public entry fun cleanup_old_nonces(arg0: &mut NonceTracker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1016);
        arg0.last_nonce = arg1;
    }

    fun create_bot_signature(arg0: u64, arg1: u64, arg2: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, (arg0 as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v0, (arg1 as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg1 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v0, 66);
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + arg1) as u8));
        v0
    }

    public fun create_enhanced_bot_signature(arg0: u64, arg1: u64, arg2: u64, arg3: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg2));
        0x2::hash::keccak256(&v0)
    }

    public fun create_fast_user_history(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : FastUserHistory {
        FastUserHistory{
            id                     : 0x2::object::new(arg1),
            user                   : arg0,
            last_trade_timestamp   : 0,
            hourly_trade_count     : 0,
            hourly_reset_timestamp : 0,
            risk_score             : 0,
        }
    }

    fun create_multi_hop_bot_data(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : PreValidatedArbitrageData {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0 * 1000);
        0x1::vector::push_back<u64>(v1, arg0 * 1000);
        let v2 = if (arg5 > 50) {
            80
        } else {
            20
        };
        PreValidatedArbitrageData{
            weighted_price       : arg1,
            price_confidence     : arg2,
            data_timestamp       : arg3,
            estimated_profit     : arg4,
            profit_percentage    : arg4 * 10000 / arg0,
            expected_output_buy  : arg0,
            expected_output_sell : arg0 + arg4,
            pools                : vector[@0x0, @0x1],
            pool_liquidities     : v0,
            mev_risk_score       : arg5,
            frontrun_probability : v2,
            flash_loan_fee_bp    : 8,
            validation_hash      : create_bot_signature(arg1, arg3, 0x2::tx_context::sender(arg6)),
            ecdsa_signature      : 0x1::vector::empty<u8>(),
            nonce                : 0,
            bot_public_key       : 0x1::vector::empty<u8>(),
            bot_version          : 3,
        }
    }

    public fun create_reentrancy_guard(arg0: &mut 0x2::tx_context::TxContext) : ReentrancyGuard {
        ReentrancyGuard{
            id     : 0x2::object::new(arg0),
            locked : false,
        }
    }

    public entry fun create_user_history(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FastUserHistory{
            id                     : 0x2::object::new(arg0),
            user                   : 0x2::tx_context::sender(arg0),
            last_trade_timestamp   : 0,
            hourly_trade_count     : 0,
            hourly_reset_timestamp : 0,
            risk_score             : 0,
        };
        0x2::transfer::share_object<FastUserHistory>(v0);
    }

    public entry fun create_user_history_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        0x2::transfer::share_object<FastUserHistory>(create_fast_user_history(v0, arg0));
    }

    fun create_validation_message(arg0: &PreValidatedArbitrageData, arg1: u64, arg2: u64, arg3: u64, arg4: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg0.estimated_profit));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg0.mev_risk_score));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg0.flash_loan_fee_bp));
        0x1::vector::append<u8>(&mut v0, 0x1::vector::singleton<u8>(arg0.bot_version));
        v0
    }

    public entry fun emergency_pause_ultra_fast(arg0: &mut UltraFastArbitrageConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1006);
        arg0.paused = true;
        arg0.emergency_stop = true;
        let v0 = FastSecurityViolation{
            violation_type : 255,
            severity       : 4,
            executor       : 0x2::tx_context::sender(arg1),
            timestamp      : 0,
        };
        0x2::event::emit<FastSecurityViolation>(v0);
    }

    fun execute_cetus_swap<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0 == 1 && arg1 == 2) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 1) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 1 && arg1 == 3) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 3 && arg1 == 1) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 3 && arg1 == 2) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 3) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 1 && arg1 == 4) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 4 && arg1 == 1) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 4 && arg1 == 2) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 4) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 3 && arg1 == 4) {
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        } else {
            assert!(arg0 == 4 && arg1 == 3, 1001);
            mock_swap_cetus<T0, T1>(arg3, arg4, arg6)
        }
    }

    fun execute_magma_swap<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0 == 1 && arg1 == 2) {
            mock_swap_magma<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 1) {
            mock_swap_magma<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 3 && arg1 == 2) {
            mock_swap_magma<T0, T1>(arg3, arg4, arg6)
        } else {
            assert!(arg0 == 2 && arg1 == 3, 1001);
            mock_swap_magma<T0, T1>(arg3, arg4, arg6)
        }
    }

    fun execute_momentum_swap<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0 == 1 && arg1 == 2) {
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 1) {
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 1 && arg1 == 3) {
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 3 && arg1 == 1) {
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 1 && arg1 == 4) {
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        } else {
            assert!(arg0 == 4 && arg1 == 1, 1001);
            mock_swap_momentum<T0, T1>(arg3, arg4, arg6)
        }
    }

    public fun execute_multi_hop_arbitrage(arg0: MultiHopRoute, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = &arg0.steps;
        let v1 = 0x1::vector::length<SwapStep>(v0);
        assert!(v1 > 0, 1001);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        let v3 = 0;
        let v4 = 1;
        while (v3 < v1) {
            let v5 = 0x1::vector::borrow<SwapStep>(v0, v3);
            assert!(v5.token_in_id == v4, 1001);
            assert!(v2 >= v5.amount_in, 1008);
            let v6 = execute_real_swap_step(v5, v2, arg2);
            v2 = v6;
            v4 = v5.token_out_id;
            assert!(v6 >= v5.min_amount_out, 1004);
            v3 = v3 + 1;
        };
        assert!(v4 == 1, 1001);
        assert!(v2 >= arg0.min_total_out, 1004);
        0x2::coin::zero<0x2::sui::SUI>(arg2)
    }

    public entry fun execute_multi_hop_flash_arbitrage(arg0: &mut UltraFastArbitrageConfig, arg1: &mut FastUserHistory, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg18);
        let v1 = build_multi_hop_route_from_arrays(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        validate_multi_hop_route(&v1);
        let v2 = create_multi_hop_bot_data(arg9, arg13, arg14, arg17, arg15, arg16, arg19);
        let v3 = fast_mev_check(arg1, v0, arg0);
        validate_multi_hop_params(arg0, &v1, arg11, &v2, &v3, v0, 0x2::tx_context::sender(arg19));
        let v4 = generate_fast_trade_id(0x2::tx_context::sender(arg19), v0, arg9);
        let (v5, v6) = if (arg11 == 1) {
            borrow_from_navi_ultra_fast<0x2::sui::SUI>(arg9, v1.flash_loan_fee_bp, v4, arg10, arg18, arg19)
        } else {
            borrow_from_scallop_ultra_fast<0x2::sui::SUI>(arg9, v1.flash_loan_fee_bp, v4, arg10, arg18, arg19)
        };
        let v7 = execute_multi_hop_arbitrage(v1, v5, arg19);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        let v9 = arg9 * v1.flash_loan_fee_bp / 10000;
        let v10 = if (v8 > arg9 + v9) {
            v8 - arg9 - v9
        } else {
            0
        };
        assert!(v10 >= arg15 / 2, 1005);
        repay_ultra_fast<0x2::sui::SUI>(v7, v6, arg19);
        fast_update_user(arg1, v0, v3.risk_score);
        let v11 = UltraFastArbitrageExecuted{
            trade_id              : v4,
            token_in_id           : 255,
            token_out_id          : 255,
            buy_pool_id           : *0x1::vector::borrow<address>(&arg5, 0),
            sell_pool_id          : *0x1::vector::borrow<address>(&arg5, 0x1::vector::length<address>(&arg5) - 1),
            amount                : arg9,
            profit_amount         : v10,
            profit_percentage     : v10 * 10000 / arg9,
            execution_time_ms     : 0x2::clock::timestamp_ms(arg18) - v0,
            gas_used              : calculate_fast_gas_used(arg9),
            priority_fee_paid     : arg12,
            executor              : 0x2::tx_context::sender(arg19),
            flash_loan_provider   : arg11,
            bot_validation_passed : true,
            mev_protection_score  : v3.risk_score,
        };
        0x2::event::emit<UltraFastArbitrageExecuted>(v11);
    }

    fun execute_real_swap_step(arg0: &SwapStep, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1 >= arg0.min_amount_out, 1008);
        assert!(arg0.dex_id >= 1 && arg0.dex_id <= 5, 1001);
        assert!(arg0.token_in_id >= 1 && arg0.token_in_id <= 4, 1001);
        assert!(arg0.token_out_id >= 1 && arg0.token_out_id <= 4, 1001);
        assert!(arg0.token_in_id != arg0.token_out_id, 1001);
        let v0 = arg1 * (10000 - arg0.fee_rate) / 10000;
        assert!(v0 >= arg0.min_amount_out, 1004);
        v0
    }

    fun execute_suilend_swap<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0 == 1 && arg1 == 2) {
            mock_swap_suilend<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 2 && arg1 == 1) {
            mock_swap_suilend<T0, T1>(arg3, arg4, arg6)
        } else if (arg0 == 4 && arg1 == 2) {
            mock_swap_suilend<T0, T1>(arg3, arg4, arg6)
        } else {
            assert!(arg0 == 2 && arg1 == 4, 1001);
            mock_swap_suilend<T0, T1>(arg3, arg4, arg6)
        }
    }

    fun execute_swap_step<T0, T1>(arg0: &SwapStep, arg1: 0x2::coin::Coin<T0>, arg2: &UltraFastArbitrageConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        execute_token_swap<T0, T1>(arg0.token_in_id, arg0.token_out_id, arg0.dex_id, arg0.pool_address, arg1, arg0.min_amount_out, arg0.fee_rate, arg2, arg3)
    }

    public fun execute_token_swap<T0, T1>(arg0: u8, arg1: u8, arg2: u8, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &UltraFastArbitrageConfig, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg4) > 0, 1008);
        assert!(arg6 <= 500, 1001);
        assert!(arg3 != @0x0, 1003);
        assert!(0x1::vector::contains<address>(&arg7.whitelisted_pools, &arg3), 1015);
        assert!(arg2 >= 1 && arg2 <= 5, 1001);
        assert!(arg0 >= 1 && arg0 <= 4, 1001);
        assert!(arg1 >= 1 && arg1 <= 4, 1001);
        assert!(arg0 != arg1, 1001);
        if (arg2 == 1) {
            execute_cetus_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8)
        } else if (arg2 == 2) {
            execute_turbos_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8)
        } else if (arg2 == 3) {
            execute_momentum_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8)
        } else if (arg2 == 4) {
            execute_magma_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8)
        } else {
            assert!(arg2 == 5, 1001);
            execute_suilend_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg8)
        }
    }

    fun execute_turbos_swap<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0 == 1 && arg1 == 2) {
            mock_swap_turbos<T0, T1>(arg3, arg4, arg6)
        } else {
            assert!(arg0 == 2 && arg1 == 1, 1001);
            mock_swap_turbos<T0, T1>(arg3, arg4, arg6)
        }
    }

    public entry fun execute_ultra_fast_arbitrage_lbtc_sui(arg0: &mut UltraFastArbitrageConfig, arg1: &mut FastUserHistory, arg2: address, arg3: address, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, arg2);
        0x1::vector::push_back<address>(v2, arg3);
        let v3 = if (arg11 > 50) {
            80
        } else {
            20
        };
        let v4 = if (arg5 == 1) {
            6
        } else {
            10
        };
        let v5 = PreValidatedArbitrageData{
            weighted_price       : arg8,
            price_confidence     : arg9,
            data_timestamp       : arg12,
            estimated_profit     : arg10,
            profit_percentage    : arg10 * 10000 / arg4,
            expected_output_buy  : arg4 * 995 / 1000,
            expected_output_sell : arg4 * 996 / 1000,
            pools                : v1,
            pool_liquidities     : vector[1000000000, 1000000000],
            mev_risk_score       : arg11,
            frontrun_probability : v3,
            flash_loan_fee_bp    : v4,
            validation_hash      : create_bot_signature(arg8, arg12, 0x2::tx_context::sender(arg14)),
            ecdsa_signature      : 0x1::vector::empty<u8>(),
            nonce                : 0,
            bot_public_key       : 0x1::vector::empty<u8>(),
            bot_version          : 1,
        };
        let v6 = fast_mev_check(arg1, v0, arg0);
        validate_params_ultra_fast(arg0, arg2, arg3, arg5, arg4, &v5, &v6, v0, 0x2::tx_context::sender(arg14));
        let v7 = generate_fast_trade_id(0x2::tx_context::sender(arg14), v0, arg4);
        let v8 = arg4 + arg10;
        let (v9, v10) = if (arg5 == 1) {
            borrow_from_navi_ultra_fast<0x2::sui::SUI>(arg4, v5.flash_loan_fee_bp, v7, v8, arg13, arg14)
        } else {
            borrow_from_scallop_ultra_fast<0x2::sui::SUI>(arg4, v5.flash_loan_fee_bp, v7, v8, arg13, arg14)
        };
        let v11 = execute_token_swap<0x2::sui::SUI, LBTC>(1, 3, 1, arg2, v9, v5.expected_output_buy, 30, arg0, arg14);
        let v12 = execute_token_swap<LBTC, 0x2::sui::SUI>(3, 1, 1, arg3, v11, v8, 30, arg0, arg14);
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&v12);
        let v14 = if (arg5 == 1) {
            arg4 * v5.flash_loan_fee_bp / 10000
        } else {
            arg4 * v5.flash_loan_fee_bp / 10000
        };
        let v15 = if (v13 > arg4 + v14) {
            v13 - arg4 - v14
        } else {
            0
        };
        let v16 = v15 * 10000 / arg4;
        assert!(v16 >= arg6, 1005);
        repay_ultra_fast<0x2::sui::SUI>(v12, v10, arg14);
        fast_update_user(arg1, v0, v6.risk_score);
        let v17 = UltraFastArbitrageExecuted{
            trade_id              : v7,
            token_in_id           : 1,
            token_out_id          : 3,
            buy_pool_id           : arg2,
            sell_pool_id          : arg3,
            amount                : arg4,
            profit_amount         : v15,
            profit_percentage     : v16,
            execution_time_ms     : 0x2::clock::timestamp_ms(arg13) - v0,
            gas_used              : calculate_fast_gas_used(arg4),
            priority_fee_paid     : arg7,
            executor              : 0x2::tx_context::sender(arg14),
            flash_loan_provider   : arg5,
            bot_validation_passed : true,
            mev_protection_score  : v6.risk_score,
        };
        0x2::event::emit<UltraFastArbitrageExecuted>(v17);
    }

    public entry fun execute_ultra_fast_arbitrage_lbtc_usdc(arg0: &mut UltraFastArbitrageConfig, arg1: &mut FastUserHistory, arg2: address, arg3: address, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, arg2);
        0x1::vector::push_back<address>(v2, arg3);
        let v3 = if (arg11 > 50) {
            80
        } else {
            20
        };
        let v4 = if (arg5 == 1) {
            6
        } else {
            10
        };
        let v5 = PreValidatedArbitrageData{
            weighted_price       : arg8,
            price_confidence     : arg9,
            data_timestamp       : arg12,
            estimated_profit     : arg10,
            profit_percentage    : arg10 * 10000 / arg4,
            expected_output_buy  : arg4 * 994 / 1000,
            expected_output_sell : arg4 * 995 / 1000,
            pools                : v1,
            pool_liquidities     : vector[1000000000, 1000000000],
            mev_risk_score       : arg11,
            frontrun_probability : v3,
            flash_loan_fee_bp    : v4,
            validation_hash      : create_bot_signature(arg8, arg12, 0x2::tx_context::sender(arg14)),
            ecdsa_signature      : 0x1::vector::empty<u8>(),
            nonce                : 0,
            bot_public_key       : 0x1::vector::empty<u8>(),
            bot_version          : 1,
        };
        let v6 = fast_mev_check(arg1, v0, arg0);
        validate_params_ultra_fast(arg0, arg2, arg3, arg5, arg4, &v5, &v6, v0, 0x2::tx_context::sender(arg14));
        let v7 = generate_fast_trade_id(0x2::tx_context::sender(arg14), v0, arg4);
        let v8 = arg4 + arg10;
        let (v9, v10) = if (arg5 == 1) {
            borrow_from_navi_ultra_fast<0x2::sui::SUI>(arg4, v5.flash_loan_fee_bp, v7, v8, arg13, arg14)
        } else {
            borrow_from_scallop_ultra_fast<0x2::sui::SUI>(arg4, v5.flash_loan_fee_bp, v7, v8, arg13, arg14)
        };
        let v11 = execute_token_swap<0x2::sui::SUI, LBTC>(1, 3, 1, arg2, v9, v5.expected_output_buy, 30, arg0, arg14);
        let v12 = execute_token_swap<LBTC, USDC>(3, 2, 1, arg2, v11, v5.expected_output_buy, 30, arg0, arg14);
        let v13 = execute_token_swap<USDC, LBTC>(2, 3, 1, arg3, v12, v8, 30, arg0, arg14);
        let v14 = execute_token_swap<LBTC, 0x2::sui::SUI>(3, 1, 1, arg3, v13, v8, 30, arg0, arg14);
        let v15 = 0x2::coin::value<0x2::sui::SUI>(&v14);
        let v16 = arg4 * v5.flash_loan_fee_bp / 10000;
        let v17 = if (v15 > arg4 + v16) {
            v15 - arg4 - v16
        } else {
            0
        };
        let v18 = v17 * 10000 / arg4;
        assert!(v18 >= arg6, 1005);
        repay_ultra_fast<0x2::sui::SUI>(v14, v10, arg14);
        fast_update_user(arg1, v0, v6.risk_score);
        let v19 = UltraFastArbitrageExecuted{
            trade_id              : v7,
            token_in_id           : 1,
            token_out_id          : 3,
            buy_pool_id           : arg2,
            sell_pool_id          : arg3,
            amount                : arg4,
            profit_amount         : v17,
            profit_percentage     : v18,
            execution_time_ms     : 0x2::clock::timestamp_ms(arg13) - v0,
            gas_used              : calculate_fast_gas_used(arg4),
            priority_fee_paid     : arg7,
            executor              : 0x2::tx_context::sender(arg14),
            flash_loan_provider   : arg5,
            bot_validation_passed : true,
            mev_protection_score  : v6.risk_score,
        };
        0x2::event::emit<UltraFastArbitrageExecuted>(v19);
    }

    public entry fun execute_ultra_fast_arbitrage_sui_usdc(arg0: &mut UltraFastArbitrageConfig, arg1: &mut FastUserHistory, arg2: address, arg3: address, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg14);
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, arg2);
        0x1::vector::push_back<address>(v2, arg3);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg4 * 1000);
        0x1::vector::push_back<u64>(v4, arg4 * 1000);
        let v5 = if (arg12 > 50) {
            80
        } else {
            20
        };
        let v6 = if (arg5 == 1) {
            6
        } else {
            10
        };
        let v7 = PreValidatedArbitrageData{
            weighted_price       : arg9,
            price_confidence     : arg10,
            data_timestamp       : arg13,
            estimated_profit     : arg11,
            profit_percentage    : arg11 * 10000 / arg4,
            expected_output_buy  : arg4 * 997 / 1000,
            expected_output_sell : arg4 + arg11,
            pools                : v1,
            pool_liquidities     : v3,
            mev_risk_score       : arg12,
            frontrun_probability : v5,
            flash_loan_fee_bp    : v6,
            validation_hash      : create_bot_signature(arg9, arg13, 0x2::tx_context::sender(arg15)),
            ecdsa_signature      : 0x1::vector::empty<u8>(),
            nonce                : 0,
            bot_public_key       : 0x1::vector::empty<u8>(),
            bot_version          : 2,
        };
        let v8 = fast_mev_check(arg1, v0, arg0);
        validate_params_ultra_fast(arg0, arg2, arg3, arg5, arg4, &v7, &v8, v0, 0x2::tx_context::sender(arg15));
        let v9 = generate_fast_trade_id(0x2::tx_context::sender(arg15), v0, arg4);
        let v10 = arg4 + arg11;
        let v11 = prepare_fast_mev_bundle(arg7, arg4, v9, v8.risk_score);
        let v12 = MEVBundleSubmitted{
            bundle_size      : 0x1::vector::length<vector<u8>>(&v11.transactions),
            total_gas_budget : v11.total_gas_budget,
            priority_fee     : v11.priority_fee,
            expected_profit  : v11.expected_profit,
            submitter        : 0x2::tx_context::sender(arg15),
        };
        0x2::event::emit<MEVBundleSubmitted>(v12);
        let (v13, v14) = if (arg5 == 1) {
            borrow_from_navi_ultra_fast<0x2::sui::SUI>(arg4, v7.flash_loan_fee_bp, v9, v10, arg14, arg15)
        } else {
            borrow_from_scallop_ultra_fast<0x2::sui::SUI>(arg4, v7.flash_loan_fee_bp, v9, v10, arg14, arg15)
        };
        let v15 = execute_token_swap<0x2::sui::SUI, USDC>(1, 2, 1, arg2, v13, v7.expected_output_buy, 30, arg0, arg15);
        let v16 = execute_token_swap<USDC, 0x2::sui::SUI>(2, 1, 1, arg3, v15, v10, 30, arg0, arg15);
        let v17 = 0x2::coin::value<0x2::sui::SUI>(&v16);
        let v18 = arg4 * v7.flash_loan_fee_bp / 10000;
        let v19 = if (v17 > arg4 + v18) {
            v17 - arg4 - v18
        } else {
            0
        };
        let v20 = v19 * 10000 / arg4;
        assert!(v20 >= arg6, 1005);
        repay_ultra_fast<0x2::sui::SUI>(v16, v14, arg15);
        fast_update_user(arg1, v0, v8.risk_score);
        let v21 = UltraFastArbitrageExecuted{
            trade_id              : v9,
            token_in_id           : 1,
            token_out_id          : 2,
            buy_pool_id           : arg2,
            sell_pool_id          : arg3,
            amount                : arg4,
            profit_amount         : v19,
            profit_percentage     : v20,
            execution_time_ms     : 0x2::clock::timestamp_ms(arg14) - v0,
            gas_used              : calculate_fast_gas_used(arg4),
            priority_fee_paid     : arg7,
            executor              : 0x2::tx_context::sender(arg15),
            flash_loan_provider   : arg5,
            bot_validation_passed : true,
            mev_protection_score  : v8.risk_score,
        };
        0x2::event::emit<UltraFastArbitrageExecuted>(v21);
    }

    fun fast_check_reentrancy(arg0: &mut ReentrancyGuard) {
        assert!(!arg0.locked, 1010);
        arg0.locked = true;
    }

    fun fast_mev_check(arg0: &mut FastUserHistory, arg1: u64, arg2: &UltraFastArbitrageConfig) : SimplifiedMEVState {
        if (arg1 - arg0.hourly_reset_timestamp >= 3600000) {
            arg0.hourly_trade_count = 0;
            arg0.hourly_reset_timestamp = arg1;
        };
        let v0 = arg0.risk_score;
        let v1 = v0;
        let v2 = false;
        if (arg0.hourly_trade_count >= arg2.max_hourly_trades) {
            v1 = v0 + 30;
        };
        if (arg1 - arg0.last_trade_timestamp < 2000) {
            v1 = v1 + 25;
            v2 = true;
        };
        SimplifiedMEVState{
            last_trade_timestamp : arg0.last_trade_timestamp,
            hourly_trade_count   : arg0.hourly_trade_count,
            risk_score           : v1,
            frontrun_detected    : v2,
        }
    }

    fun fast_release_reentrancy(arg0: &mut ReentrancyGuard) {
        arg0.locked = false;
    }

    fun fast_update_user(arg0: &mut FastUserHistory, arg1: u64, arg2: u64) {
        arg0.last_trade_timestamp = arg1;
        arg0.hourly_trade_count = arg0.hourly_trade_count + 1;
        arg0.risk_score = (arg0.risk_score * 9 + arg2) / 10;
    }

    fun generate_fast_trade_id(arg0: address, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, (arg1 as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg1 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v0, (arg2 as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8) as u8));
        let v1 = 0x1::bcs::to_bytes<address>(&arg0);
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, 0));
        };
        v0
    }

    public fun get_fast_user_status(arg0: &FastUserHistory) : (u64, u64, u64) {
        (arg0.last_trade_timestamp, arg0.hourly_trade_count, arg0.risk_score)
    }

    public fun get_flash_loan_fee(arg0: &FlashLoanConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.navi_fee_bp
        } else {
            arg0.scallop_fee_bp
        }
    }

    public fun get_pool_info(arg0: &Registry, arg1: address) : (u8, u8, u8, u64, bool, u64, u64) {
        assert!(0x2::table::contains<address, PoolInfo>(&arg0.pools, arg1), 1017);
        let v0 = 0x2::table::borrow<address, PoolInfo>(&arg0.pools, arg1);
        (v0.dex_id, v0.token_in_id, v0.token_out_id, v0.fee_rate, v0.is_active, v0.liquidity_estimate, v0.last_updated)
    }

    public fun get_ultra_fast_config(arg0: &UltraFastArbitrageConfig) : (u64, u64, bool, u64) {
        (arg0.min_profit_basis_points, arg0.max_slippage_basis_points, arg0.mev_protection_enabled, arg0.max_trade_amount)
    }

    public fun get_whitelisted_pools(arg0: &UltraFastArbitrageConfig) : vector<address> {
        arg0.whitelisted_pools
    }

    public entry fun initialize_flash_loan_config(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanConfig{
            id                 : 0x2::object::new(arg5),
            preferred_provider : arg0,
            network_type       : arg1,
            navi_fee_bp        : arg2,
            scallop_fee_bp     : arg3,
            auto_select        : arg4,
        };
        0x2::transfer::share_object<FlashLoanConfig>(v0);
    }

    public entry fun initialize_nonce_tracker(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NonceTracker{
            id          : 0x2::object::new(arg0),
            used_nonces : 0x2::table::new<u64, bool>(arg0),
            last_nonce  : 0,
            admin       : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<NonceTracker>(v0);
    }

    public entry fun initialize_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg0),
            admin       : 0x2::tx_context::sender(arg0),
            pools       : 0x2::table::new<address, PoolInfo>(arg0),
            total_pools : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun initialize_ultra_fast(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReentrancyGuard{
            id     : 0x2::object::new(arg0),
            locked : false,
        };
        0x2::transfer::share_object<ReentrancyGuard>(v0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 1);
        0x1::vector::push_back<u8>(v2, 2);
        let v3 = UltraFastArbitrageConfig{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            reentrancy_guard_id       : 0x2::object::id_address<ReentrancyGuard>(&v0),
            max_trade_amount          : 50000000000,
            mev_protection_enabled    : true,
            max_hourly_trades         : 100,
            min_profit_basis_points   : 50,
            max_slippage_basis_points : 200,
            whitelisted_pools         : 0x1::vector::empty<address>(),
            enabled_providers         : v1,
            enabled_pairs             : x"0102030405",
            max_gas_budget            : 350000000,
            paused                    : false,
            emergency_stop            : false,
        };
        0x2::transfer::share_object<UltraFastArbitrageConfig>(v3);
    }

    public fun is_pool_whitelisted(arg0: &UltraFastArbitrageConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_pools, &arg1)
    }

    public fun is_provider_enabled(arg0: &UltraFastArbitrageConfig, arg1: u8) : bool {
        0x1::vector::contains<u8>(&arg0.enabled_providers, &arg1)
    }

    fun mock_execute_swap_step(arg0: &SwapStep, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = arg1 * (10000 - arg0.fee_rate) / 10000;
        assert!(v0 >= arg0.min_amount_out, 1004);
        v0
    }

    fun mock_swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 997 / 1000 >= arg1, 1004);
        0x2::coin::zero<T1>(arg2)
    }

    fun mock_swap_magma<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 9980 / 10000 >= arg1, 1004);
        0x2::coin::zero<T1>(arg2)
    }

    fun mock_swap_momentum<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 9975 / 10000 >= arg1, 1004);
        0x2::coin::zero<T1>(arg2)
    }

    fun mock_swap_suilend<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 9985 / 10000 >= arg1, 1004);
        0x2::coin::zero<T1>(arg2)
    }

    fun mock_swap_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 9975 / 10000 >= arg1, 1004);
        0x2::coin::zero<T1>(arg2)
    }

    fun prepare_fast_mev_bundle(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: u64) : FastMEVBundle {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"flash_loan");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"swap_1");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"swap_2");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"repay");
        FastMEVBundle{
            transactions         : v0,
            total_gas_budget     : calculate_fast_gas_budget(arg1),
            priority_fee         : arg0,
            expected_profit      : arg1 * 10 / 10000,
            bundle_id            : arg2,
            mev_protection_score : arg3,
        }
    }

    public fun release_lock(arg0: &mut ReentrancyGuard) {
        arg0.locked = false;
    }

    public entry fun remove_pool_from_registry(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1016);
        assert!(0x2::table::contains<address, PoolInfo>(&arg0.pools, arg1), 1017);
        0x2::table::remove<address, PoolInfo>(&mut arg0.pools, arg1);
        arg0.total_pools = arg0.total_pools - 1;
    }

    public entry fun remove_whitelisted_pool(arg0: &mut UltraFastArbitrageConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1006);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_pools, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelisted_pools, v1);
        };
    }

    public fun repay_ultra_fast<T0>(arg0: 0x2::coin::Coin<T0>, arg1: FastFlashLoanReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let FastFlashLoanReceipt {
            amount          : v0,
            fee             : v1,
            provider        : _,
            timestamp       : _,
            trade_id        : _,
            expected_return : _,
        } = arg1;
        assert!(0x2::coin::value<T0>(&arg0) >= v0 + v1, 1002);
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public entry fun resume_ultra_fast(arg0: &mut UltraFastArbitrageConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1006);
        arg0.paused = false;
        arg0.emergency_stop = false;
    }

    public fun select_optimal_provider(arg0: &FlashLoanConfig) : (u8, u64) {
        if (arg0.auto_select) {
            if (arg0.network_type == 1) {
                (1, arg0.navi_fee_bp)
            } else if (arg0.navi_fee_bp <= arg0.scallop_fee_bp) {
                (1, arg0.navi_fee_bp)
            } else {
                (2, arg0.scallop_fee_bp)
            }
        } else if (arg0.preferred_provider == 1) {
            (1, arg0.navi_fee_bp)
        } else {
            (2, arg0.scallop_fee_bp)
        }
    }

    public entry fun test_ultra_fast_deployment(arg0: &0x2::tx_context::TxContext) {
        let v0 = UltraFastArbitrageExecuted{
            trade_id              : b"ultra_fast_test_001",
            token_in_id           : 255,
            token_out_id          : 255,
            buy_pool_id           : @0x0,
            sell_pool_id          : @0x1,
            amount                : 1000000,
            profit_amount         : 20000,
            profit_percentage     : 200,
            execution_time_ms     : 12,
            gas_used              : 120000,
            priority_fee_paid     : 6000,
            executor              : 0x2::tx_context::sender(arg0),
            flash_loan_provider   : 1,
            bot_validation_passed : true,
            mev_protection_score  : 25,
        };
        0x2::event::emit<UltraFastArbitrageExecuted>(v0);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun update_flash_loan_fees(arg0: &mut FlashLoanConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.navi_fee_bp = arg1;
        arg0.scallop_fee_bp = arg2;
    }

    public entry fun update_limits_ultra_fast(arg0: &mut UltraFastArbitrageConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1006);
        assert!(arg1 <= 100000000000, 1008);
        assert!(arg2 <= 100, 1008);
        arg0.max_trade_amount = arg1;
        arg0.max_hourly_trades = arg2;
    }

    public entry fun update_pool_info(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1016);
        assert!(0x2::table::contains<address, PoolInfo>(&arg0.pools, arg1), 1017);
        let v0 = 0x2::table::borrow_mut<address, PoolInfo>(&mut arg0.pools, arg1);
        v0.fee_rate = arg2;
        v0.liquidity_estimate = arg3;
        v0.is_active = arg4;
        v0.last_updated = 0x2::clock::timestamp_ms(arg5);
    }

    fun validate_bot_data(arg0: &PreValidatedArbitrageData, arg1: u64, arg2: address, arg3: &UltraFastArbitrageConfig) : bool {
        if (arg1 - arg0.data_timestamp > 1000) {
            return false
        };
        if (arg0.price_confidence < 8000) {
            return false
        };
        if (arg0.mev_risk_score > 70) {
            return false
        };
        if (arg0.estimated_profit == 0) {
            return false
        };
        if (0x1::vector::length<address>(&arg0.pools) < 2) {
            return false
        };
        let v0 = *0x1::vector::borrow<address>(&arg0.pools, 0);
        let v1 = *0x1::vector::borrow<address>(&arg0.pools, 1);
        if (!0x1::vector::contains<address>(&arg3.whitelisted_pools, &v0) || !0x1::vector::contains<address>(&arg3.whitelisted_pools, &v1)) {
            return false
        };
        if (!validate_bot_signature(&arg0.validation_hash, arg0.weighted_price, arg0.data_timestamp, arg2)) {
            return false
        };
        true
    }

    fun validate_bot_signature(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: address) : bool {
        let v0 = create_bot_signature(arg1, arg2, arg3);
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(&v0)) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun validate_bot_signature_with_ecdsa(arg0: &mut NonceTracker, arg1: &PreValidatedArbitrageData, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) : bool {
        if (arg1.bot_public_key == 0x1::vector::empty<u8>()) {
            return true
        };
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_nonces, arg1.nonce), 1013);
        assert!(arg1.nonce > arg0.last_nonce, 1013);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.data_timestamp, 1014);
        assert!(v0 - arg1.data_timestamp <= 30000, 1014);
        let v1 = create_validation_message(arg1, arg2, arg3, arg1.nonce, arg4);
        let v2 = 0x2::hash::keccak256(&v1);
        if (0x2::ecdsa_k1::secp256k1_verify(&arg1.ecdsa_signature, &arg1.bot_public_key, &v2, 1)) {
            0x2::table::add<u64, bool>(&mut arg0.used_nonces, arg1.nonce, true);
            arg0.last_nonce = arg1.nonce;
            true
        } else {
            false
        }
    }

    public fun validate_gas_estimate(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg0 <= 350000000, 1008);
        assert!(arg0 >= 500, 1008);
        let v0 = if (arg1 <= 2) {
            10
        } else if (arg1 <= 4) {
            12
        } else {
            15
        };
        let v1 = if (arg2 == 1) {
            15
        } else if (arg2 == 2) {
            30
        } else if (arg2 == 3) {
            70
        } else {
            150
        };
        let v2 = arg0 * v0 / 10 * v1 / 10;
        if (v2 > 350000000) {
            350000000
        } else if (v2 < 500) {
            500 * 2
        } else {
            v2
        }
    }

    fun validate_multi_hop_params(arg0: &UltraFastArbitrageConfig, arg1: &MultiHopRoute, arg2: u8, arg3: &PreValidatedArbitrageData, arg4: &SimplifiedMEVState, arg5: u64, arg6: address) {
        assert!(!arg0.paused, 1007);
        assert!(!arg0.emergency_stop, 1007);
        assert!(arg1.total_amount_in > 0, 1008);
        assert!(arg1.total_amount_in <= arg0.max_trade_amount, 1008);
        assert!(0x1::vector::contains<u8>(&arg0.enabled_providers, &arg2), 1009);
        let v0 = &arg1.steps;
        let v1 = 0x1::vector::length<SwapStep>(v0);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x1::vector::contains<address>(&arg0.whitelisted_pools, &0x1::vector::borrow<SwapStep>(v0, v2).pool_address), 1015);
            v2 = v2 + 1;
        };
        assert!(validate_bot_data(arg3, arg5, arg6, arg0), 1014);
        if (arg0.mev_protection_enabled) {
            let v3 = if (v1 > 3) {
                60
            } else {
                70
            };
            assert!(arg4.risk_score <= v3, 1011);
            assert!(!arg4.frontrun_detected, 1011);
        };
        assert!(arg3.estimated_profit >= 2000000, 1005);
    }

    fun validate_multi_hop_route(arg0: &MultiHopRoute) {
        let v0 = &arg0.steps;
        let v1 = 0x1::vector::length<SwapStep>(v0);
        assert!(v1 > 0, 1001);
        assert!(v1 <= 10, 1001);
        let v2 = 0;
        while (v2 < v1 - 1) {
            assert!(0x1::vector::borrow<SwapStep>(v0, v2).token_out_id == 0x1::vector::borrow<SwapStep>(v0, v2 + 1).token_in_id, 1001);
            v2 = v2 + 1;
        };
        assert!(0x1::vector::borrow<SwapStep>(v0, 0).token_in_id == 1, 1001);
        assert!(0x1::vector::borrow<SwapStep>(v0, v1 - 1).token_out_id == 1, 1001);
    }

    fun validate_params_ultra_fast(arg0: &UltraFastArbitrageConfig, arg1: address, arg2: address, arg3: u8, arg4: u64, arg5: &PreValidatedArbitrageData, arg6: &SimplifiedMEVState, arg7: u64, arg8: address) {
        assert!(!arg0.paused, 1007);
        assert!(!arg0.emergency_stop, 1007);
        assert!(arg4 > 0, 1008);
        assert!(arg4 <= arg0.max_trade_amount, 1008);
        assert!(arg1 != arg2, 1001);
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_pools, &arg1), 1015);
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_pools, &arg2), 1015);
        assert!(0x1::vector::contains<u8>(&arg0.enabled_providers, &arg3), 1009);
        assert!(validate_bot_data(arg5, arg7, arg8, arg0), 1014);
        if (arg0.mev_protection_enabled) {
            assert!(arg6.risk_score <= 70, 1011);
            assert!(!arg6.frontrun_detected, 1011);
        };
        assert!(arg5.estimated_profit >= 2000000, 1005);
    }

    public fun validate_pool_in_registry(arg0: &Registry, arg1: address, arg2: u8, arg3: u8, arg4: u8) : bool {
        if (!0x2::table::contains<address, PoolInfo>(&arg0.pools, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, PoolInfo>(&arg0.pools, arg1);
        if (v0.is_active) {
            if (v0.dex_id == arg2) {
                if (v0.token_in_id == arg3) {
                    v0.token_out_id == arg4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

