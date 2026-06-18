module 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool {
    struct Pool<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expiry: u64,
        total_pt: u64,
        total_sy: 0x2::balance::Balance<T0>,
        reward_guard: u64,
        reserve_fee_vault: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        last_ln_implied_rate: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64,
        scalar_root: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64,
        treasury: address,
        protocol_fee_rate: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64,
        market_cap: u64,
        asset_market_cap: u64,
    }

    struct RewardPoolOperation {
        pool_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct BorrowPtReceipt {
        pool_id: 0x2::object::ID,
        pt_amount: u64,
    }

    struct BorrowSyReceipt {
        pool_id: 0x2::object::ID,
        sy_amount: u64,
    }

    struct RewardRequiredKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardRequired has store {
        distributor_id: 0x2::object::ID,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        expiry: u64,
    }

    struct RewardDistributorRequiredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_pt_to_sy: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        reserve_fee: u64,
        trader: address,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        pt_amount: u64,
        lp_amount: u64,
        locked_lp_amount: u64,
        sy_refund: u64,
        pt_refund: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        pt_amount: u64,
        lp_amount: u64,
        provider: address,
    }

    struct ImpliedRateUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        ln_implied_rate_raw: u128,
        pt_price_raw: u128,
        total_pt: u64,
        total_sy: u64,
        lp_supply: u64,
    }

    struct ReserveFeeCollectedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
        collector: address,
    }

    struct MarketCapUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        market_cap: u64,
        actor: address,
    }

    struct AssetMarketCapUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
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
        new_ln_implied_rate: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64,
        time_to_expiry_ms: u64,
    }

    public fun expiry<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun add_liquidity<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Pool<T0>, arg3: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(expiry<T0>(arg2) > v0, 1701);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::bind_pool_if_empty(arg3, pool_id<T0>(arg2));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_pool_match(arg3, pool_id<T0>(arg2));
        assert_lp_reward_mutation_allowed<T0>(arg2, arg3);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0 && arg1 > 0, 1500);
        let v2 = lp_supply<T0>(arg2) == 0;
        let (v3, v4, v5, v6, v7) = if (v2) {
            let v8 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::calc_lp_amount(0, 0, 0, v1, arg1);
            assert!(v8 > 1000, 1500);
            let v9 = v8 - 1000;
            join_sy<T0>(arg2, arg0);
            add_pt<T0>(arg2, arg1);
            mint_lp<T0>(arg2, v8);
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::add_lp(arg3, v9);
            check_market_caps<T0>(arg2, arg4);
            (v9, 1000, v1, arg1, 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg6))
        } else {
            let v10 = lp_supply<T0>(arg2);
            let v11 = total_sy<T0>(arg2);
            let v12 = total_pt<T0>(arg2);
            assert!(v11 > 0 && v12 > 0, 1500);
            let v13 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::calc_lp_amount(v10, v11, v12, v1, arg1);
            assert!(v13 > 0, 1500);
            let v14 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((v13 as u128), (v11 as u128), (v10 as u128)) as u64);
            let v15 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((v13 as u128), (v12 as u128), (v10 as u128)) as u64);
            assert!(v14 <= v1 && v15 <= arg1, 1704);
            join_sy<T0>(arg2, 0x2::coin::split<T0>(&mut arg0, v14, arg6));
            add_pt<T0>(arg2, v15);
            mint_lp<T0>(arg2, v13);
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::add_lp(arg3, v13);
            check_market_caps<T0>(arg2, arg4);
            (v13, 0, v14, v15, arg0)
        };
        let v16 = v7;
        if (v2) {
            let v17 = expiry<T0>(arg2) - v0;
            let v18 = bootstrap_ln_implied_rate(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::get_initial_ln_implied_rate(total_pt<T0>(arg2), 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::sy_to_asset_amount(total_sy<T0>(arg2), arg4), scalar_root<T0>(arg2), initial_anchor<T0>(arg2), v17));
            set_last_ln_implied_rate<T0>(arg2, v18, v17, arg4);
        };
        let v19 = AddLiquidityEvent{
            pool_id          : pool_id<T0>(arg2),
            position_id      : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg3),
            sy_amount        : v5,
            pt_amount        : v6,
            lp_amount        : v3,
            locked_lp_amount : v4,
            sy_refund        : 0x2::coin::value<T0>(&v16),
            pt_refund        : arg1 - v6,
        };
        0x2::event::emit<AddLiquidityEvent>(v19);
        (v3, v5, v6, v16)
    }

    public(friend) fun add_pt<T0: drop>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.total_pt = arg0.total_pt + arg1;
    }

    fun assert_lp_reward_mutation_allowed<T0: drop>(arg0: &Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition) {
        if (reward_distributor_required<T0>(arg0)) {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_reward_mutation_allowed(arg1, reward_distributor_id<T0>(arg0));
        };
    }

    fun assert_market_state_match<T0: drop, T1: drop, T2: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T0, T1, T2>, arg2: u64) {
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::market_id<T0>(arg0) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::id<T0, T1, T2>(arg1), 1715);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::expiry<T0>(arg0) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::expiry<T0, T1, T2>(arg1), 1715);
        assert!(arg2 == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::expiry<T0, T1, T2>(arg1), 1715);
    }

    fun assert_pool_mutation_allowed<T0: drop>(arg0: &Pool<T0>) {
        if (reward_distributor_required<T0>(arg0)) {
            assert!(reward_gate_open<T0>(arg0), 1710);
        };
    }

    public fun asset_exposure<T0: drop>(arg0: &Pool<T0>, arg1: u128) : u64 {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::sy_to_asset_amount(0x2::balance::value<T0>(&arg0.total_sy), arg1)
    }

    public fun asset_market_cap<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.asset_market_cap
    }

    public(friend) fun begin_reward_operation<T0: drop>(arg0: &mut Pool<T0>, arg1: 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardSettlement) : RewardPoolOperation {
        assert!(reward_distributor_required<T0>(arg0), 1710);
        assert!(!reward_gate_open<T0>(arg0), 1711);
        let v0 = pool_id<T0>(arg0);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_scope(&arg1, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::pool_scope());
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_profile_matches(&arg1, v0);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_subject(&arg1, v0);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_previous_exposure(&arg1, total_sy<T0>(arg0));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_guard(&arg1, reward_guard<T0>(arg0));
        let v1 = RewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<RewardGateKey, bool>(&mut arg0.id, v1, true);
        RewardPoolOperation{
            pool_id        : v0,
            distributor_id : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::consume_pool_settlement(arg1, reward_distributor_id<T0>(arg0), v0),
        }
    }

    fun bootstrap_ln_implied_rate(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::max(arg0, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(1844674407370955161))
    }

    public(friend) fun borrow_pt_for_yt_redeem<T0: drop>(arg0: &Pool<T0>, arg1: u64) : BorrowPtReceipt {
        assert_pool_mutation_allowed<T0>(arg0);
        assert!(arg1 > 0, 1500);
        assert!(arg0.total_pt > arg1, 1502);
        BorrowPtReceipt{
            pool_id   : pool_id<T0>(arg0),
            pt_amount : arg1,
        }
    }

    public(friend) fun borrow_sy_for_yt_mint<T0: drop>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, BorrowSyReceipt) {
        assert_pool_mutation_allowed<T0>(arg0);
        assert!(arg1 > 0, 1500);
        assert!(0x2::balance::value<T0>(&arg0.total_sy) > arg1, 1501);
        let v0 = split_sy<T0>(arg0, arg1, arg2);
        let v1 = BorrowSyReceipt{
            pool_id   : pool_id<T0>(arg0),
            sy_amount : arg1,
        };
        (v0, v1)
    }

    public(friend) fun burn_lp<T0: drop>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg0.lp_supply >= arg1, 1503);
        arg0.lp_supply = arg0.lp_supply - arg1;
    }

    fun check_asset_market_cap<T0: drop>(arg0: &Pool<T0>, arg1: u128) {
        if (arg0.asset_market_cap == 0) {
            return
        };
        assert!(asset_exposure<T0>(arg0, arg1) <= arg0.asset_market_cap, 1719);
    }

    fun check_market_cap<T0: drop>(arg0: &Pool<T0>) {
        if (arg0.market_cap == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.total_sy) <= arg0.market_cap, 1716);
    }

    fun check_market_caps<T0: drop>(arg0: &Pool<T0>, arg1: u128) {
        check_market_cap<T0>(arg0);
        check_asset_market_cap<T0>(arg0, arg1);
    }

    fun collect_reserve_fee_from_pool<T0: drop>(arg0: &mut Pool<T0>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.total_sy) >= arg1, 1501);
        0x2::balance::join<T0>(&mut arg0.reserve_fee_vault, 0x2::balance::split<T0>(&mut arg0.total_sy, arg1));
    }

    fun collect_reserve_fees<T0: drop>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_fee_vault);
        let v1 = if (v0 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.reserve_fee_vault, v0)
        };
        let v2 = ReserveFeeCollectedEvent{
            pool_id   : pool_id<T0>(arg0),
            treasury  : arg0.treasury,
            amount    : v0,
            collector : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ReserveFeeCollectedEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public fun collect_reserve_fees_by_acl<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"treasury.collect"));
        collect_reserve_fees<T0>(arg0, arg3)
    }

    public fun collect_reserve_fees_by_admin<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        collect_reserve_fees<T0>(arg0, arg3)
    }

    public fun create_pool_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T0, T1, T2>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg7: address, arg8: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        let v0 = create_pool_internal<T0, T1, T2>(arg0, arg1, arg11, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        let v1 = PoolCreatedEvent{
            pool_id     : 0x2::object::id<Pool<T0>>(&v0),
            py_state_id : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::id<T0>(arg0),
            expiry      : arg11,
        };
        0x2::event::emit<PoolCreatedEvent>(v1);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun create_pool_internal<T0: drop, T1: drop, T2: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T0, T1, T2>, arg2: u64, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg6: address, arg7: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert_market_state_match<T0, T1, T2>(arg0, arg1, arg2);
        Pool<T0>{
            id                   : 0x2::object::new(arg10),
            py_state_id          : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::id<T0>(arg0),
            market_id            : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::id<T0, T1, T2>(arg1),
            expiry               : arg2,
            total_pt             : 0,
            total_sy             : 0x2::balance::zero<T0>(),
            reward_guard         : 0,
            reserve_fee_vault    : 0x2::balance::zero<T0>(),
            lp_supply            : 0,
            last_ln_implied_rate : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero(),
            scalar_root          : arg3,
            initial_anchor       : arg4,
            ln_fee_rate_root     : arg5,
            treasury             : arg6,
            protocol_fee_rate    : arg7,
            market_cap           : arg8,
            asset_market_cap     : arg9,
        }
    }

    public(friend) fun end_reward_operation<T0: drop>(arg0: &mut Pool<T0>, arg1: RewardPoolOperation) {
        let RewardPoolOperation {
            pool_id        : v0,
            distributor_id : v1,
        } = arg1;
        assert!(v0 == pool_id<T0>(arg0), 1713);
        assert!(reward_distributor_id<T0>(arg0) == v1, 1714);
        assert!(reward_gate_open<T0>(arg0), 1712);
        let v2 = RewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<RewardGateKey, bool>(&mut arg0.id, v2), 1712);
        arg0.reward_guard = arg0.reward_guard + 1;
    }

    fun execute_trade_core<T0: drop>(arg0: &Pool<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) : TradeResult {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(expiry<T0>(arg0) > v0, 1701);
        assert!(arg2 > 0, 1500);
        let v1 = expiry<T0>(arg0) - v0;
        if (arg1 == 0) {
            let (v2, v3, v4) = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::quote_exact_pt_for_sy_indexed(total_pt<T0>(arg0), total_sy<T0>(arg0), arg4, last_ln_implied_rate<T0>(arg0), scalar_root<T0>(arg0), initial_anchor<T0>(arg0), ln_fee_rate_root<T0>(arg0), arg2, v1);
            assert!(v2 >= arg3, 1704);
            assert!(v2 > 0, 1703);
            return TradeResult{
                is_pt_to_sy         : true,
                amount_in           : arg2,
                amount_out          : v2,
                sy_amount           : v2,
                pt_amount           : arg2,
                fee                 : v3,
                reserve_fee         : reserve_fee_from_fee<T0>(arg0, v3),
                new_ln_implied_rate : v4,
                time_to_expiry_ms   : v1,
            }
        };
        if (arg1 == 1) {
            let (v5, v6, v7) = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::quote_pt_for_exact_sy_indexed(total_pt<T0>(arg0), total_sy<T0>(arg0), arg4, last_ln_implied_rate<T0>(arg0), scalar_root<T0>(arg0), initial_anchor<T0>(arg0), ln_fee_rate_root<T0>(arg0), arg2, v1);
            assert!(v5 > 0, 1703);
            assert!(v5 <= arg3, 1704);
            return TradeResult{
                is_pt_to_sy         : true,
                amount_in           : v5,
                amount_out          : arg2,
                sy_amount           : arg2,
                pt_amount           : v5,
                fee                 : v6,
                reserve_fee         : reserve_fee_from_fee<T0>(arg0, v6),
                new_ln_implied_rate : v7,
                time_to_expiry_ms   : v1,
            }
        };
        if (arg1 == 2) {
            let (v8, v9, v10, v11) = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::quote_exact_sy_for_pt_indexed(total_pt<T0>(arg0), total_sy<T0>(arg0), arg4, last_ln_implied_rate<T0>(arg0), scalar_root<T0>(arg0), initial_anchor<T0>(arg0), ln_fee_rate_root<T0>(arg0), arg2, v1);
            assert!(v8 >= arg3, 1704);
            assert!(v8 > 0, 1703);
            return TradeResult{
                is_pt_to_sy         : false,
                amount_in           : v9,
                amount_out          : v8,
                sy_amount           : v9,
                pt_amount           : v8,
                fee                 : v10,
                reserve_fee         : reserve_fee_from_fee<T0>(arg0, v10),
                new_ln_implied_rate : v11,
                time_to_expiry_ms   : v1,
            }
        };
        assert!(arg1 == 3, 1709);
        let (v12, v13, v14) = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::quote_sy_for_exact_pt_indexed(total_pt<T0>(arg0), total_sy<T0>(arg0), arg4, last_ln_implied_rate<T0>(arg0), scalar_root<T0>(arg0), initial_anchor<T0>(arg0), ln_fee_rate_root<T0>(arg0), arg2, v1);
        assert!(v12 > 0, 1703);
        assert!(v12 <= arg3, 1704);
        TradeResult{
            is_pt_to_sy         : false,
            amount_in           : v12,
            amount_out          : arg2,
            sy_amount           : v12,
            pt_amount           : arg2,
            fee                 : v13,
            reserve_fee         : reserve_fee_from_fee<T0>(arg0, v13),
            new_ln_implied_rate : v14,
            time_to_expiry_ms   : v1,
        }
    }

    public fun initial_anchor<T0: drop>(arg0: &Pool<T0>) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        arg0.initial_anchor
    }

    public fun initial_anchor_positive<T0: drop>(arg0: &Pool<T0>) : bool {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::is_positive(arg0.initial_anchor)
    }

    public fun initial_anchor_value<T0: drop>(arg0: &Pool<T0>) : u128 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(arg0.initial_anchor)
    }

    public(friend) fun join_sy<T0: drop>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.total_sy, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun last_ln_implied_rate<T0: drop>(arg0: &Pool<T0>) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        arg0.last_ln_implied_rate
    }

    public fun last_ln_implied_rate_raw<T0: drop>(arg0: &Pool<T0>) : u128 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0.last_ln_implied_rate)
    }

    public fun ln_fee_rate_root<T0: drop>(arg0: &Pool<T0>) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        arg0.ln_fee_rate_root
    }

    public(friend) fun ln_fee_rate_root_raw<T0: drop>(arg0: &Pool<T0>) : u128 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0.ln_fee_rate_root)
    }

    public fun lp_supply<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.lp_supply
    }

    public fun market_cap<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.market_cap
    }

    public fun market_id<T0: drop>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun mint_lp<T0: drop>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.lp_supply = arg0.lp_supply + arg1;
    }

    public fun pool_id<T0: drop>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::id<Pool<T0>>(arg0)
    }

    public fun protocol_fee_rate<T0: drop>(arg0: &Pool<T0>) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        arg0.protocol_fee_rate
    }

    public fun protocol_fee_rate_raw<T0: drop>(arg0: &Pool<T0>) : u128 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0.protocol_fee_rate)
    }

    public fun py_state_id<T0: drop>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.py_state_id
    }

    public(friend) fun remove_liquidity<T0: drop>(arg0: u64, arg1: &mut Pool<T0>, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert_pool_mutation_allowed<T0>(arg1);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_pool_match(arg2, pool_id<T0>(arg1));
        assert_lp_reward_mutation_allowed<T0>(arg1, arg2);
        assert!(arg0 > 0, 1500);
        let v0 = lp_supply<T0>(arg1);
        let v1 = (((arg0 as u128) * (total_sy<T0>(arg1) as u128) / (v0 as u128)) as u64);
        let v2 = (((arg0 as u128) * (total_pt<T0>(arg1) as u128) / (v0 as u128)) as u64);
        burn_lp<T0>(arg1, arg0);
        remove_pt<T0>(arg1, v2);
        let v3 = split_sy<T0>(arg1, v1, arg4);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::sub_lp(arg2, arg0);
        let v4 = RemoveLiquidityEvent{
            pool_id     : pool_id<T0>(arg1),
            position_id : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg2),
            sy_amount   : v1,
            pt_amount   : v2,
            lp_amount   : arg0,
            provider    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RemoveLiquidityEvent>(v4);
        (v3, v2)
    }

    public(friend) fun remove_pt<T0: drop>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg0.total_pt >= arg1, 1502);
        arg0.total_pt = arg0.total_pt - arg1;
    }

    public(friend) fun repay_borrowed_pt_for_yt_redeem<T0: drop>(arg0: &Pool<T0>, arg1: BorrowPtReceipt, arg2: u64) {
        let BorrowPtReceipt {
            pool_id   : v0,
            pt_amount : v1,
        } = arg1;
        assert!(v0 == pool_id<T0>(arg0), 1717);
        assert!(v1 == arg2, 1502);
    }

    public(friend) fun repay_borrowed_sy_for_yt_mint<T0: drop>(arg0: &mut Pool<T0>, arg1: BorrowSyReceipt, arg2: 0x2::coin::Coin<T0>, arg3: u128) {
        assert_pool_mutation_allowed<T0>(arg0);
        let BorrowSyReceipt {
            pool_id   : v0,
            sy_amount : v1,
        } = arg1;
        assert!(v0 == pool_id<T0>(arg0), 1718);
        assert!(0x2::coin::value<T0>(&arg2) == v1, 1501);
        join_sy<T0>(arg0, arg2);
        check_market_caps<T0>(arg0, arg3);
    }

    public(friend) fun require_reward_distributor<T0: drop>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID) {
        assert!(!reward_gate_open<T0>(arg0), 1711);
        arg0.reward_guard = arg0.reward_guard + 1;
        if (!reward_distributor_required<T0>(arg0)) {
            let v0 = RewardRequiredKey{dummy_field: false};
            let v1 = RewardRequired{distributor_id: arg1};
            0x2::dynamic_field::add<RewardRequiredKey, RewardRequired>(&mut arg0.id, v0, v1);
        } else {
            let v2 = RewardRequiredKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<RewardRequiredKey, RewardRequired>(&mut arg0.id, v2).distributor_id = arg1;
        };
        let v3 = RewardDistributorRequiredEvent{
            pool_id        : pool_id<T0>(arg0),
            distributor_id : arg1,
        };
        0x2::event::emit<RewardDistributorRequiredEvent>(v3);
    }

    public fun require_reward_distributor_by_admin<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        require_reward_distributor<T0>(arg0, arg2);
    }

    public fun reserve_fee_amount<T0: drop>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_fee_vault)
    }

    fun reserve_fee_from_fee<T0: drop>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0.protocol_fee_rate);
        if (arg1 == 0 || v0 == 0) {
            return 0
        };
        let v1 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg1 as u128), v0, 18446744073709551616) as u64);
        if (v1 > arg1) {
            arg1
        } else {
            v1
        }
    }

    public fun reward_distributor_id<T0: drop>(arg0: &Pool<T0>) : 0x2::object::ID {
        assert!(reward_distributor_required<T0>(arg0), 1710);
        let v0 = RewardRequiredKey{dummy_field: false};
        0x2::dynamic_field::borrow<RewardRequiredKey, RewardRequired>(&arg0.id, v0).distributor_id
    }

    public fun reward_distributor_required<T0: drop>(arg0: &Pool<T0>) : bool {
        let v0 = RewardRequiredKey{dummy_field: false};
        0x2::dynamic_field::exists<RewardRequiredKey>(&arg0.id, v0)
    }

    public fun reward_gate_open<T0: drop>(arg0: &Pool<T0>) : bool {
        let v0 = RewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists<RewardGateKey>(&arg0.id, v0)
    }

    public fun reward_guard<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.reward_guard
    }

    public fun scalar_root<T0: drop>(arg0: &Pool<T0>) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        arg0.scalar_root
    }

    public fun scalar_root_positive<T0: drop>(arg0: &Pool<T0>) : bool {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::is_positive(arg0.scalar_root)
    }

    public fun scalar_root_value<T0: drop>(arg0: &Pool<T0>) : u128 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(arg0.scalar_root)
    }

    public(friend) fun set_asset_market_cap<T0: drop>(arg0: &mut Pool<T0>, arg1: u64, arg2: u128, arg3: address) {
        arg0.asset_market_cap = arg1;
        check_asset_market_cap<T0>(arg0, arg2);
        let v0 = AssetMarketCapUpdatedEvent{
            pool_id          : pool_id<T0>(arg0),
            asset_market_cap : arg1,
            sy_index_raw     : arg2,
            actor            : arg3,
        };
        0x2::event::emit<AssetMarketCapUpdatedEvent>(v0);
    }

    public fun set_asset_market_cap_by_acl<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: u64, arg4: u128, arg5: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"pool.set_asset_market_cap"));
        set_asset_market_cap<T0>(arg0, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    public fun set_asset_market_cap_by_admin<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: u64, arg3: u128, arg4: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg5: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        set_asset_market_cap<T0>(arg0, arg2, arg3, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun set_last_ln_implied_rate<T0: drop>(arg0: &mut Pool<T0>, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg2: u64, arg3: u128) {
        arg0.last_ln_implied_rate = arg1;
        let v0 = 0x2::balance::value<T0>(&arg0.total_sy);
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
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math::spot_pt_price_in_sy_indexed(arg0.total_pt, v0, arg3, arg1, arg0.scalar_root, arg0.initial_anchor, arg2)
        };
        let v3 = ImpliedRateUpdatedEvent{
            pool_id             : pool_id<T0>(arg0),
            ln_implied_rate_raw : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg1),
            pt_price_raw        : v2,
            total_pt            : arg0.total_pt,
            total_sy            : v0,
            lp_supply           : arg0.lp_supply,
        };
        0x2::event::emit<ImpliedRateUpdatedEvent>(v3);
    }

    public(friend) fun set_market_cap<T0: drop>(arg0: &mut Pool<T0>, arg1: u64, arg2: address) {
        arg0.market_cap = arg1;
        check_market_cap<T0>(arg0);
        let v0 = MarketCapUpdatedEvent{
            pool_id    : pool_id<T0>(arg0),
            market_cap : arg1,
            actor      : arg2,
        };
        0x2::event::emit<MarketCapUpdatedEvent>(v0);
    }

    public fun set_market_cap_by_acl<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"pool.set_market_cap"));
        set_market_cap<T0>(arg0, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun set_market_cap_by_admin<T0: drop>(arg0: &mut Pool<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: u64, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg4: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_pool_active(arg1, pool_id<T0>(arg0));
        set_market_cap<T0>(arg0, arg2, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun split_sy<T0: drop>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.total_sy) >= arg1, 1501);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_sy, arg1), arg2)
    }

    public(friend) fun swap_pt_for_exact_sy<T0: drop>(arg0: u64, arg1: u64, arg2: &mut Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0>(arg2);
        let v0 = execute_trade_core<T0>(arg2, 1, arg0, arg1, arg3, arg4);
        add_pt<T0>(arg2, v0.pt_amount);
        let v1 = split_sy<T0>(arg2, v0.sy_amount, arg5);
        collect_reserve_fee_from_pool<T0>(arg2, v0.reserve_fee);
        set_last_ln_implied_rate<T0>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v2 = SwapEvent{
            pool_id     : pool_id<T0>(arg2),
            is_pt_to_sy : v0.is_pt_to_sy,
            amount_in   : v0.amount_in,
            amount_out  : v0.amount_out,
            fee         : v0.fee,
            reserve_fee : v0.reserve_fee,
            trader      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SwapEvent>(v2);
        (v0.pt_amount, v1)
    }

    public(friend) fun swap_pt_for_sy<T0: drop>(arg0: u64, arg1: u64, arg2: &mut Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool_mutation_allowed<T0>(arg2);
        let v0 = execute_trade_core<T0>(arg2, 0, arg0, arg1, arg3, arg4);
        add_pt<T0>(arg2, v0.pt_amount);
        let v1 = split_sy<T0>(arg2, v0.sy_amount, arg5);
        collect_reserve_fee_from_pool<T0>(arg2, v0.reserve_fee);
        set_last_ln_implied_rate<T0>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v2 = SwapEvent{
            pool_id     : pool_id<T0>(arg2),
            is_pt_to_sy : v0.is_pt_to_sy,
            amount_in   : v0.amount_in,
            amount_out  : v0.amount_out,
            fee         : v0.fee,
            reserve_fee : v0.reserve_fee,
            trader      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SwapEvent>(v2);
        v1
    }

    public(friend) fun swap_sy_for_exact_pt<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut Pool<T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0>(arg3);
        let v0 = execute_trade_core<T0>(arg3, 3, arg1, arg2, arg4, arg5);
        assert!(0x2::coin::value<T0>(&arg0) >= v0.sy_amount, 1704);
        join_sy<T0>(arg3, 0x2::coin::split<T0>(&mut arg0, v0.sy_amount, arg6));
        remove_pt<T0>(arg3, v0.pt_amount);
        collect_reserve_fee_from_pool<T0>(arg3, v0.reserve_fee);
        check_market_caps<T0>(arg3, arg4);
        set_last_ln_implied_rate<T0>(arg3, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg4);
        let v1 = SwapEvent{
            pool_id     : pool_id<T0>(arg3),
            is_pt_to_sy : v0.is_pt_to_sy,
            amount_in   : v0.amount_in,
            amount_out  : v0.amount_out,
            fee         : v0.fee,
            reserve_fee : v0.reserve_fee,
            trader      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapEvent>(v1);
        (v0.sy_amount, arg0)
    }

    public(friend) fun swap_sy_for_pt<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        assert_pool_mutation_allowed<T0>(arg2);
        let v0 = execute_trade_core<T0>(arg2, 2, 0x2::coin::value<T0>(&arg0), arg1, arg3, arg4);
        join_sy<T0>(arg2, 0x2::coin::split<T0>(&mut arg0, v0.sy_amount, arg5));
        remove_pt<T0>(arg2, v0.pt_amount);
        collect_reserve_fee_from_pool<T0>(arg2, v0.reserve_fee);
        check_market_caps<T0>(arg2, arg3);
        set_last_ln_implied_rate<T0>(arg2, v0.new_ln_implied_rate, v0.time_to_expiry_ms, arg3);
        let v1 = SwapEvent{
            pool_id     : pool_id<T0>(arg2),
            is_pt_to_sy : v0.is_pt_to_sy,
            amount_in   : v0.amount_in,
            amount_out  : v0.amount_out,
            fee         : v0.fee,
            reserve_fee : v0.reserve_fee,
            trader      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SwapEvent>(v1);
        (v0.pt_amount, v0.sy_amount, arg0)
    }

    public fun total_pt<T0: drop>(arg0: &Pool<T0>) : u64 {
        arg0.total_pt
    }

    public fun total_sy<T0: drop>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_sy)
    }

    public fun treasury<T0: drop>(arg0: &Pool<T0>) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

