module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market {
    struct SettlementState has copy, drop, store {
        is_settled: bool,
        settled_py_index: u128,
    }

    struct PyIndexGuard has copy, drop, store {
        mode: u8,
        max_step_growth_bps: u64,
        max_window_growth_bps: u64,
        window_ms: u64,
        anchor_index_raw: u128,
        anchor_timestamp_ms: u64,
    }

    struct RiskConfig has copy, drop, store {
        treasury: address,
        interest_fee_rate: u128,
        expiry_divisor: u64,
        market_cap: u64,
        asset_market_cap: u64,
        py_index_guard: PyIndexGuard,
    }

    struct RewardState has copy, drop, store {
        pool_reward_guard: u64,
        yt_reward_guard: u64,
        lp_reward_guard: u64,
    }

    struct CoinAuthority<phantom T0: drop, phantom T1: drop, phantom T2: drop> has store {
        sy_treasury: 0x2::coin::TreasuryCap<T0>,
        pt_treasury: 0x2::coin::TreasuryCap<T1>,
        yt_treasury: 0x2::coin::TreasuryCap<T2>,
    }

    struct Market<phantom T0: drop, phantom T1: drop, phantom T2: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        price_aggregator_id: 0x2::object::ID,
        reward_distributor_id: 0x1::option::Option<0x2::object::ID>,
        coin_authority: CoinAuthority<T0, T1, T2>,
        pt_supply: u64,
        yt_supply: u64,
        py_sy_balance: 0x2::balance::Balance<T0>,
        py_index_stored: u128,
        py_index_last_updated: u64,
        interest_segment: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::InterestSegment,
        total_treasury_interest: u128,
        last_interest_timestamp: u64,
        global_interest_index: u128,
        settlement: SettlementState,
        total_pt: u64,
        pool_sy_balance: 0x2::balance::Balance<T0>,
        reserve_fee_vault: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        pool_status: u8,
        pool_generation: u64,
        last_ln_implied_rate: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64,
        scalar_root: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64,
        protocol_fee_rate: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64,
        protocol_fee_remainder_raw: u128,
        risk: RiskConfig,
        rewards: RewardState,
    }

    struct MarketCreatedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        created_by: address,
    }

    struct MarketPriceAggregatorBoundEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        price_aggregator_id: 0x2::object::ID,
    }

    struct MarketMintPyEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount_in: u64,
        pt_amount: u64,
        yt_amount: u64,
        expiry: u64,
    }

    struct MarketRedeemPyEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pt_amount: u64,
        yt_amount: u64,
        sy_amount_out: u64,
        expiry: u64,
        redeemer: address,
    }

    struct MarketInterestCollectedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        user_interest_raw: u128,
        treasury_interest_raw: u128,
        py_index_raw: u128,
    }

    struct MarketSettledEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        settled_py_index: u128,
        treasury_interest_collected_raw: u128,
        settled_at_ms: u64,
    }

    struct MarketInterestClaimedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        receiver: address,
    }

    struct MarketYtRedeemedAfterExpiryEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        yt_amount: u64,
        sy_interest_out: u64,
        redeemer: address,
    }

    struct MarketAddLiquidityEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        pt_amount: u64,
        lp_amount: u64,
        sy_refund: u64,
        pt_refund: u64,
    }

    struct MarketRemoveLiquidityEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        pt_amount: u64,
        lp_amount: u64,
        provider: address,
    }

    struct MarketPoolLifecycleEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        previous_status: u8,
        new_status: u8,
        pool_generation: u64,
        actor: address,
    }

    struct MarketSwapEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        is_pt_to_sy: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        reserve_fee: u64,
        trader: address,
    }

    struct MarketImpliedRateUpdatedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        ln_implied_rate_raw: u128,
        pt_price_raw: u128,
        total_pt: u64,
        total_sy: u64,
        lp_supply: u64,
    }

    struct MarketRewardDistributorRequiredEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct MarketReserveFeeCollectedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
        collector: address,
    }

    struct MarketTreasuryInterestCollectedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
        dust_remainder_raw: u128,
        collector: address,
    }

    struct MarketTreasuryUpdatedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        previous_treasury: address,
        treasury: address,
        actor: address,
    }

    struct MarketMarketCapUpdatedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        market_cap: u64,
        actor: address,
    }

    struct MarketAssetMarketCapUpdatedEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        asset_market_cap: u64,
        sy_index_raw: u128,
        actor: address,
    }

    struct TradeResult has copy, drop {
        is_pt_to_sy: bool,
        amount_in: u64,
        amount_out: u64,
        sy_amount: u64,
        pt_amount: u64,
        fee: u64,
        reserve_fee: u64,
        new_ln_implied_rate: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64,
        time_to_expiry_ms: u64,
    }

    struct BorrowPtReceipt {
        market_state_id: 0x2::object::ID,
        pt_amount: u64,
    }

    struct BuyYtReceipt {
        market_state_id: 0x2::object::ID,
        pt_amount: u64,
        sy_amount: u64,
        fee: u64,
        reserve_fee: u64,
        new_ln_implied_rate: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64,
        time_to_expiry_ms: u64,
        sy_index_raw: u128,
    }

    struct ExternalPtRedeemReceipt {
        market_state_id: 0x2::object::ID,
        pt_amount: u64,
    }

    struct PoolRewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct YtRewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardPoolOperation {
        market_state_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct YtRewardMutation {
        market_state_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct CoinAuthoritySnapshot has copy, drop {
        sy_treasury_id: 0x2::object::ID,
        pt_treasury_id: 0x2::object::ID,
        yt_treasury_id: 0x2::object::ID,
        sy_total_supply: u64,
        pt_total_supply: u64,
        yt_total_supply: u64,
    }

    struct MarketSnapshot has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        price_aggregator_id: 0x2::object::ID,
        reward_distributor_id: 0x1::option::Option<0x2::object::ID>,
        coin_authority: CoinAuthoritySnapshot,
        pt_supply: u64,
        yt_supply: u64,
        py_sy_balance: u64,
        py_index_stored: u128,
        global_interest_index: u128,
        total_treasury_interest_raw: u128,
        is_settled: bool,
        settled_py_index: u128,
        total_pt: u64,
        pool_sy_balance: u64,
        reserve_fee_balance: u64,
        protocol_fee_remainder_raw: u128,
        lp_supply: u64,
        pool_status: u8,
        pool_generation: u64,
        treasury: address,
        interest_fee_rate: u128,
        expiry_divisor: u64,
        market_cap: u64,
        asset_market_cap: u64,
        py_index_guard: PyIndexGuard,
        yt_reward_guard: u64,
        lp_reward_guard: u64,
        pool_reward_guard: u64,
    }

    public fun id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<Market<T0, T1, T2>>(arg0)
    }

    public(friend) fun add_liquidity<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x2::coin::Coin<T0>) {
        assert_pool_active<T0, T1, T2>(arg2);
        assert!(arg2.lp_supply > 0, 3634);
        let v0 = reward_distributor_required<T0, T1, T2>(arg2);
        add_liquidity_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, v0, false, arg5, arg6)
    }

    fun add_liquidity_internal<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: u128, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert_pool_active<T0, T1, T2>(arg2);
        assert!(arg2.expiry > v0, 3603);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg3, id<T0, T1, T2>(arg2));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::bind_pool_if_empty(arg3, id<T0, T1, T2>(arg2));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_pool_match(arg3, id<T0, T1, T2>(arg2));
        if (arg5) {
            assert_pool_mutation_allowed<T0, T1, T2>(arg2);
        };
        if (arg6) {
            assert_lp_reward_mutation_allowed<T0, T1, T2>(arg2, arg3);
        };
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0 && arg1 > 0, 3604);
        let v2 = arg2.lp_supply == 0;
        let (v3, v4, v5, v6, v7) = if (v2) {
            assert!(arg7, 3634);
            assert_pool_empty<T0, T1, T2>(arg2);
            let v8 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::get_initial_ln_implied_rate(arg1, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::sy_to_asset_amount(v1, arg4), arg2.scalar_root, arg2.initial_anchor, arg2.expiry - v0);
            let v9 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::calc_lp_amount(0, 0, 0, v1, arg1);
            assert!(v9 > 0, 3604);
            join_pool_sy<T0, T1, T2>(arg2, arg0);
            add_pool_pt<T0, T1, T2>(arg2, arg1);
            mint_lp<T0, T1, T2>(arg2, v9);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_lp(arg3, v9);
            check_market_caps<T0, T1, T2>(arg2, arg4);
            (v9, v1, arg1, 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg9), v8)
        } else {
            let v10 = arg2.lp_supply;
            let v11 = 0x2::balance::value<T0>(&arg2.pool_sy_balance);
            let v12 = arg2.total_pt;
            assert!(v11 > 0 && v12 > 0, 3604);
            let v13 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::calc_lp_amount(v10, v11, v12, v1, arg1);
            assert!(v13 > 0, 3604);
            let v14 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((v13 as u128), (v11 as u128), (v10 as u128)) as u64);
            let v15 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((v13 as u128), (v12 as u128), (v10 as u128)) as u64);
            assert!(v14 <= v1 && v15 <= arg1, 3608);
            join_pool_sy<T0, T1, T2>(arg2, 0x2::coin::split<T0>(&mut arg0, v14, arg9));
            add_pool_pt<T0, T1, T2>(arg2, v15);
            mint_lp<T0, T1, T2>(arg2, v13);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_lp(arg3, v13);
            check_market_caps<T0, T1, T2>(arg2, arg4);
            (v13, v14, v15, arg0, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
        };
        let v16 = v6;
        if (v2) {
            arg2.last_ln_implied_rate = v7;
        };
        let v17 = MarketAddLiquidityEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg3),
            sy_amount       : v4,
            pt_amount       : v5,
            lp_amount       : v3,
            sy_refund       : 0x2::coin::value<T0>(&v16),
            pt_refund       : arg1 - v5,
        };
        0x2::event::emit<MarketAddLiquidityEvent>(v17);
        (v3, v4, v5, v16)
    }

    fun add_pool_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) {
        assert!(arg1 > 0, 3604);
        arg0.total_pt = arg0.total_pt + arg1;
    }

    fun assert_lp_reward_mutation_allowed<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition) {
        if (reward_distributor_required<T0, T1, T2>(arg0)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_reward_mutation_allowed(arg1, reward_distributor_id<T0, T1, T2>(arg0));
        };
    }

    fun assert_pool_active<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) {
        assert!(arg0.pool_status == 1, 3634);
    }

    fun assert_pool_empty<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) {
        let v0 = if (arg0.lp_supply == 0) {
            if (arg0.total_pt == 0) {
                0x2::balance::value<T0>(&arg0.pool_sy_balance) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3636);
    }

    fun assert_pool_mutation_allowed<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) {
        if (reward_distributor_required<T0, T1, T2>(arg0)) {
            assert!(pool_reward_gate_open<T0, T1, T2>(arg0), 3615);
        };
    }

    fun assert_valid_create(arg0: u64, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg3), 3603);
        assert!(arg1 <= 3689348814741910323, 3602);
        assert!(arg2 > 0, 3601);
        assert!(arg0 % arg2 == 0, 3600);
    }

    fun assert_yt_reward_mutation_allowed<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) {
        if (reward_distributor_required<T0, T1, T2>(arg0)) {
            assert!(yt_reward_gate_open<T0, T1, T2>(arg0), 3615);
        };
    }

    public(friend) fun begin_buy_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, BuyYtReceipt) {
        assert_pool_mutation_allowed<T0, T1, T2>(arg0);
        let v0 = execute_trade_core<T0, T1, T2>(arg0, 0, arg1, arg2, arg3, arg4);
        let v1 = split_pool_sy<T0, T1, T2>(arg0, v0.sy_amount, arg5);
        collect_reserve_fee_from_pool<T0, T1, T2>(arg0, v0.reserve_fee);
        let v2 = BuyYtReceipt{
            market_state_id     : id<T0, T1, T2>(arg0),
            pt_amount           : v0.pt_amount,
            sy_amount           : v0.sy_amount,
            fee                 : v0.fee,
            reserve_fee         : v0.reserve_fee,
            new_ln_implied_rate : v0.new_ln_implied_rate,
            time_to_expiry_ms   : v0.time_to_expiry_ms,
            sy_index_raw        : arg3,
        };
        (v1, v2)
    }

    public(friend) fun begin_pool_reward_operation<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement) : RewardPoolOperation {
        assert!(reward_distributor_required<T0, T1, T2>(arg0), 3615);
        assert!(!pool_reward_gate_open<T0, T1, T2>(arg0), 3616);
        let v0 = id<T0, T1, T2>(arg0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_scope(&arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope());
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_market_matches(&arg1, v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_subject(&arg1, v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_previous_exposure(&arg1, total_pool_sy<T0, T1, T2>(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_guard(&arg1, pool_reward_guard<T0, T1, T2>(arg0));
        let v1 = PoolRewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<PoolRewardGateKey, bool>(&mut arg0.id, v1, true);
        RewardPoolOperation{
            market_state_id : v0,
            distributor_id  : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::consume_pool_settlement(arg1, reward_distributor_id<T0, T1, T2>(arg0), v0),
        }
    }

    public(friend) fun begin_yt_reward_mutation<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64) : YtRewardMutation {
        assert!(reward_distributor_required<T0, T1, T2>(arg0), 3615);
        assert!(!yt_reward_gate_open<T0, T1, T2>(arg0), 3616);
        let v0 = id<T0, T1, T2>(arg0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_scope(&arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope());
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_market_matches(&arg1, v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_subject(&arg1, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_owner(&arg1, arg3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_previous_exposure(&arg1, arg4);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_guard(&arg1, arg5);
        let v1 = YtRewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<YtRewardGateKey, bool>(&mut arg0.id, v1, true);
        YtRewardMutation{
            market_state_id : v0,
            distributor_id  : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::consume_yt_settlement(arg1, reward_distributor_id<T0, T1, T2>(arg0), arg2, arg3),
        }
    }

    public fun bind_price_aggregator_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::aggregator::PriceAggregator<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert!(arg0.price_aggregator_id == id<T0, T1, T2>(arg0), 3631);
        assert!(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::aggregator::market_id<T0>(arg3) == id<T0, T1, T2>(arg0), 3632);
        arg0.price_aggregator_id = 0x2::object::id<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::aggregator::PriceAggregator<T0>>(arg3);
        let v0 = MarketPriceAggregatorBoundEvent{
            market_state_id     : id<T0, T1, T2>(arg0),
            price_aggregator_id : arg0.price_aggregator_id,
        };
        0x2::event::emit<MarketPriceAggregatorBoundEvent>(v0);
    }

    public(friend) fun borrow_pt_for_yt_redeem<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u64) : BorrowPtReceipt {
        assert_pool_active<T0, T1, T2>(arg0);
        assert!(arg1 > 0, 3604);
        assert!(arg0.total_pt > arg1, 3605);
        BorrowPtReceipt{
            market_state_id : id<T0, T1, T2>(arg0),
            pt_amount       : arg1,
        }
    }

    fun burn_lp<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) {
        assert!(arg1 > 0, 3604);
        assert!(arg0.lp_supply >= arg1, 3609);
        arg0.lp_supply = arg0.lp_supply - arg1;
    }

    fun burn_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) : u64 {
        0x2::coin::burn<T1>(&mut arg0.coin_authority.pt_treasury, arg1)
    }

    public fun burn_pt_in<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut Market<T0, T1, T2>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg2, b"market", id<T0, T1, T2>(arg3), 3623);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, id<T0, T1, T2>(arg3));
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 3604);
        burn_pt<T0, T1, T2>(arg3, arg0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg1, v0);
    }

    fun burn_py_supply<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u64, arg3: u64) {
        assert!(arg0.pt_supply >= arg2, 3605);
        assert!(arg0.yt_supply >= arg3, 3606);
        if (arg3 > 0) {
            assert_yt_reward_mutation_allowed<T0, T1, T2>(arg0);
        };
        arg0.pt_supply = arg0.pt_supply - arg2;
        arg0.yt_supply = arg0.yt_supply - arg3;
        if (arg3 > 0) {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::restart(&mut arg0.interest_segment, arg0.py_index_stored, arg0.yt_supply);
        };
        if (arg2 > 0) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg1, arg2);
        };
        if (arg3 > 0) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_yt(arg1, arg3);
        };
    }

    public(friend) fun burn_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::coin::burn<T0>(&mut arg0.coin_authority.sy_treasury, arg1)
    }

    public fun calc_py_amount_for_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &Market<T0, T1, T2>) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = current_py_index<T0, T1, T2>(arg2, arg1);
        assert!(v0 > 0, 3604);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), v0, 18446744073709551616);
        assert!(v1 <= 18446744073709551615, 3627);
        (v1 as u64)
    }

    public fun calc_sy_amount_for_py<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &Market<T0, T1, T2>) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = current_py_index<T0, T1, T2>(arg2, arg1);
        assert!(v0 > 0, 3604);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, v0);
        assert!(v1 <= 18446744073709551615, 3627);
        (v1 as u64)
    }

    fun calc_user_accrued(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        if (arg3 == 0 || arg2 <= arg3) {
            return arg0
        };
        arg0 + (arg1 as u128) * (arg2 - arg3)
    }

    fun check_asset_market_cap<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u128) {
        if (arg0.risk.asset_market_cap > 0) {
            assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::sy_to_asset_amount(0x2::balance::value<T0>(&arg0.pool_sy_balance), arg1) <= arg0.risk.asset_market_cap, 3608);
        };
    }

    fun check_market_cap<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) {
        if (arg0.risk.market_cap == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.pool_sy_balance) <= arg0.risk.market_cap, 3608);
    }

    fun check_market_caps<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u128) {
        check_market_cap<T0, T1, T2>(arg0);
        check_asset_market_cap<T0, T1, T2>(arg0, arg1);
    }

    fun checkpoint_and_collect_treasury_interest<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x1::option::Option<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = if (is_expired(arg0.expiry, 0x2::clock::timestamp_ms(arg3))) {
            assert!(arg0.settlement.is_settled, 3621);
            if (0x1::option::is_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(&arg2)) {
                0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::destroy<T0>(0x1::option::destroy_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg2));
            } else {
                0x1::option::destroy_none<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg2);
            };
            arg0.settlement.settled_py_index
        } else {
            assert!(0x1::option::is_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(&arg2), 3629);
            consume_price_info<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg2), arg3)
        };
        let (_, _, _) = update_interest_index<T0, T1, T2>(arg0, v0, arg3);
        let (v4, v5) = treasury_interest_collectible(arg0.total_treasury_interest);
        if (v4 == 0) {
            return 0
        };
        arg0.total_treasury_interest = v5;
        let v6 = arg0.risk.treasury;
        let v7 = split_py_sy<T0, T1, T2>(arg0, v4, arg4);
        let v8 = MarketTreasuryInterestCollectedEvent{
            market_state_id    : id<T0, T1, T2>(arg0),
            treasury           : v6,
            amount             : v4,
            dust_remainder_raw : v5,
            collector          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MarketTreasuryInterestCollectedEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v6);
        v4
    }

    public fun circulating_lp_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.lp_supply
    }

    public(friend) fun claim_interest<T0: drop, T1: drop, T2: drop>(arg0: u128, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut Market<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, id<T0, T1, T2>(arg2));
        update_user_interest<T0, T1, T2>(arg2, arg1, arg0, arg3);
        let v0 = redeem_due_interest<T0, T1, T2>(arg2, arg1, arg4);
        let v1 = MarketInterestClaimedEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg1),
            sy_amount       : 0x2::coin::value<T0>(&v0),
            receiver        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MarketInterestClaimedEvent>(v1);
        v0
    }

    fun collect_reserve_fee_from_pool<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.pool_sy_balance) >= arg1, 3607);
        0x2::balance::join<T0>(&mut arg0.reserve_fee_vault, 0x2::balance::split<T0>(&mut arg0.pool_sy_balance, arg1));
    }

    fun collect_reserve_fees<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_fee_vault);
        if (v0 == 0) {
            return 0
        };
        let v1 = arg0.risk.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_fee_vault, v0), arg1), v1);
        let v2 = MarketReserveFeeCollectedEvent{
            market_state_id : id<T0, T1, T2>(arg0),
            treasury        : v1,
            amount          : v0,
            collector       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MarketReserveFeeCollectedEvent>(v2);
        v0
    }

    public fun collect_reserve_fees_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        collect_reserve_fees<T0, T1, T2>(arg0, arg3)
    }

    public fun collect_treasury_interest_by_acl<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x1::option::Option<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>, arg3: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg3, arg1, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"treasury.collect"));
        checkpoint_and_collect_treasury_interest<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun collect_treasury_interest_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x1::option::Option<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        checkpoint_and_collect_treasury_interest<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5)
    }

    public(friend) fun consume_price_info<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg3: &0x2::clock::Clock) : u128 {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::consume<T0>(arg2, arg1, id<T0, T1, T2>(arg0), arg0.price_aggregator_id, arg3)
    }

    public fun create_by_admin_cap<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: u64, arg3: u128, arg4: u64, arg5: address, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg8: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg9: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg10: u64, arg11: u64, arg12: 0x2::coin::TreasuryCap<T0>, arg13: 0x2::coin::TreasuryCap<T1>, arg14: 0x2::coin::TreasuryCap<T2>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : Market<T0, T1, T2> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert_valid_create(arg2, arg3, arg4, arg15);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg9) <= 18446744073709551616, 3602);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::assert_valid_market_parameters(arg6, arg7, arg8, arg2 - 0x2::clock::timestamp_ms(arg15));
        assert!(0x2::coin::total_supply<T0>(&arg12) == 0, 3633);
        assert!(0x2::coin::total_supply<T1>(&arg13) == 0, 3624);
        assert!(0x2::coin::total_supply<T2>(&arg14) == 0, 3625);
        let v0 = 0x2::object::new(arg16);
        let v1 = CoinAuthority<T0, T1, T2>{
            sy_treasury : arg12,
            pt_treasury : arg13,
            yt_treasury : arg14,
        };
        let v2 = SettlementState{
            is_settled       : false,
            settled_py_index : 0,
        };
        let v3 = PyIndexGuard{
            mode                  : 0,
            max_step_growth_bps   : 0,
            max_window_growth_bps : 0,
            window_ms             : 0,
            anchor_index_raw      : 0,
            anchor_timestamp_ms   : 0,
        };
        let v4 = RiskConfig{
            treasury          : arg5,
            interest_fee_rate : arg3,
            expiry_divisor    : arg4,
            market_cap        : arg10,
            asset_market_cap  : arg11,
            py_index_guard    : v3,
        };
        let v5 = RewardState{
            pool_reward_guard : 0,
            yt_reward_guard   : 0,
            lp_reward_guard   : 0,
        };
        let v6 = Market<T0, T1, T2>{
            id                         : v0,
            expiry                     : arg2,
            sy_type                    : 0x1::type_name::with_defining_ids<T0>(),
            pt_type                    : 0x1::type_name::with_defining_ids<T1>(),
            yt_type                    : 0x1::type_name::with_defining_ids<T2>(),
            price_aggregator_id        : 0x2::object::uid_to_inner(&v0),
            reward_distributor_id      : 0x1::option::none<0x2::object::ID>(),
            coin_authority             : v1,
            pt_supply                  : 0,
            yt_supply                  : 0,
            py_sy_balance              : 0x2::balance::zero<T0>(),
            py_index_stored            : 0,
            py_index_last_updated      : 0,
            interest_segment           : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::new(),
            total_treasury_interest    : 0,
            last_interest_timestamp    : 0,
            global_interest_index      : 0,
            settlement                 : v2,
            total_pt                   : 0,
            pool_sy_balance            : 0x2::balance::zero<T0>(),
            reserve_fee_vault          : 0x2::balance::zero<T0>(),
            lp_supply                  : 0,
            pool_status                : 0,
            pool_generation            : 0,
            last_ln_implied_rate       : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero(),
            scalar_root                : arg6,
            initial_anchor             : arg7,
            ln_fee_rate_root           : arg8,
            protocol_fee_rate          : arg9,
            protocol_fee_remainder_raw : 0,
            risk                       : v4,
            rewards                    : v5,
        };
        let v7 = MarketCreatedEvent{
            market_state_id : 0x2::object::id<Market<T0, T1, T2>>(&v6),
            expiry          : arg2,
            sy_type         : v6.sy_type,
            pt_type         : v6.pt_type,
            yt_type         : v6.yt_type,
            created_by      : 0x2::tx_context::sender(arg16),
        };
        0x2::event::emit<MarketCreatedEvent>(v7);
        v6
    }

    public fun create_reward_distributor_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert!(!reward_distributor_required<T0, T1, T2>(arg0), 3618);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::new_for_market(id<T0, T1, T2>(arg0), arg3);
        require_reward_distributor<T0, T1, T2>(arg0, &v0);
        0x2::transfer::public_share_object<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor>(v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(&v0)
    }

    fun credit_fraction(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg1: u128) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_accrued(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::accrued(arg0) + arg1);
    }

    fun current_py_index<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u128) : u128 {
        if (arg1 > arg0.py_index_stored) {
            arg1
        } else {
            arg0.py_index_stored
        }
    }

    public fun current_py_index_raw<T0: drop, T1: drop, T2: drop>(arg0: u128, arg1: &Market<T0, T1, T2>) : u128 {
        current_py_index<T0, T1, T2>(arg1, arg0)
    }

    public(friend) fun end_pool_reward_operation<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: RewardPoolOperation) {
        let RewardPoolOperation {
            market_state_id : v0,
            distributor_id  : v1,
        } = arg1;
        assert!(v0 == id<T0, T1, T2>(arg0), 3619);
        assert!(reward_distributor_id<T0, T1, T2>(arg0) == v1, 3618);
        assert!(pool_reward_gate_open<T0, T1, T2>(arg0), 3617);
        let v2 = PoolRewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<PoolRewardGateKey, bool>(&mut arg0.id, v2), 3617);
        arg0.rewards.pool_reward_guard = arg0.rewards.pool_reward_guard + 1;
    }

    public(friend) fun end_yt_reward_mutation<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: YtRewardMutation) {
        let YtRewardMutation {
            market_state_id : v0,
            distributor_id  : v1,
        } = arg1;
        assert!(v0 == id<T0, T1, T2>(arg0), 3619);
        assert!(reward_distributor_id<T0, T1, T2>(arg0) == v1, 3618);
        assert!(yt_reward_gate_open<T0, T1, T2>(arg0), 3617);
        let v2 = YtRewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<YtRewardGateKey, bool>(&mut arg0.id, v2), 3617);
    }

    fun execute_trade_core<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u8, arg2: u64, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) : TradeResult {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert_pool_active<T0, T1, T2>(arg0);
        assert!(arg0.expiry > v0, 3603);
        assert!(arg2 > 0, 3604);
        let v1 = arg0.expiry - v0;
        let v2 = 0x2::balance::value<T0>(&arg0.pool_sy_balance);
        let v3 = if (arg1 == 0) {
            let (v4, v5, v6) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_pt_for_sy_indexed(arg0.total_pt, v2, arg4, arg0.last_ln_implied_rate, arg0.scalar_root, arg0.initial_anchor, arg0.ln_fee_rate_root, arg2, v1);
            assert!(v4 >= arg3, 3608);
            assert!(v4 > 0, 3610);
            assert!(pt_sale_fits<T0, T1, T2>(arg0, arg0.total_pt, v2, arg2, v4, v5, arg4), 3610);
            let v7 = reserve_fee_from_fee<T0, T1, T2>(arg0, v5);
            TradeResult{is_pt_to_sy: true, amount_in: arg2, amount_out: v4, sy_amount: v4, pt_amount: arg2, fee: v5, reserve_fee: v7, new_ln_implied_rate: v6, time_to_expiry_ms: v1}
        } else if (arg1 == 1) {
            let (v8, v9, v10) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_pt_for_exact_sy_indexed(arg0.total_pt, v2, arg4, arg0.last_ln_implied_rate, arg0.scalar_root, arg0.initial_anchor, arg0.ln_fee_rate_root, arg2, v1);
            assert!(v8 > 0, 3610);
            assert!(v8 <= arg3, 3608);
            assert!(pt_sale_fits<T0, T1, T2>(arg0, arg0.total_pt, v2, v8, arg2, v9, arg4), 3610);
            let v11 = reserve_fee_from_fee<T0, T1, T2>(arg0, v9);
            TradeResult{is_pt_to_sy: true, amount_in: v8, amount_out: arg2, sy_amount: arg2, pt_amount: v8, fee: v9, reserve_fee: v11, new_ln_implied_rate: v10, time_to_expiry_ms: v1}
        } else if (arg1 == 2) {
            let (v12, v13, v14, v15) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_sy_for_pt_indexed(arg0.total_pt, v2, arg4, arg0.last_ln_implied_rate, arg0.scalar_root, arg0.initial_anchor, arg0.ln_fee_rate_root, arg2, v1);
            assert!(v12 >= arg3, 3608);
            assert!(v12 > 0, 3610);
            let v16 = reserve_fee_from_fee<T0, T1, T2>(arg0, v14);
            TradeResult{is_pt_to_sy: false, amount_in: v13, amount_out: v12, sy_amount: v13, pt_amount: v12, fee: v14, reserve_fee: v16, new_ln_implied_rate: v15, time_to_expiry_ms: v1}
        } else {
            assert!(arg1 == 3, 3611);
            let (v17, v18, v19) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_sy_for_exact_pt_indexed(arg0.total_pt, v2, arg4, arg0.last_ln_implied_rate, arg0.scalar_root, arg0.initial_anchor, arg0.ln_fee_rate_root, arg2, v1);
            assert!(v17 > 0, 3610);
            assert!(v17 <= arg3, 3608);
            let v20 = reserve_fee_from_fee<T0, T1, T2>(arg0, v18);
            TradeResult{is_pt_to_sy: false, amount_in: v17, amount_out: arg2, sy_amount: v17, pt_amount: arg2, fee: v18, reserve_fee: v20, new_ln_implied_rate: v19, time_to_expiry_ms: v1}
        };
        let v21 = v3;
        if (v21.reserve_fee > 0) {
            let (v22, v23) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::trade_reserves(arg0.total_pt, v2, v21.pt_amount, v21.sy_amount, v21.reserve_fee, v21.is_pt_to_sy);
            v21.new_ln_implied_rate = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::ln_rate_after_reserve_change(arg0.total_pt, v2, v22, v23, arg4, arg0.last_ln_implied_rate, arg0.scalar_root, v1);
        };
        v21
    }

    public fun expiry<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.expiry
    }

    public(friend) fun finish_buy_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: BuyYtReceipt, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_pool_mutation_allowed<T0, T1, T2>(arg0);
        let BuyYtReceipt {
            market_state_id     : v0,
            pt_amount           : v1,
            sy_amount           : v2,
            fee                 : v3,
            reserve_fee         : v4,
            new_ln_implied_rate : v5,
            time_to_expiry_ms   : v6,
            sy_index_raw        : v7,
        } = arg1;
        assert!(v0 == id<T0, T1, T2>(arg0), 3613);
        assert!(v1 == arg2, 3605);
        add_pool_pt<T0, T1, T2>(arg0, arg2);
        set_last_ln_implied_rate<T0, T1, T2>(arg0, v5, v6, v7);
        let v8 = MarketSwapEvent{
            market_state_id : v0,
            is_pt_to_sy     : true,
            amount_in       : arg2,
            amount_out      : v2,
            fee             : v3,
            reserve_fee     : v4,
            trader          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketSwapEvent>(v8);
    }

    public(friend) fun initialize_liquidity_by_admin<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg5: u128, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x2::coin::Coin<T0>) {
        assert!(arg2.pool_status == 0 || arg2.pool_status == 2, 3635);
        assert_pool_empty<T0, T1, T2>(arg2);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg3) == 0, 3636);
        assert!(reward_distributor_required<T0, T1, T2>(arg2), 3615);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg4) == reward_distributor_id<T0, T1, T2>(arg2) && 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg4) == id<T0, T1, T2>(arg2), 3618);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope()) > 0;
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope()) > 0;
        assert!(pool_reward_gate_open<T0, T1, T2>(arg2) == v0, 3637);
        if (v1) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_reward_mutation_allowed(arg3, reward_distributor_id<T0, T1, T2>(arg2));
        } else {
            assert!(!0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::reward_gate_open(arg3), 3616);
        };
        let v2 = arg2.pool_status;
        arg2.pool_status = 1;
        arg2.pool_generation = arg2.pool_generation + 1;
        let (v3, v4, v5, v6) = add_liquidity_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, v0, v1, true, arg7, arg8);
        if (!v0) {
            arg2.rewards.pool_reward_guard = arg2.rewards.pool_reward_guard + 1;
        };
        let v7 = MarketPoolLifecycleEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            previous_status : v2,
            new_status      : 1,
            pool_generation : arg2.pool_generation,
            actor           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<MarketPoolLifecycleEvent>(v7);
        (v3, v4, v5, v6)
    }

    public fun interest_dust<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u128 {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::dust(&arg0.interest_segment)
    }

    fun is_expired(arg0: u64, arg1: u64) : bool {
        arg1 >= arg0
    }

    public fun is_pool_active<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : bool {
        arg0.pool_status == 1
    }

    public fun is_settled<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : bool {
        arg0.settlement.is_settled
    }

    fun join_pool_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool_sy_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun join_py_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.py_sy_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun lp_reward_guard<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.rewards.lp_reward_guard
    }

    public fun lp_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.lp_supply
    }

    fun mint_lp<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) {
        assert!(arg1 > 0, 3604);
        arg0.lp_supply = arg0.lp_supply + arg1;
    }

    fun mint_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 3604);
        0x2::coin::mint<T1>(&mut arg0.coin_authority.pt_treasury, arg1, arg2)
    }

    fun mint_py_supply<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u64) {
        assert!(arg2 > 0, 3604);
        assert_yt_reward_mutation_allowed<T0, T1, T2>(arg0);
        arg0.pt_supply = arg0.pt_supply + arg2;
        arg0.yt_supply = arg0.yt_supply + arg2;
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::restart(&mut arg0.interest_segment, arg0.py_index_stored, arg0.yt_supply);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg1, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_yt(arg1, arg2);
    }

    public(friend) fun mint_py_with_sy_index<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u128, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &mut Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert!(!is_expired(arg3.expiry, 0x2::clock::timestamp_ms(arg4)), 3603);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, id<T0, T1, T2>(arg3));
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 3604);
        let v1 = calc_py_amount_for_sy<T0, T1, T2>(v0, arg1, arg3);
        assert!(v1 > 0, 3604);
        join_py_sy<T0, T1, T2>(arg3, arg0);
        update_user_interest<T0, T1, T2>(arg3, arg2, arg1, arg4);
        mint_py_supply<T0, T1, T2>(arg3, arg2, v1);
        credit_fraction(arg2, (v0 as u128) * 18446744073709551616 - 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::principal_value(v1, arg3.py_index_stored));
        let v2 = MarketMintPyEvent{
            market_state_id : id<T0, T1, T2>(arg3),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg2),
            sy_amount_in    : v0,
            pt_amount       : v1,
            yt_amount       : v1,
            expiry          : arg3.expiry,
        };
        0x2::event::emit<MarketMintPyEvent>(v2);
        v1
    }

    public(friend) fun mint_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 3604);
        0x2::coin::mint<T0>(&mut arg0.coin_authority.sy_treasury, arg1, arg2)
    }

    public fun pool_active() : u8 {
        1
    }

    public fun pool_empty() : u8 {
        2
    }

    public fun pool_generation<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.pool_generation
    }

    public fun pool_reward_gate_open<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : bool {
        let v0 = PoolRewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists<PoolRewardGateKey>(&arg0.id, v0)
    }

    public fun pool_reward_guard<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.rewards.pool_reward_guard
    }

    public fun pool_status<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u8 {
        arg0.pool_status
    }

    public fun pool_uninitialized() : u8 {
        0
    }

    public fun price_aggregator_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        arg0.price_aggregator_id
    }

    fun pt_sale_fits<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) : bool {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg3 > 18446744073709551615 - arg1) {
            true
        } else {
            arg4 >= arg2
        };
        if (v0) {
            return false
        };
        let (v1, _) = reserve_fee_with_remainder(arg5, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0.protocol_fee_rate), arg0.protocol_fee_remainder_raw);
        v1 < arg2 - arg4 && 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::below_pt_limit(arg1 + arg3, arg2 - arg4 - v1, arg6)
    }

    public fun pt_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T1>>(&arg0.coin_authority.pt_treasury)
    }

    public fun pt_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.pt_type
    }

    public fun py_index_guard_anchor_index_raw(arg0: &PyIndexGuard) : u128 {
        arg0.anchor_index_raw
    }

    public fun py_index_guard_anchor_timestamp_ms(arg0: &PyIndexGuard) : u64 {
        arg0.anchor_timestamp_ms
    }

    public fun py_index_guard_max_step_growth_bps(arg0: &PyIndexGuard) : u64 {
        arg0.max_step_growth_bps
    }

    public fun py_index_guard_max_window_growth_bps(arg0: &PyIndexGuard) : u64 {
        arg0.max_window_growth_bps
    }

    public fun py_index_guard_mode(arg0: &PyIndexGuard) : u8 {
        arg0.mode
    }

    public fun py_index_guard_window_ms(arg0: &PyIndexGuard) : u64 {
        arg0.window_ms
    }

    public fun quote_balanced_lp<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::Quote {
        let v0 = if (arg1.expiry > 0x2::clock::timestamp_ms(arg3) && arg1.pool_status == 1) {
            arg1.expiry - 0x2::clock::timestamp_ms(arg3)
        } else {
            0
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_balanced_lp_indexed(arg1.lp_supply, arg1.total_pt, 0x2::balance::value<T0>(&arg1.pool_sy_balance), current_py_index<T0, T1, T2>(arg1, arg2), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg1.protocol_fee_rate), arg1.protocol_fee_remainder_raw, arg0, v0, 64)
    }

    public fun quote_exact_pt_for_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = current_py_index<T0, T1, T2>(arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v3 = if (arg1.pool_status != 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg1.expiry <= v1
        };
        if (v3) {
            return (0, 0)
        };
        let (v4, v5, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_pt_for_sy_indexed(arg1.total_pt, v2, v0, arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v1);
        if (!pt_sale_fits<T0, T1, T2>(arg1, arg1.total_pt, v2, arg0, v4, v5, v0)) {
            return (0, 0)
        };
        (v4, v5)
    }

    public fun quote_exact_sy_for_pt<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v2 = if (arg1.pool_status != 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg1.expiry <= v0
        };
        if (v2) {
            return (0, 0)
        };
        let (v3, v4, _, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_sy_for_pt_indexed(arg1.total_pt, v1, current_py_index<T0, T1, T2>(arg1, arg2), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v0);
        (v3, v4)
    }

    public fun quote_exact_sy_for_yt<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (arg0 == 0) {
            true
        } else if (v0 <= 1) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (arg1.pool_status != 1) {
            true
        } else {
            arg1.expiry <= v1
        };
        if (v2) {
            return (0, 0)
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_sy_for_yt_indexed(arg1.total_pt, v0, current_py_index<T0, T1, T2>(arg1, arg2), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v1)
    }

    public fun quote_lp_sy_swap<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v2 = if (arg0 <= 1) {
            true
        } else if (arg1.pool_status != 1) {
            true
        } else if (arg1.total_pt <= 1) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg1.expiry <= v0
        };
        if (v2) {
            return (0, 0, 0)
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_lp_sy_swap_indexed(arg1.lp_supply, arg1.total_pt, v1, current_py_index<T0, T1, T2>(arg1, arg2), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v0)
    }

    public fun quote_non_keep_yt_split<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        let v0 = current_py_index<T0, T1, T2>(arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v3 = if (arg0 == 0) {
            true
        } else if (arg1.pool_status != 1) {
            true
        } else if (arg1.total_pt <= 1) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg1.expiry <= v1
        };
        if (v3) {
            return 0
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_non_keep_yt_split_indexed(arg1.total_pt, v2, v0, current_py_index<T0, T1, T2>(arg1, v0), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v1)
    }

    public fun quote_pt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = current_py_index<T0, T1, T2>(arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v3 = if (arg1.pool_status != 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (v2 == 0) {
            true
        } else if (arg0 >= v2) {
            true
        } else {
            arg1.expiry <= v1
        };
        if (v3) {
            return (0, 0)
        };
        let (v4, v5, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_pt_for_exact_sy_indexed(arg1.total_pt, v2, v0, arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v1);
        if (!pt_sale_fits<T0, T1, T2>(arg1, arg1.total_pt, v2, v4, arg0, v5, v0)) {
            return (0, 0)
        };
        (v4, v5)
    }

    public fun quote_py_mint<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &Market<T0, T1, T2>) : (u64, u64) {
        if (arg0 == 0) {
            return (0, 0)
        };
        let v0 = calc_sy_amount_for_py<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = calc_py_amount_for_sy<T0, T1, T2>(v0, arg1, arg2);
        assert!(v1 >= arg0, 3628);
        (v0, v1)
    }

    public fun quote_remove_liquidity_to_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u8, u64, u64, u64, u64, u64) {
        let v0 = current_py_index<T0, T1, T2>(arg1, arg2);
        let v1 = arg1.lp_supply;
        let v2 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v3 = arg1.total_pt;
        let v4 = if (arg1.pool_status != 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg0 > v1
        };
        if (v4) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v5 = arg0 == v1;
        let v6 = if (v5) {
            v2
        } else {
            (((arg0 as u128) * (v2 as u128) / (v1 as u128)) as u64)
        };
        let v7 = if (v5) {
            v3
        } else {
            (((arg0 as u128) * (v3 as u128) / (v1 as u128)) as u64)
        };
        if (v6 == 0 && v7 == 0) {
            return (0, 0, 0, 0, 0, 0)
        };
        if (v7 == 0) {
            return (3, v6, 0, 0, v6, 0)
        };
        let v8 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.expiry <= v8) {
            if (!arg1.settlement.is_settled) {
                return (4, v6, v7, 0, v6, 0)
            };
            let v9 = ((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::principal_value(v7, arg1.settlement.settled_py_index) / 18446744073709551616) as u64);
            return (2, v6, v7, v9, v6 + v9, 0)
        };
        let v10 = v2 - v6;
        let v11 = v3 - v7;
        let v12 = if (v5) {
            true
        } else if (v10 == 0) {
            true
        } else {
            v11 == 0
        };
        if (v12) {
            return (5, v6, v7, 0, v6, 0)
        };
        let (v13, v14, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_exact_pt_for_sy_indexed(v11, v10, v0, arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, v7, arg1.expiry - v8);
        if (v13 == 0 || !pt_sale_fits<T0, T1, T2>(arg1, v11, v10, v7, v13, v14, v0)) {
            return (5, v6, v7, 0, v6, 0)
        };
        (1, v6, v7, v13, v6 + v13, v14)
    }

    public fun quote_sy_for_exact_pt<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v2 = if (arg1.pool_status != 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (v1 == 0) {
            true
        } else if (arg0 >= arg1.total_pt) {
            true
        } else {
            arg1.expiry <= v0
        };
        if (v2) {
            return (0, 0)
        };
        let (v3, v4, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_sy_for_exact_pt_indexed(arg1.total_pt, v1, current_py_index<T0, T1, T2>(arg1, arg2), arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v0);
        (v3, v4)
    }

    public fun quote_sy_for_exact_yt<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = current_py_index<T0, T1, T2>(arg1, arg2);
        if (arg0 == 0) {
            return (0, 0, 0, 0)
        };
        let (v1, _) = quote_py_mint<T0, T1, T2>(arg0, v0, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::balance::value<T0>(&arg1.pool_sy_balance);
        let v5 = if (arg1.pool_status != 1) {
            true
        } else if (arg1.total_pt == 0) {
            true
        } else if (v4 == 0) {
            true
        } else {
            arg1.expiry <= v3
        };
        if (v5) {
            return (0, v1, 0, 18446744073709551615)
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_sy_for_exact_yt_indexed(arg1.total_pt, v4, v0, arg1.last_ln_implied_rate, arg1.scalar_root, arg1.initial_anchor, arg1.ln_fee_rate_root, arg0, arg1.expiry - v3)
    }

    public fun quote_yt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &Market<T0, T1, T2>, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        quote_yt_for_exact_sy_once<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    fun quote_yt_for_exact_sy_once<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &Market<T0, T1, T2>, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = current_py_index<T0, T1, T2>(arg2, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::balance::value<T0>(&arg2.pool_sy_balance);
        let v3 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2.pool_status != 1) {
            true
        } else if (arg2.total_pt <= 1) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg2.expiry <= v1
        };
        if (v3) {
            return (0, 0, 0, 0)
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::quote_yt_for_exact_sy_indexed(arg2.total_pt, v2, v0, current_py_index<T0, T1, T2>(arg2, v0), arg2.last_ln_implied_rate, arg2.scalar_root, arg2.initial_anchor, arg2.ln_fee_rate_root, arg0, arg1, arg2.expiry - v1)
    }

    fun quote_yt_sale<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg0 == 0) {
            return (0, 0, 0)
        };
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, current_py_index<T0, T1, T2>(arg1, arg2)) as u64);
        let (v1, _) = quote_sy_for_exact_pt<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v3 = if (v1 > 0 && v0 > v1) {
            v0 - v1
        } else {
            0
        };
        (v0, v1, v3)
    }

    fun redeem_due_interest<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::accrued(arg1);
        let v1 = v0 / 18446744073709551616;
        assert!(v1 <= 18446744073709551615, 3630);
        let v2 = (v1 as u64);
        let v3 = (v2 as u128) * 18446744073709551616;
        assert!(v3 <= v0, 3630);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_accrued(arg1, v0 - v3);
        if (v2 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        split_py_sy<T0, T1, T2>(arg0, v2, arg2)
    }

    public fun redeem_pt_out<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg2, b"market", id<T0, T1, T2>(arg3), 3623);
        assert!(arg3.expiry > 0x2::clock::timestamp_ms(arg4), 3603);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, id<T0, T1, T2>(arg3));
        assert!(arg0 > 0, 3604);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg1, arg0);
        mint_pt<T0, T1, T2>(arg3, arg0, arg5)
    }

    public(friend) fun redeem_py_after_expiry<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut Market<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_expired(arg2.expiry, 0x2::clock::timestamp_ms(arg3)), 3620);
        assert!(arg2.settlement.is_settled, 3621);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, id<T0, T1, T2>(arg2));
        assert!(arg0 > 0, 3604);
        let v0 = arg2.settlement.settled_py_index;
        update_user_interest<T0, T1, T2>(arg2, arg1, v0, arg3);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::principal_value(arg0, v0);
        let v2 = ((v1 / 18446744073709551616) as u64);
        assert!(v2 > 0, 3610);
        burn_py_supply<T0, T1, T2>(arg2, arg1, arg0, 0);
        credit_fraction(arg1, v1 % 18446744073709551616);
        let v3 = split_py_sy<T0, T1, T2>(arg2, v2, arg4);
        let v4 = MarketRedeemPyEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg1),
            pt_amount       : arg0,
            yt_amount       : 0,
            sy_amount_out   : v2,
            expiry          : arg2.expiry,
            redeemer        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MarketRedeemPyEvent>(v4);
        v3
    }

    public(friend) fun redeem_py_before_expiry_with_sy_index<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &mut Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_expired(arg3.expiry, 0x2::clock::timestamp_ms(arg4)), 3603);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, id<T0, T1, T2>(arg3));
        assert!(arg0 > 0, 3604);
        update_user_interest<T0, T1, T2>(arg3, arg2, arg1, arg4);
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::principal_value(arg0, current_py_index<T0, T1, T2>(arg3, arg1));
        let v1 = ((v0 / 18446744073709551616) as u64);
        assert!(v1 > 0, 3610);
        burn_py_supply<T0, T1, T2>(arg3, arg2, arg0, arg0);
        credit_fraction(arg2, v0 % 18446744073709551616);
        let v2 = split_py_sy<T0, T1, T2>(arg3, v1, arg5);
        let v3 = MarketRedeemPyEvent{
            market_state_id : id<T0, T1, T2>(arg3),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg2),
            pt_amount       : arg0,
            yt_amount       : arg0,
            sy_amount_out   : v1,
            expiry          : arg3.expiry,
            redeemer        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketRedeemPyEvent>(v3);
        v2
    }

    public(friend) fun redeem_yt_after_expiry<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut Market<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_expired(arg2.expiry, 0x2::clock::timestamp_ms(arg3)), 3620);
        assert!(arg2.settlement.is_settled, 3621);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, id<T0, T1, T2>(arg2));
        assert!(arg0 > 0, 3604);
        let v0 = arg2.settlement.settled_py_index;
        update_user_interest<T0, T1, T2>(arg2, arg1, v0, arg3);
        burn_py_supply<T0, T1, T2>(arg2, arg1, 0, arg0);
        let v1 = redeem_due_interest<T0, T1, T2>(arg2, arg1, arg4);
        let v2 = MarketYtRedeemedAfterExpiryEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg1),
            yt_amount       : arg0,
            sy_interest_out : 0x2::coin::value<T0>(&v1),
            redeemer        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MarketYtRedeemedAfterExpiryEvent>(v2);
        v1
    }

    public(friend) fun redeem_yt_with_external_pt_before_expiry_with_sy_index<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &mut Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExternalPtRedeemReceipt) {
        assert!(arg3.expiry > 0x2::clock::timestamp_ms(arg4), 3603);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, id<T0, T1, T2>(arg3));
        assert!(arg0 > 0, 3604);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg2) >= arg0, 3606);
        assert_yt_reward_mutation_allowed<T0, T1, T2>(arg3);
        update_user_interest<T0, T1, T2>(arg3, arg2, arg1, arg4);
        assert!(arg3.pt_supply >= arg0, 3605);
        assert!(arg3.yt_supply >= arg0, 3606);
        arg3.pt_supply = arg3.pt_supply - arg0;
        arg3.yt_supply = arg3.yt_supply - arg0;
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_yt(arg2, arg0);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::restart(&mut arg3.interest_segment, arg3.py_index_stored, arg3.yt_supply);
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::principal_value(arg0, current_py_index<T0, T1, T2>(arg3, arg1));
        let v1 = ((v0 / 18446744073709551616) as u64);
        assert!(v1 > 0, 3610);
        credit_fraction(arg2, v0 % 18446744073709551616);
        let v2 = split_py_sy<T0, T1, T2>(arg3, v1, arg5);
        let v3 = MarketRedeemPyEvent{
            market_state_id : id<T0, T1, T2>(arg3),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg2),
            pt_amount       : arg0,
            yt_amount       : arg0,
            sy_amount_out   : v1,
            expiry          : arg3.expiry,
            redeemer        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketRedeemPyEvent>(v3);
        let v4 = ExternalPtRedeemReceipt{
            market_state_id : id<T0, T1, T2>(arg3),
            pt_amount       : arg0,
        };
        (v2, v4)
    }

    public(friend) fun remove_liquidity<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut Market<T0, T1, T2>, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert_pool_active<T0, T1, T2>(arg1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, id<T0, T1, T2>(arg1));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_pool_match(arg2, id<T0, T1, T2>(arg1));
        assert!(arg0 > 0, 3604);
        assert_pool_mutation_allowed<T0, T1, T2>(arg1);
        assert_lp_reward_mutation_allowed<T0, T1, T2>(arg1, arg2);
        let v0 = arg1.lp_supply;
        assert!(v0 > 0, 3609);
        assert!(arg0 <= v0, 3609);
        let v1 = arg0 == v0;
        let v2 = if (v1) {
            0x2::balance::value<T0>(&arg1.pool_sy_balance)
        } else {
            (((arg0 as u128) * (0x2::balance::value<T0>(&arg1.pool_sy_balance) as u128) / (v0 as u128)) as u64)
        };
        let v3 = if (v1) {
            arg1.total_pt
        } else {
            (((arg0 as u128) * (arg1.total_pt as u128) / (v0 as u128)) as u64)
        };
        assert!(v2 > 0 || v3 > 0, 3610);
        burn_lp<T0, T1, T2>(arg1, arg0);
        if (v3 > 0) {
            remove_pool_pt<T0, T1, T2>(arg1, v3);
        };
        let v4 = split_pool_sy<T0, T1, T2>(arg1, v2, arg3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_lp(arg2, arg0);
        if (v1) {
            assert_pool_empty<T0, T1, T2>(arg1);
            arg1.pool_status = 2;
            arg1.last_ln_implied_rate = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero();
            let v5 = MarketPoolLifecycleEvent{
                market_state_id : id<T0, T1, T2>(arg1),
                previous_status : 1,
                new_status      : 2,
                pool_generation : arg1.pool_generation,
                actor           : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<MarketPoolLifecycleEvent>(v5);
        };
        let v6 = MarketRemoveLiquidityEvent{
            market_state_id : id<T0, T1, T2>(arg1),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg2),
            sy_amount       : v2,
            pt_amount       : v3,
            lp_amount       : arg0,
            provider        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketRemoveLiquidityEvent>(v6);
        (v4, v3)
    }

    fun remove_pool_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) {
        assert!(arg1 > 0, 3604);
        assert!(arg0.total_pt >= arg1, 3605);
        arg0.total_pt = arg0.total_pt - arg1;
    }

    public(friend) fun repay_borrowed_pt_for_yt_redeem<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: BorrowPtReceipt, arg2: u64) {
        let BorrowPtReceipt {
            market_state_id : v0,
            pt_amount       : v1,
        } = arg1;
        assert!(v0 == id<T0, T1, T2>(arg0), 3612);
        assert!(v1 == arg2, 3605);
    }

    public(friend) fun require_reward_distributor<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor) {
        assert!(!pool_reward_gate_open<T0, T1, T2>(arg0), 3616);
        assert!(!yt_reward_gate_open<T0, T1, T2>(arg0), 3616);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg1) == id<T0, T1, T2>(arg0), 3618);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg1);
        if (reward_distributor_required<T0, T1, T2>(arg0)) {
            assert!(reward_distributor_id<T0, T1, T2>(arg0) == v0, 3618);
            return
        };
        arg0.rewards.pool_reward_guard = arg0.rewards.pool_reward_guard + 1;
        arg0.rewards.yt_reward_guard = arg0.rewards.yt_reward_guard + 1;
        arg0.rewards.lp_reward_guard = arg0.rewards.lp_reward_guard + 1;
        0x1::option::fill<0x2::object::ID>(&mut arg0.reward_distributor_id, v0);
        let v1 = MarketRewardDistributorRequiredEvent{
            market_state_id : id<T0, T1, T2>(arg0),
            distributor_id  : v0,
        };
        0x2::event::emit<MarketRewardDistributorRequiredEvent>(v1);
    }

    fun reserve_fee_from_fee<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64) : u64 {
        let (v0, v1) = reserve_fee_with_remainder(arg1, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0.protocol_fee_rate), arg0.protocol_fee_remainder_raw);
        arg0.protocol_fee_remainder_raw = v1;
        v0
    }

    fun reserve_fee_with_remainder(arg0: u64, arg1: u128, arg2: u128) : (u64, u128) {
        assert!(arg1 <= 18446744073709551616, 3602);
        assert!(arg2 < 18446744073709551616, 3626);
        if (arg0 == 0 || arg1 == 0) {
            return (0, arg2)
        };
        let v0 = (arg0 as u256) * (arg1 as u256) + (arg2 as u256);
        let v1 = v0 / (18446744073709551616 as u256);
        let v2 = v0 % (18446744073709551616 as u256);
        assert!(v1 <= (arg0 as u256), 3626);
        assert!(v1 <= 18446744073709551615, 3626);
        assert!(v2 < (18446744073709551616 as u256), 3626);
        ((v1 as u64), (v2 as u128))
    }

    public fun reward_distributor_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        assert!(reward_distributor_required<T0, T1, T2>(arg0), 3615);
        *0x1::option::borrow<0x2::object::ID>(&arg0.reward_distributor_id)
    }

    public fun reward_distributor_required<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.reward_distributor_id)
    }

    fun set_asset_market_cap<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: u128, arg3: address) {
        arg0.risk.asset_market_cap = arg1;
        check_asset_market_cap<T0, T1, T2>(arg0, arg2);
        let v0 = MarketAssetMarketCapUpdatedEvent{
            market_state_id  : id<T0, T1, T2>(arg0),
            asset_market_cap : arg1,
            sy_index_raw     : arg2,
            actor            : arg3,
        };
        0x2::event::emit<MarketAssetMarketCapUpdatedEvent>(v0);
    }

    public fun set_asset_market_cap_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: u64, arg3: u128, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg5: &0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        set_asset_market_cap<T0, T1, T2>(arg0, arg2, arg3, 0x2::tx_context::sender(arg5));
    }

    fun set_last_ln_implied_rate<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg2: u64, arg3: u128) {
        arg0.last_ln_implied_rate = arg1;
        let v0 = 0x2::balance::value<T0>(&arg0.pool_sy_balance);
        let v1 = if (arg0.total_pt == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            arg2 == 0
        };
        let v2 = if (v1) {
            18446744073709551616
        } else {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::spot_pt_price_in_sy_indexed(arg0.total_pt, v0, arg3, arg1, arg0.scalar_root, arg0.initial_anchor, arg2)
        };
        let v3 = MarketImpliedRateUpdatedEvent{
            market_state_id     : id<T0, T1, T2>(arg0),
            ln_implied_rate_raw : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg1),
            pt_price_raw        : v2,
            total_pt            : arg0.total_pt,
            total_sy            : v0,
            lp_supply           : arg0.lp_supply,
        };
        0x2::event::emit<MarketImpliedRateUpdatedEvent>(v3);
    }

    fun set_market_cap<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: address) {
        arg0.risk.market_cap = arg1;
        check_market_cap<T0, T1, T2>(arg0);
        let v0 = MarketMarketCapUpdatedEvent{
            market_state_id : id<T0, T1, T2>(arg0),
            market_cap      : arg1,
            actor           : arg2,
        };
        0x2::event::emit<MarketMarketCapUpdatedEvent>(v0);
    }

    public fun set_market_cap_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: u64, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg4: &0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        set_market_cap<T0, T1, T2>(arg0, arg2, 0x2::tx_context::sender(arg4));
    }

    public fun set_treasury_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", id<T0, T1, T2>(arg0), 3623);
        let v0 = arg0.risk.treasury;
        if (v0 == arg3) {
            return
        };
        arg0.risk.treasury = arg3;
        let v1 = MarketTreasuryUpdatedEvent{
            market_state_id   : id<T0, T1, T2>(arg0),
            previous_treasury : v0,
            treasury          : arg3,
            actor             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MarketTreasuryUpdatedEvent>(v1);
    }

    public(friend) fun settle<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u128, arg2: &0x2::clock::Clock) : u128 {
        assert!(!arg0.settlement.is_settled, 3622);
        assert!(is_expired(arg0.expiry, 0x2::clock::timestamp_ms(arg2)), 3620);
        let (_, v1, v2) = update_interest_index<T0, T1, T2>(arg0, arg1, arg2);
        arg0.settlement.is_settled = true;
        arg0.settlement.settled_py_index = v1;
        let v3 = MarketSettledEvent{
            market_state_id                 : id<T0, T1, T2>(arg0),
            settled_py_index                : v1,
            treasury_interest_collected_raw : v2,
            settled_at_ms                   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketSettledEvent>(v3);
        v2
    }

    public(friend) fun settle_external_pt_redeem<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: ExternalPtRedeemReceipt, arg2: u64) {
        let ExternalPtRedeemReceipt {
            market_state_id : v0,
            pt_amount       : v1,
        } = arg1;
        assert!(v0 == id<T0, T1, T2>(arg0), 3614);
        assert!(v1 == arg2, 3605);
    }

    public fun settled_py_index<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u128 {
        arg0.settlement.settled_py_index
    }

    public fun snapshot<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : MarketSnapshot {
        let v0 = CoinAuthoritySnapshot{
            sy_treasury_id  : sy_treasury_id<T0, T1, T2>(arg0),
            pt_treasury_id  : pt_treasury_id<T0, T1, T2>(arg0),
            yt_treasury_id  : yt_treasury_id<T0, T1, T2>(arg0),
            sy_total_supply : 0x2::coin::total_supply<T0>(&arg0.coin_authority.sy_treasury),
            pt_total_supply : 0x2::coin::total_supply<T1>(&arg0.coin_authority.pt_treasury),
            yt_total_supply : 0x2::coin::total_supply<T2>(&arg0.coin_authority.yt_treasury),
        };
        MarketSnapshot{
            market_state_id             : id<T0, T1, T2>(arg0),
            expiry                      : arg0.expiry,
            price_aggregator_id         : arg0.price_aggregator_id,
            reward_distributor_id       : arg0.reward_distributor_id,
            coin_authority              : v0,
            pt_supply                   : arg0.pt_supply,
            yt_supply                   : arg0.yt_supply,
            py_sy_balance               : 0x2::balance::value<T0>(&arg0.py_sy_balance),
            py_index_stored             : arg0.py_index_stored,
            global_interest_index       : arg0.global_interest_index,
            total_treasury_interest_raw : arg0.total_treasury_interest,
            is_settled                  : arg0.settlement.is_settled,
            settled_py_index            : arg0.settlement.settled_py_index,
            total_pt                    : arg0.total_pt,
            pool_sy_balance             : 0x2::balance::value<T0>(&arg0.pool_sy_balance),
            reserve_fee_balance         : 0x2::balance::value<T0>(&arg0.reserve_fee_vault),
            protocol_fee_remainder_raw  : arg0.protocol_fee_remainder_raw,
            lp_supply                   : arg0.lp_supply,
            pool_status                 : arg0.pool_status,
            pool_generation             : arg0.pool_generation,
            treasury                    : arg0.risk.treasury,
            interest_fee_rate           : arg0.risk.interest_fee_rate,
            expiry_divisor              : arg0.risk.expiry_divisor,
            market_cap                  : arg0.risk.market_cap,
            asset_market_cap            : arg0.risk.asset_market_cap,
            py_index_guard              : arg0.risk.py_index_guard,
            yt_reward_guard             : arg0.rewards.yt_reward_guard,
            lp_reward_guard             : arg0.rewards.lp_reward_guard,
            pool_reward_guard           : arg0.rewards.pool_reward_guard,
        }
    }

    public fun snapshot_asset_market_cap(arg0: &MarketSnapshot) : u64 {
        arg0.asset_market_cap
    }

    public fun snapshot_expiry(arg0: &MarketSnapshot) : u64 {
        arg0.expiry
    }

    public fun snapshot_expiry_divisor(arg0: &MarketSnapshot) : u64 {
        arg0.expiry_divisor
    }

    public fun snapshot_global_interest_index(arg0: &MarketSnapshot) : u128 {
        arg0.global_interest_index
    }

    public fun snapshot_interest_fee_rate(arg0: &MarketSnapshot) : u128 {
        arg0.interest_fee_rate
    }

    public fun snapshot_is_settled(arg0: &MarketSnapshot) : bool {
        arg0.is_settled
    }

    public fun snapshot_lp_reward_guard(arg0: &MarketSnapshot) : u64 {
        arg0.lp_reward_guard
    }

    public fun snapshot_lp_supply(arg0: &MarketSnapshot) : u64 {
        arg0.lp_supply
    }

    public fun snapshot_market_cap(arg0: &MarketSnapshot) : u64 {
        arg0.market_cap
    }

    public fun snapshot_market_state_id(arg0: &MarketSnapshot) : 0x2::object::ID {
        arg0.market_state_id
    }

    public fun snapshot_pool_generation(arg0: &MarketSnapshot) : u64 {
        arg0.pool_generation
    }

    public fun snapshot_pool_reward_guard(arg0: &MarketSnapshot) : u64 {
        arg0.pool_reward_guard
    }

    public fun snapshot_pool_status(arg0: &MarketSnapshot) : u8 {
        arg0.pool_status
    }

    public fun snapshot_pool_sy_balance(arg0: &MarketSnapshot) : u64 {
        arg0.pool_sy_balance
    }

    public fun snapshot_price_aggregator_id(arg0: &MarketSnapshot) : 0x2::object::ID {
        arg0.price_aggregator_id
    }

    public fun snapshot_protocol_fee_remainder_raw(arg0: &MarketSnapshot) : u128 {
        arg0.protocol_fee_remainder_raw
    }

    public fun snapshot_pt_supply(arg0: &MarketSnapshot) : u64 {
        arg0.pt_supply
    }

    public fun snapshot_pt_total_supply(arg0: &MarketSnapshot) : u64 {
        arg0.coin_authority.pt_total_supply
    }

    public fun snapshot_pt_treasury_id(arg0: &MarketSnapshot) : 0x2::object::ID {
        arg0.coin_authority.pt_treasury_id
    }

    public fun snapshot_py_index_guard(arg0: &MarketSnapshot) : PyIndexGuard {
        arg0.py_index_guard
    }

    public fun snapshot_py_index_stored(arg0: &MarketSnapshot) : u128 {
        arg0.py_index_stored
    }

    public fun snapshot_py_sy_balance(arg0: &MarketSnapshot) : u64 {
        arg0.py_sy_balance
    }

    public fun snapshot_reserve_fee_balance(arg0: &MarketSnapshot) : u64 {
        arg0.reserve_fee_balance
    }

    public fun snapshot_reward_distributor_id(arg0: &MarketSnapshot) : 0x1::option::Option<0x2::object::ID> {
        arg0.reward_distributor_id
    }

    public fun snapshot_settled_py_index(arg0: &MarketSnapshot) : u128 {
        arg0.settled_py_index
    }

    public fun snapshot_sy_total_supply(arg0: &MarketSnapshot) : u64 {
        arg0.coin_authority.sy_total_supply
    }

    public fun snapshot_sy_treasury_id(arg0: &MarketSnapshot) : 0x2::object::ID {
        arg0.coin_authority.sy_treasury_id
    }

    public fun snapshot_total_pt(arg0: &MarketSnapshot) : u64 {
        arg0.total_pt
    }

    public fun snapshot_total_treasury_interest_raw(arg0: &MarketSnapshot) : u128 {
        arg0.total_treasury_interest_raw
    }

    public fun snapshot_treasury(arg0: &MarketSnapshot) : address {
        arg0.treasury
    }

    public fun snapshot_yt_reward_guard(arg0: &MarketSnapshot) : u64 {
        arg0.yt_reward_guard
    }

    public fun snapshot_yt_supply(arg0: &MarketSnapshot) : u64 {
        arg0.yt_supply
    }

    public fun snapshot_yt_total_supply(arg0: &MarketSnapshot) : u64 {
        arg0.coin_authority.yt_total_supply
    }

    public fun snapshot_yt_treasury_id(arg0: &MarketSnapshot) : 0x2::object::ID {
        arg0.coin_authority.yt_treasury_id
    }

    fun split_pool_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.pool_sy_balance) >= arg1, 3607);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool_sy_balance, arg1), arg2)
    }

    fun split_py_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.py_sy_balance) >= arg1, 3607);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.py_sy_balance, arg1), arg2)
    }

    public fun spot_pt_price_in_sy<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>, arg1: u128, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (arg0.pool_status != 1) {
            true
        } else if (arg0.total_pt == 0) {
            true
        } else {
            0x2::balance::value<T0>(&arg0.pool_sy_balance) == 0
        };
        if (v1) {
            return 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::one())
        };
        if (arg0.expiry <= v0) {
            return 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::one())
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::spot_pt_price_in_sy_indexed(arg0.total_pt, 0x2::balance::value<T0>(&arg0.pool_sy_balance), current_py_index<T0, T1, T2>(arg0, arg1), arg0.last_ln_implied_rate, arg0.scalar_root, arg0.initial_anchor, arg0.expiry - v0)
    }

    public(friend) fun swap_pt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0, T1, T2>(arg2);
        let v0 = execute_trade_core<T0, T1, T2>(arg2, 1, arg0, arg1, arg3, arg4);
        add_pool_pt<T0, T1, T2>(arg2, v0.pt_amount);
        let v1 = split_pool_sy<T0, T1, T2>(arg2, v0.sy_amount, arg5);
        collect_reserve_fee_from_pool<T0, T1, T2>(arg2, v0.reserve_fee);
        set_last_ln_implied_rate<T0, T1, T2>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v2 = MarketSwapEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            is_pt_to_sy     : v0.is_pt_to_sy,
            amount_in       : v0.amount_in,
            amount_out      : v0.amount_out,
            fee             : v0.fee,
            reserve_fee     : v0.reserve_fee,
            trader          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketSwapEvent>(v2);
        (v0.pt_amount, v1)
    }

    public(friend) fun swap_pt_for_sy<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool_mutation_allowed<T0, T1, T2>(arg2);
        let v0 = execute_trade_core<T0, T1, T2>(arg2, 0, arg0, arg1, arg3, arg4);
        add_pool_pt<T0, T1, T2>(arg2, v0.pt_amount);
        let v1 = split_pool_sy<T0, T1, T2>(arg2, v0.sy_amount, arg5);
        collect_reserve_fee_from_pool<T0, T1, T2>(arg2, v0.reserve_fee);
        set_last_ln_implied_rate<T0, T1, T2>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v2 = MarketSwapEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            is_pt_to_sy     : v0.is_pt_to_sy,
            amount_in       : v0.amount_in,
            amount_out      : v0.amount_out,
            fee             : v0.fee,
            reserve_fee     : v0.reserve_fee,
            trader          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketSwapEvent>(v2);
        v1
    }

    public(friend) fun swap_sy_for_exact_pt<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut Market<T0, T1, T2>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0, T1, T2>(arg3);
        let v0 = execute_trade_core<T0, T1, T2>(arg3, 3, arg1, arg2, arg4, arg5);
        assert!(0x2::coin::value<T0>(&arg0) >= v0.sy_amount, 3608);
        join_pool_sy<T0, T1, T2>(arg3, 0x2::coin::split<T0>(&mut arg0, v0.sy_amount, arg6));
        remove_pool_pt<T0, T1, T2>(arg3, v0.pt_amount);
        collect_reserve_fee_from_pool<T0, T1, T2>(arg3, v0.reserve_fee);
        check_market_caps<T0, T1, T2>(arg3, arg4);
        set_last_ln_implied_rate<T0, T1, T2>(arg3, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg4);
        let v1 = MarketSwapEvent{
            market_state_id : id<T0, T1, T2>(arg3),
            is_pt_to_sy     : v0.is_pt_to_sy,
            amount_in       : v0.amount_in,
            amount_out      : v0.amount_out,
            fee             : v0.fee,
            reserve_fee     : v0.reserve_fee,
            trader          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<MarketSwapEvent>(v1);
        (v0.sy_amount, arg0)
    }

    public(friend) fun swap_sy_for_pt<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Market<T0, T1, T2>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0, T1, T2>(arg2);
        let v0 = execute_trade_core<T0, T1, T2>(arg2, 2, 0x2::coin::value<T0>(&arg0), arg1, arg3, arg4);
        join_pool_sy<T0, T1, T2>(arg2, 0x2::coin::split<T0>(&mut arg0, v0.sy_amount, arg5));
        remove_pool_pt<T0, T1, T2>(arg2, v0.pt_amount);
        collect_reserve_fee_from_pool<T0, T1, T2>(arg2, v0.reserve_fee);
        check_market_caps<T0, T1, T2>(arg2, arg3);
        set_last_ln_implied_rate<T0, T1, T2>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v1 = MarketSwapEvent{
            market_state_id : id<T0, T1, T2>(arg2),
            is_pt_to_sy     : v0.is_pt_to_sy,
            amount_in       : v0.amount_in,
            amount_out      : v0.amount_out,
            fee             : v0.fee,
            reserve_fee     : v0.reserve_fee,
            trader          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketSwapEvent>(v1);
        (v0.pt_amount, v0.sy_amount, arg0)
    }

    public fun sy_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg0.coin_authority.sy_treasury)
    }

    public fun sy_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.sy_type
    }

    public fun total_accounted_sy<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u128 {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::accounted_sy(0x2::balance::value<T0>(&arg0.py_sy_balance), 0x2::balance::value<T0>(&arg0.pool_sy_balance), 0x2::balance::value<T0>(&arg0.reserve_fee_vault))
    }

    public fun total_pool_pt<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.total_pt
    }

    public fun total_pool_sy<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.pool_sy_balance)
    }

    public fun treasury<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : address {
        arg0.risk.treasury
    }

    fun treasury_interest_collectible(arg0: u128) : (u64, u128) {
        let v0 = arg0 / 18446744073709551616;
        assert!(v0 <= 18446744073709551615, 3630);
        let v1 = (v0 as u64);
        let v2 = (v1 as u128) * 18446744073709551616;
        assert!(v2 <= arg0, 3630);
        (v1, arg0 - v2)
    }

    fun update_interest_index<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u128, arg2: &0x2::clock::Clock) : (u128, u128, u128) {
        if (arg0.settlement.is_settled) {
            let v0 = if (arg0.global_interest_index == 0) {
                18446744073709551616
            } else {
                arg0.global_interest_index
            };
            return (v0, arg0.settlement.settled_py_index, 0)
        };
        arg0.last_interest_timestamp = 0x2::clock::timestamp_ms(arg2);
        let v1 = update_py_index<T0, T1, T2>(arg0, arg1, arg2);
        let (v2, v3, v4) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math::checkpoint(&mut arg0.interest_segment, v1, arg0.risk.interest_fee_rate);
        arg0.total_treasury_interest = arg0.total_treasury_interest + v3;
        let v5 = if (arg0.global_interest_index == 0) {
            18446744073709551616
        } else {
            arg0.global_interest_index
        };
        let v6 = v5 + v4;
        arg0.global_interest_index = v6;
        let v7 = MarketInterestCollectedEvent{
            market_state_id       : id<T0, T1, T2>(arg0),
            user_interest_raw     : v2,
            treasury_interest_raw : v3,
            py_index_raw          : v1,
        };
        0x2::event::emit<MarketInterestCollectedEvent>(v7);
        (v6, v1, v3)
    }

    public(friend) fun update_py_index<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u128, arg2: &0x2::clock::Clock) : u128 {
        let v0 = current_py_index<T0, T1, T2>(arg0, arg1);
        arg0.py_index_stored = v0;
        arg0.py_index_last_updated = 0x2::clock::timestamp_ms(arg2);
        v0
    }

    fun update_user_interest<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u128, arg3: &0x2::clock::Clock) : u128 {
        let (v0, v1, v2) = update_interest_index<T0, T1, T2>(arg0, arg2, arg3);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::index(arg1);
        if (v3 == 0) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_index(arg1, v0);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_py_index(arg1, v1);
            return v2
        };
        if (v3 == v0) {
            return v2
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_accrued(arg1, calc_user_accrued(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::accrued(arg1), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg1), v0, v3));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_index(arg1, v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::set_py_index(arg1, v1);
        v2
    }

    public fun yt_reward_gate_open<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : bool {
        let v0 = YtRewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists<YtRewardGateKey>(&arg0.id, v0)
    }

    public fun yt_reward_guard<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.rewards.yt_reward_guard
    }

    public fun yt_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.yt_supply
    }

    public fun yt_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg0.coin_authority.yt_treasury)
    }

    public fun yt_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.yt_type
    }

    // decompiled from Move bytecode v7
}

