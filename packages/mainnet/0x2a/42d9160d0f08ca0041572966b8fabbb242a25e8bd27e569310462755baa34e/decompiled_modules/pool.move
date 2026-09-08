module 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool {
    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        swap_for_y: bool,
        active_bin_id: u32,
        bins_crossed: u32,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        trace_bin_ids: vector<u32>,
        trace_amounts_in: vector<u64>,
        trace_amounts_out: vector<u64>,
        trace_fees: vector<u64>,
        trace_protocol_fees: vector<u64>,
        trace_reserves_x: vector<u64>,
        trace_reserves_y: vector<u64>,
    }

    struct LiquidityAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        shares_minted: vector<u128>,
        generations: vector<u64>,
    }

    struct LiquidityRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        shares_burned: vector<u128>,
        generations: vector<u64>,
    }

    struct BinGenerationRetiredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        bin_id: u32,
        generation: u64,
        total_shares: u128,
    }

    struct ProtocolFeesCollectedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct OracleBinIdRefreshedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        oracle_bin_id: u32,
        oldest_price_ms: u64,
    }

    struct LazerFeedIdsSetEvent has copy, drop {
        pool_id: 0x2::object::ID,
        feed_id_x: u32,
        feed_id_y: u32,
    }

    struct PoolPausedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        by_guardian: bool,
    }

    struct PoolUnpausedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct FeeParamsUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        fee_params: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters,
    }

    struct PoolPermissionsUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        permissions: PoolPermissions,
    }

    struct PartnerFeeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        partner_id: 0x2::object::ID,
        swap_for_y: bool,
        partner_fee: u64,
    }

    struct PartnerSwapDowngradedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        partner_id: 0x2::object::ID,
        sender: address,
        swap_for_y: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct PositionCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct PositionDestroyedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct FlashSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        swap_for_y: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        active_bin_id: u32,
    }

    struct MinLiquidityUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        min_liquidity_x: u64,
        min_liquidity_y: u64,
    }

    struct PoolMigratedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct PoolPermissions has copy, drop, store {
        flags: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        bin_step: u16,
        active_bin_id: u32,
        bins: 0x2::table::Table<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>,
        next_bin_generation: u64,
        fee_params: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters,
        vol_state: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::VolatilityState,
        custody: 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>,
        protocol_balance_x: 0x2::balance::Balance<T0>,
        protocol_balance_y: 0x2::balance::Balance<T1>,
        paused: bool,
        permissions: PoolPermissions,
        lending: 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::PoolLending,
        bitmap: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::BinBitmap,
        oracle_bin_id: u32,
        oracle_last_updated: u64,
        lazer_feed_id_x: u32,
        lazer_feed_id_y: u32,
        flash_active: bool,
        min_liquidity_x: u64,
        min_liquidity_y: u64,
        extra: 0x2::bag::Bag,
    }

    struct SwapEffects has copy, drop {
        total_out: u64,
        total_protocol_fee: u64,
        total_fee: u64,
        consumed: u64,
        bins_crossed: u32,
        trace_bin_ids: vector<u32>,
        trace_amounts_in: vector<u64>,
        trace_amounts_out: vector<u64>,
        trace_fees: vector<u64>,
        trace_protocol_fees: vector<u64>,
        trace_reserves_x: vector<u64>,
        trace_reserves_y: vector<u64>,
    }

    struct LendingSwapPlan<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        limit: u64,
        amount_in: u64,
        max_consumed: 0x1::option::Option<u64>,
        limit_bin_id: 0x1::option::Option<u32>,
        output_need: u64,
    }

    struct LendingSwapReady<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        limit: u64,
        amount_in: u64,
        max_consumed: 0x1::option::Option<u64>,
        limit_bin_id: 0x1::option::Option<u32>,
    }

    struct RemovalAccountingPlan<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        need_x: u64,
        need_y: u64,
    }

    struct RemovalAccountingReady<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        need_x: u64,
        need_y: u64,
    }

    struct BinInput has copy, drop, store {
        bin_id: u32,
        amount: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        swap_for_y: bool,
        consumed: u64,
        total_protocol_fee: u64,
        total_fee: u64,
        total_out: u64,
        bin_inputs: vector<BinInput>,
    }

    struct SwapQuote has copy, drop, store {
        consumed_in: u64,
        refund_in: u64,
        amount_out: u64,
        total_fee: u64,
        protocol_fee: u64,
        bins_crossed: u32,
        final_active_bin_id: u32,
    }

    public fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (arg4) {
            assert_not_sui<T1>();
        } else {
            assert_not_sui<T0>();
        };
        let (v0, v1, v2) = open_swap<T0, T1>(arg0, arg1, &arg2, &arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = recall_output<T0, T1>(arg0, arg1, v1, v0, arg10, arg11);
        finish_swap<T0, T1>(arg0, arg2, arg3, v3, v2, v1, 0x2::tx_context::sender(arg11))
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: vector<u128>, arg11: u32, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (vector<u128>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        add_liquidity_validate<T0, T1>(arg0, arg1, &arg3, &arg4, &arg5, arg11, arg12);
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v1 = 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(arg1);
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending) && !perms_bypass_venue(&arg0.permissions)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::sync<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg2, v0, arg13);
        };
        add_liquidity_core<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v0, v1, arg14)
    }

    public fun bin_id_offset() : u32 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::bin_id_offset()
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u128>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_not_sui<T0>();
        assert_not_sui<T1>();
        check_remove_deadline(arg8, arg7);
        let (v0, v1) = prepare_remove<T0, T1>(arg0, arg1, arg2, &arg3, &arg4, arg8);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v3 = new_remove_plan<T0, T1>(arg0, v0, v1);
        let (v4, v5) = remove_needs<T0, T1>(&v3);
        if (should_jit_recall<T0, T1>(arg0)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_x<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg2, v2, v4, arg8, arg9);
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_y<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg2, v2, v5, arg8, arg9);
        };
        let v6 = finish_remove_recall<T0, T1>(arg0, arg1, &arg3, &arg4, v3);
        finish_remove<T0, T1>(arg0, arg1, v2, arg3, &arg4, v6, arg5, arg6, arg9)
    }

    public fun active_bin_id<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.active_bin_id
    }

    fun add_liquidity_core<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<u128>, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: &mut 0x2::tx_context::TxContext) : (vector<u128>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::length<u32>(&arg2);
        let v1 = 0x1::vector::length<u128>(&arg9) > 0;
        assert!(!v1 || 0x1::vector::length<u128>(&arg9) == v0, 405);
        maybe_distribute_lp_yield<T0, T1>(arg0);
        let v2 = arg0.active_bin_id;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            v3 = v3 + *0x1::vector::borrow<u64>(&arg3, v5);
            v4 = v4 + *0x1::vector::borrow<u64>(&arg4, v5);
            v5 = v5 + 1;
        };
        assert!(v3 > 0 || v4 > 0, 401);
        assert!(v3 >= arg7, 402);
        assert!(v4 >= arg8, 402);
        assert!(0x2::coin::value<T0>(&arg5) >= v3, 406);
        assert!(0x2::coin::value<T1>(&arg6) >= v4, 406);
        let v6 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v3, arg12));
        let v7 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v4, arg12));
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = 0;
        while (v12 < v0) {
            let v13 = *0x1::vector::borrow<u32>(&arg2, v12);
            let v14 = *0x1::vector::borrow<u64>(&arg3, v12);
            let v15 = v14;
            let v16 = *0x1::vector::borrow<u64>(&arg4, v12);
            let v17 = v16;
            assert!(v14 > 0 || v16 > 0, 401);
            assert_bin_price(arg0.bin_step, v13);
            if (v13 > v2) {
                assert!(v16 == 0, 413);
            } else if (v13 < v2) {
                assert!(v14 == 0, 413);
            };
            if (0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v13)) {
                credit_bin_yield<T0, T1>(arg0, v13);
                let v18 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v13);
                let v19 = if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v18) > 0) {
                    if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v18) == 0) {
                        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v18) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v19) {
                    reset_dead_bin<T0, T1>(arg0, arg10, v13);
                };
            };
            if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v13)) {
                assert_new_bin_floor(v2, v13, v14, v16, arg0.min_liquidity_x, arg0.min_liquidity_y);
                let v20 = alloc_bin_generation<T0, T1>(arg0);
                0x2::table::add<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v13, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::new_at<T0, T1>(v13, arg0.bin_step, v20));
                0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::set(&mut arg0.bitmap, v13);
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::init_yield_snapshot<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v13), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_x(&arg0.lending), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_y(&arg0.lending));
            };
            credit_bin_yield<T0, T1>(arg0, v13);
            if (v13 == v2 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v13)) > 0) {
                let v21 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v13);
                let v22 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v21);
                let v23 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v21);
                if (v22 == 0) {
                    v15 = 0;
                } else if (v23 == 0) {
                    v17 = 0;
                } else {
                    let v24 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((v14 as u128), (v23 as u128), (v22 as u128));
                    if (v24 <= (v16 as u128)) {
                        v17 = (v24 as u64);
                    } else {
                        let v25 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((v16 as u128), (v22 as u128), (v23 as u128)) as u64);
                        v15 = v25;
                        v17 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((v25 as u128), (v23 as u128), (v22 as u128)) as u64);
                    };
                };
            };
            assert!(v15 > 0 || v17 > 0, 401);
            seal_bin_yield<T0, T1>(arg0, v13, v15, v17);
            let (v26, v27, v28) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::add_liquidity<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v13), &mut arg0.custody, 0x2::balance::split<T0>(&mut v6, v15), 0x2::balance::split<T1>(&mut v7, v17));
            let v29 = v28;
            let v30 = v27;
            0x2::balance::join<T0>(&mut v6, v30);
            0x2::balance::join<T1>(&mut v7, v29);
            if (v1) {
                assert!(v26 >= *0x1::vector::borrow<u128>(&arg9, v12), 436);
            };
            let v31 = bin_generation<T0, T1>(arg0, v13);
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::add_shares_for_generation(arg1, v13, v26, v31);
            assert_bin_floor<T0, T1>(arg0, arg1, v13);
            0x1::vector::push_back<u128>(&mut v8, v26);
            0x1::vector::push_back<u64>(&mut v9, v15 - 0x2::balance::value<T0>(&v30));
            0x1::vector::push_back<u64>(&mut v10, v17 - 0x2::balance::value<T1>(&v29));
            0x1::vector::push_back<u64>(&mut v11, v31);
            v12 = v12 + 1;
        };
        assert!(v3 - 0x2::balance::value<T0>(&v6) >= arg7, 402);
        assert!(v4 - 0x2::balance::value<T1>(&v7) >= arg8, 402);
        0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v6, arg12));
        0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v7, arg12));
        let v32 = LiquidityAddedEvent{
            pool_id       : arg10,
            position_id   : arg11,
            bin_ids       : arg2,
            amounts_x     : v9,
            amounts_y     : v10,
            shares_minted : v8,
            generations   : v11,
        };
        0x2::event::emit<LiquidityAddedEvent>(v32);
        assert_reserve_solvency<T0, T1>(arg0);
        (v8, arg5, arg6)
    }

    public fun add_liquidity_no_lending<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<u128>, arg10: u32, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) : (vector<u128>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        add_liquidity_validate<T0, T1>(arg0, arg1, &arg2, &arg3, &arg4, arg10, arg11);
        assert!(!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending), 425);
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v1 = 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(arg1);
        add_liquidity_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, v1, arg12)
    }

    fun add_liquidity_validate<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u32, arg6: u32) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
        assert_add<T0, T1>(arg0);
        assert_position_pool<T0, T1>(arg0, arg1);
        let v0 = arg0.active_bin_id;
        let v1 = if (v0 > arg5) {
            v0 - arg5
        } else {
            arg5 - v0
        };
        assert!(v1 <= arg6, 420);
        let v2 = 0x1::vector::length<u32>(arg2);
        assert!(v2 > 0, 404);
        assert!(v2 == 0x1::vector::length<u64>(arg3) && v2 == 0x1::vector::length<u64>(arg4), 405);
        assert_ascending_bins(arg2);
    }

    entry fun admin_set_lazer_feed_ids<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32) {
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        assert_valid_lazer_feed_ids(arg2, arg3);
        arg1.lazer_feed_id_x = arg2;
        arg1.lazer_feed_id_y = arg3;
        arg1.oracle_bin_id = 0;
        emit_lazer_feed_ids_set(0x2::object::id<Pool<T0, T1>>(arg1), arg1.lazer_feed_id_x, arg1.lazer_feed_id_y);
    }

    entry fun admin_set_min_liquidity<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64) {
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        assert!(arg2 > 0 && arg3 > 0, 438);
        arg1.min_liquidity_x = arg2;
        arg1.min_liquidity_y = arg3;
        let v0 = MinLiquidityUpdatedEvent{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg1),
            min_liquidity_x : arg2,
            min_liquidity_y : arg3,
        };
        0x2::event::emit<MinLiquidityUpdatedEvent>(v0);
    }

    fun advance_active<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: bool, arg3: bool, arg4: u32) : bool {
        if (0x1::option::is_none<u32>(&arg1)) {
            return false
        };
        let v0 = *0x1::option::borrow<u32>(&arg1);
        if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v0, arg0.bin_step)) {
            if (arg2) {
                arg0.active_bin_id = arg4;
            } else if (arg3) {
                abort 412
            };
            return false
        };
        arg0.active_bin_id = v0;
        true
    }

    fun alloc_bin_generation<T0, T1>(arg0: &mut Pool<T0, T1>) : u64 {
        let v0 = arg0.next_bin_generation;
        assert!(v0 < 18446744073709551615, 430);
        arg0.next_bin_generation = v0 + 1;
        v0
    }

    fun apply_oracle_update<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u64) : bool {
        if ((arg0.oracle_bin_id > 0 || arg0.oracle_last_updated > 0) && arg2 <= arg0.oracle_last_updated) {
            return false
        };
        arg0.oracle_bin_id = arg1;
        arg0.oracle_last_updated = arg2;
        true
    }

    fun assert_add<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.paused, 400);
        assert!(!perms_disable_add(&arg0.permissions), 418);
    }

    fun assert_ascending_bins(arg0: &vector<u32>) {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 <= 256, 435);
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u32>(arg0, v1 - 1);
            let v3 = *0x1::vector::borrow<u32>(arg0, v1);
            assert!(v2 != v3, 433);
            assert!(v2 < v3, 439);
            v1 = v1 + 1;
        };
    }

    fun assert_bin_floor<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: u32) {
        if (arg0.min_liquidity_x == 0 && arg0.min_liquidity_y == 0) {
            return
        };
        let v0 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(arg1, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg2);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v1);
        if (v2 == 0) {
            return
        };
        let v3 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v1) as u128), v0, v2) as u64);
        let v4 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v1) as u128), v0, v2) as u64);
        if (arg2 == arg0.active_bin_id) {
            assert!(v3 > 0 && v3 >= arg0.min_liquidity_x || v4 > 0 && v4 >= arg0.min_liquidity_y, 426);
        } else {
            assert!(v3 == 0 || v3 >= arg0.min_liquidity_x, 426);
            assert!(v4 == 0 || v4 >= arg0.min_liquidity_y, 426);
        };
    }

    fun assert_bin_price(arg0: u16, arg1: u32) {
        assert!(arg1 > 0 && arg1 <= 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::max_bin_id(), 408);
        assert!(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(arg1, arg0), 408);
    }

    public(friend) fun assert_collect_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!perms_disable_collect(&arg0.permissions), 418);
    }

    fun assert_idle_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg2 || !0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending), 425);
        assert!(arg1 >= arg2, 415);
    }

    fun assert_known_flags(arg0: u64) {
        assert!(arg0 & (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64() ^ 511) == 0, 437);
    }

    fun assert_new_bin_floor(arg0: u32, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        if (arg1 > arg0) {
            assert!(arg2 >= arg4, 426);
        } else if (arg1 < arg0) {
            assert!(arg3 >= arg5, 426);
        } else {
            assert!(arg2 == 0 || arg2 >= arg4, 426);
            assert!(arg3 == 0 || arg3 >= arg5, 426);
        };
    }

    fun assert_no_lending<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending), 425);
    }

    fun assert_no_lending_exit<T0, T1>(arg0: &Pool<T0, T1>) {
        assert_no_lending<T0, T1>(arg0);
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::rounding_tolerance();
        assert!(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(&arg0.custody) <= v0 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(&arg0.custody) <= v0, 425);
    }

    public(friend) fun assert_not_flash_active<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.flash_active, 414);
    }

    public(friend) fun assert_not_pool_asset<T0, T1, T2>() {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(v0 != 0x1::type_name::with_defining_ids<T0>(), 449);
        assert!(v0 != 0x1::type_name::with_defining_ids<T1>(), 449);
    }

    public(friend) fun assert_not_sui<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 416);
    }

    fun assert_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: u64) {
        if (arg1) {
            assert_idle_output<T0, T1>(arg0, idle_y<T0, T1>(arg0), arg2);
        } else {
            assert_idle_output<T0, T1>(arg0, idle_x<T0, T1>(arg0), arg2);
        };
    }

    public fun assert_pool_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert_version<T0, T1>(arg0);
    }

    fun assert_position_pool<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position) {
        assert!(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::pool_id(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
    }

    fun assert_refresh<T0, T1>(arg0: &Pool<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
    }

    fun assert_remove<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!perms_disable_remove(&arg0.permissions), 418);
    }

    public fun assert_reserve_solvency<T0, T1>(arg0: &Pool<T0, T1>) {
        let (v0, v1) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_entitlement(&arg0.lending, total_reserve_x<T0, T1>(arg0), total_reserve_y<T0, T1>(arg0));
        assert!(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::backing_u128_x<T0, T1>(&arg0.custody) >= v0 + (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::pending_protocol_yield_x(&arg0.lending) as u128), 428);
        assert!(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::backing_u128_y<T0, T1>(&arg0.custody) >= v1 + (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::pending_protocol_yield_y(&arg0.lending) as u128), 428);
    }

    fun assert_swap<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.paused, 400);
        assert!(!perms_disable_swap(&arg0.permissions), 418);
    }

    fun assert_swap_pre<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
        assert_swap<T0, T1>(arg0);
        assert!(arg1 > 0, 401);
    }

    public(friend) fun assert_valid_lazer_feed_ids(arg0: u32, arg1: u32) {
        assert!(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::is_valid_feed_id(arg0) == 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::is_valid_feed_id(arg1), 421);
    }

    public(friend) fun assert_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.version == 1, 409);
    }

    public fun balance_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        idle_x<T0, T1>(arg0)
    }

    public fun balance_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        idle_y<T0, T1>(arg0)
    }

    public fun base_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_base_fee(&arg0.fee_params)
    }

    fun bin_generation<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::generation<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1))
    }

    public fun bin_step_val<T0, T1>(arg0: &Pool<T0, T1>) : u16 {
        arg0.bin_step
    }

    fun check_remove_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 <= 4102444800000, 446);
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 427);
    }

    fun clear_perm_flag(arg0: &mut PoolPermissions, arg1: u64) {
        arg0.flags = arg0.flags & (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64() ^ arg1);
    }

    public fun close_position<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position) {
        assert_version<T0, T1>(arg0);
        assert_position_pool<T0, T1>(arg0, &arg1);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::destroy_empty(arg1);
        let v0 = PositionDestroyedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(&arg1),
        };
        0x2::event::emit<PositionDestroyedEvent>(v0);
    }

    entry fun collect_protocol_fees<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        assert_collect_allowed<T0, T1>(arg1);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_registry_version(arg0);
        let v0 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::protocol_fee_recipient(arg0);
        let v1 = 0x2::balance::value<T0>(&arg1.protocol_balance_x);
        let v2 = 0x2::balance::value<T1>(&arg1.protocol_balance_y);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_balance_x, v1), arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.protocol_balance_y, v2), arg2), v0);
        };
        let v3 = ProtocolFeesCollectedEvent{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_x : v1,
            amount_y : v2,
        };
        0x2::event::emit<ProtocolFeesCollectedEvent>(v3);
    }

    fun collect_remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &vector<u32>, arg3: &vector<u128>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, vector<u64>, vector<u64>, vector<u128>, vector<u64>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u32>(arg2)) {
            let v7 = *0x1::vector::borrow<u32>(arg2, v6);
            assert!(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::has_bin(arg1, v7), 419);
            0x1::vector::push_back<u64>(&mut v5, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_generation(arg1, v7));
            let v8 = 0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v7) && 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::matches_generation(arg1, v7, bin_generation<T0, T1>(arg0, v7));
            let v9 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::remove_shares(arg1, v7, *0x1::vector::borrow<u128>(arg3, v6));
            if (!v8) {
                0x1::vector::push_back<u64>(&mut v2, 0);
                0x1::vector::push_back<u64>(&mut v3, 0);
                0x1::vector::push_back<u128>(&mut v4, v9);
                v6 = v6 + 1;
                continue
            };
            credit_bin_yield<T0, T1>(arg0, v7);
            let (v10, v11) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::remove_liquidity<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v7), &mut arg0.custody, v9);
            let v12 = v11;
            let v13 = v10;
            0x2::balance::join<T0>(&mut v0, v13);
            0x2::balance::join<T1>(&mut v1, v12);
            0x1::vector::push_back<u64>(&mut v2, 0x2::balance::value<T0>(&v13));
            0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<T1>(&v12));
            0x1::vector::push_back<u128>(&mut v4, v9);
            if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v7)) == 0) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::destroy_empty<T0, T1>(0x2::table::remove<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v7));
                0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::unset(&mut arg0.bitmap, v7);
            } else {
                assert_bin_floor<T0, T1>(arg0, arg1, v7);
            };
            v6 = v6 + 1;
        };
        (v0, v1, v2, v3, v4, v5)
    }

    fun complete_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, arg4: 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>, arg5: bool, arg6: SwapEffects, arg7: 0x2::object::ID, arg8: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (arg5) {
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>(arg3);
            emit_swap(arg7, arg8, &arg6, true, arg0.active_bin_id);
            0x2::balance::destroy_zero<T1>(arg2);
            assert_reserve_solvency<T0, T1>(arg0);
            (arg1, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_y<T0, T1>(&mut arg0.custody, arg4))
        } else {
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>(arg4);
            emit_swap(arg7, arg8, &arg6, false, arg0.active_bin_id);
            0x2::balance::destroy_zero<T0>(arg1);
            assert_reserve_solvency<T0, T1>(arg0);
            (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_x<T0, T1>(&mut arg0.custody, arg3), arg2)
        }
    }

    fun complete_swap_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, arg5: 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>, arg6: bool, arg7: SwapEffects, arg8: 0x2::object::ID, arg9: u64, arg10: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (perms_disable_partner_swaps(&arg0.permissions)) {
            true
        } else if (0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::version(arg1) != 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::current_version()) {
            true
        } else {
            !0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::is_partner_active_at(arg1, arg9)
        };
        if (v0) {
            let v1 = PartnerSwapDowngradedEvent{
                pool_id    : arg8,
                partner_id : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner>(arg1),
                sender     : arg10,
                swap_for_y : arg6,
                amount_in  : arg7.consumed,
                amount_out : arg7.total_out,
            };
            0x2::event::emit<PartnerSwapDowngradedEvent>(v1);
        };
        let v2 = if (v0) {
            0
        } else {
            compute_partner_fee(arg7.total_protocol_fee, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::effective_ref_fee_bps(arg1, arg9))
        };
        let v3 = if (v0) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner>(arg1))
        };
        if (arg6) {
            if (v2 > 0) {
                0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::accrue<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.protocol_balance_x, v2));
                let v6 = PartnerFeeEvent{
                    pool_id     : arg8,
                    partner_id  : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner>(arg1),
                    swap_for_y  : true,
                    partner_fee : v2,
                };
                0x2::event::emit<PartnerFeeEvent>(v6);
            };
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>(arg4);
            emit_swap_event(arg8, arg10, &arg7, true, arg0.active_bin_id, v3);
            0x2::balance::destroy_zero<T1>(arg3);
            assert_reserve_solvency<T0, T1>(arg0);
            (arg2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_y<T0, T1>(&mut arg0.custody, arg5))
        } else {
            if (v2 > 0) {
                0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::accrue<T1>(arg1, 0x2::balance::split<T1>(&mut arg0.protocol_balance_y, v2));
                let v7 = PartnerFeeEvent{
                    pool_id     : arg8,
                    partner_id  : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner>(arg1),
                    swap_for_y  : false,
                    partner_fee : v2,
                };
                0x2::event::emit<PartnerFeeEvent>(v7);
            };
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>(arg5);
            emit_swap_event(arg8, arg10, &arg7, false, arg0.active_bin_id, v3);
            0x2::balance::destroy_zero<T0>(arg2);
            assert_reserve_solvency<T0, T1>(arg0);
            (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_x<T0, T1>(&mut arg0.custody, arg4), arg3)
        }
    }

    public fun compute_partner_fee(arg0: u64, arg1: u16) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg0 as u128), (arg1 as u128), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128()) as u64)
    }

    public(friend) fun create_and_share_pool<T0, T1>(arg0: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters, arg1: u32, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
        0x2::object::id<Pool<T0, T1>>(&v0)
    }

    public(friend) fun create_and_share_pool_with_lending<T0, T1>(arg0: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters, arg1: u32, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::PoolLendingConfig, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        let v1 = 0x2::object::id<Pool<T0, T1>>(&v0);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::init_lending(&mut v0.lending, arg6, v1, arg7, arg8);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
        v1
    }

    public fun create_position<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::new(0x2::object::id<Pool<T0, T1>>(arg0), arg1);
        let v1 = PositionCreatedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(&v0),
            owner       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PositionCreatedEvent>(v1);
        v0
    }

    fun credit_bin_yield<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32) {
        let v0 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v0);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v0);
        let (v3, v4) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::credit_lending_yield<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, arg1), &mut arg0.custody, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_x(&arg0.lending), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_y(&arg0.lending));
        let v5 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1);
        let v6 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v5);
        let v7 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v5);
        let v8 = if (v1 > v6) {
            v1 - v6
        } else {
            0
        };
        let v9 = if (v2 > v7) {
            v2 - v7
        } else {
            0
        };
        if (v8 > 0 || v9 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::consume_pending_burn(&mut arg0.lending, v8, v9);
        };
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::consume_unrealized(&mut arg0.lending, v3, v4);
    }

    public fun current_active_bin_effective_fee_rate<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (oracle_fee_fresh<T0, T1>(arg0, v0)) {
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::apply_oracle_distance_fee(&arg0.fee_params, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &arg0.vol_state, v0), arg0.oracle_bin_id, arg0.active_bin_id, arg1, discount_fresh<T0, T1>(arg0, v0))
        } else {
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &arg0.vol_state, v0)
        }
    }

    public fun current_fee_rate<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &arg0.vol_state, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun custody_ref<T0, T1>(arg0: &Pool<T0, T1>) : &0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1> {
        &arg0.custody
    }

    fun default_perms() : PoolPermissions {
        PoolPermissions{flags: 0}
    }

    public(friend) fun deploy_keeper_allowed<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        if (!arg0.paused) {
            if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending)) {
                if (deploy_perms_allow<T0, T1>(arg0)) {
                    !perms_bypass_venue(&arg0.permissions)
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

    public(friend) fun deploy_perms_allow<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        !perms_disable_lending_deploy(&arg0.permissions) && !perms_disable_lending_recall(&arg0.permissions)
    }

    fun deposit_flash_input_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: vector<BinInput>) {
        if (arg2 > 0) {
            0x2::balance::join<T0>(&mut arg0.protocol_balance_x, 0x2::balance::split<T0>(&mut arg1, arg2));
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<BinInput>(&arg3)) {
            let v1 = 0x1::vector::borrow<BinInput>(&arg3, v0);
            seal_bin_yield<T0, T1>(arg0, v1.bin_id, v1.amount, 0);
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::apply_swap_in_x<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v1.bin_id), &mut arg0.custody, 0x2::balance::split<T0>(&mut arg1, v1.amount));
            v0 = v0 + 1;
        };
        0x2::balance::destroy_zero<T0>(arg1);
    }

    fun deposit_flash_input_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: vector<BinInput>) {
        if (arg2 > 0) {
            0x2::balance::join<T1>(&mut arg0.protocol_balance_y, 0x2::balance::split<T1>(&mut arg1, arg2));
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<BinInput>(&arg3)) {
            let v1 = 0x1::vector::borrow<BinInput>(&arg3, v0);
            seal_bin_yield<T0, T1>(arg0, v1.bin_id, 0, v1.amount);
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::apply_swap_in_y<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v1.bin_id), &mut arg0.custody, 0x2::balance::split<T1>(&mut arg1, v1.amount));
            v0 = v0 + 1;
        };
        0x2::balance::destroy_zero<T1>(arg1);
    }

    fun discount_fresh<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        oracle_age_ms<T0, T1>(arg0, arg1) < 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::discount_max_age_ms()
    }

    public(friend) fun effects_consumed(arg0: &SwapEffects) : u64 {
        arg0.consumed
    }

    public(friend) fun effects_total_fee(arg0: &SwapEffects) : u64 {
        arg0.total_fee
    }

    public(friend) fun effects_total_out(arg0: &SwapEffects) : u64 {
        arg0.total_out
    }

    public(friend) fun effects_total_protocol_fee(arg0: &SwapEffects) : u64 {
        arg0.total_protocol_fee
    }

    public(friend) fun emit_lazer_feed_ids_set(arg0: 0x2::object::ID, arg1: u32, arg2: u32) {
        let v0 = LazerFeedIdsSetEvent{
            pool_id   : arg0,
            feed_id_x : arg1,
            feed_id_y : arg2,
        };
        0x2::event::emit<LazerFeedIdsSetEvent>(v0);
    }

    fun emit_permissions<T0, T1>(arg0: &Pool<T0, T1>) {
        let v0 = PoolPermissionsUpdatedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            permissions : arg0.permissions,
        };
        0x2::event::emit<PoolPermissionsUpdatedEvent>(v0);
    }

    fun emit_swap(arg0: 0x2::object::ID, arg1: address, arg2: &SwapEffects, arg3: bool, arg4: u32) {
        emit_swap_event(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x2::object::ID>());
    }

    fun emit_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: &SwapEffects, arg3: bool, arg4: u32, arg5: 0x1::option::Option<0x2::object::ID>) {
        let v0 = SwapEvent{
            pool_id             : arg0,
            sender              : arg1,
            amount_in           : arg2.consumed,
            amount_out          : arg2.total_out,
            fee                 : arg2.total_fee,
            protocol_fee        : arg2.total_protocol_fee,
            swap_for_y          : arg3,
            active_bin_id       : arg4,
            bins_crossed        : arg2.bins_crossed,
            partner_id          : arg5,
            trace_bin_ids       : arg2.trace_bin_ids,
            trace_amounts_in    : arg2.trace_amounts_in,
            trace_amounts_out   : arg2.trace_amounts_out,
            trace_fees          : arg2.trace_fees,
            trace_protocol_fees : arg2.trace_protocol_fees,
            trace_reserves_x    : arg2.trace_reserves_x,
            trace_reserves_y    : arg2.trace_reserves_y,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    fun feeds_configured<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::is_valid_feed_id(arg0.lazer_feed_id_x) && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::is_valid_feed_id(arg0.lazer_feed_id_y)
    }

    fun finalize_remove<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u32>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u128>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = LiquidityRemovedEvent{
            pool_id       : arg1,
            position_id   : arg2,
            bin_ids       : arg3,
            amounts_x     : arg6,
            amounts_y     : arg7,
            shares_burned : arg8,
            generations   : arg9,
        };
        0x2::event::emit<LiquidityRemovedEvent>(v0);
        assert_reserve_solvency<T0, T1>(arg0);
        (0x2::coin::from_balance<T0>(arg4, arg10), 0x2::coin::from_balance<T1>(arg5, arg10))
    }

    fun finish_recall<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LendingSwapPlan<T0, T1>) : LendingSwapReady<T0, T1> {
        let LendingSwapPlan {
            pool_id      : v0,
            a2b          : v1,
            by_amount_in : v2,
            amount       : v3,
            limit        : v4,
            amount_in    : v5,
            max_consumed : v6,
            limit_bin_id : v7,
            output_need  : v8,
        } = arg1;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
        maybe_distribute_lp_yield<T0, T1>(arg0);
        let v9 = if (v1) {
            idle_y<T0, T1>(arg0)
        } else {
            idle_x<T0, T1>(arg0)
        };
        assert!(v9 >= v8, 415);
        LendingSwapReady<T0, T1>{
            pool_id      : v0,
            a2b          : v1,
            by_amount_in : v2,
            amount       : v3,
            limit        : v4,
            amount_in    : v5,
            max_consumed : v6,
            limit_bin_id : v7,
        }
    }

    fun finish_remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: 0x2::object::ID, arg3: vector<u32>, arg4: &vector<u128>, arg5: RemovalAccountingReady<T0, T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let RemovalAccountingReady {
            pool_id : v0,
            need_x  : v1,
            need_y  : v2,
        } = arg5;
        assert!(v0 == arg2 && arg2 == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
        assert!(idle_x<T0, T1>(arg0) >= v1 && idle_y<T0, T1>(arg0) >= v2, 415);
        let v3 = 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(arg1);
        let (v4, v5, v6, v7, v8, v9) = collect_remove<T0, T1>(arg0, arg1, &arg3, arg4);
        let v10 = v5;
        let v11 = v4;
        assert!(0x2::balance::value<T0>(&v11) >= arg6 && 0x2::balance::value<T1>(&v10) >= arg7, 402);
        finalize_remove<T0, T1>(arg0, arg2, v3, arg3, v11, v10, v6, v7, v8, v9, arg8)
    }

    fun finish_remove_recall<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &vector<u32>, arg3: &vector<u128>, arg4: RemovalAccountingPlan<T0, T1>) : RemovalAccountingReady<T0, T1> {
        let RemovalAccountingPlan {
            pool_id : v0,
            need_x  : _,
            need_y  : _,
        } = arg4;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
        maybe_distribute_lp_yield<T0, T1>(arg0);
        let (v3, v4) = preview_remove<T0, T1>(arg0, arg1, arg2, arg3);
        assert!(idle_x<T0, T1>(arg0) >= v3 && idle_y<T0, T1>(arg0) >= v4, 415);
        RemovalAccountingReady<T0, T1>{
            pool_id : v0,
            need_x  : v3,
            need_y  : v4,
        }
    }

    fun finish_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: LendingSwapReady<T0, T1>, arg4: u64, arg5: 0x2::object::ID, arg6: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg1;
        let v1 = &mut arg2;
        let (v2, v3, v4) = prepare_recall<T0, T1>(arg0, v0, v1, arg3, arg4);
        complete_swap<T0, T1>(arg0, arg1, arg2, v3, v4, arg3.a2b, v2, arg5, arg6)
    }

    fun finish_swap_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: LendingSwapReady<T0, T1>, arg5: u64, arg6: 0x2::object::ID, arg7: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg2;
        let v1 = &mut arg3;
        let (v2, v3, v4) = prepare_recall<T0, T1>(arg0, v0, v1, arg4, arg5);
        complete_swap_partner<T0, T1>(arg0, arg1, arg2, arg3, v3, v4, arg4.a2b, v2, arg6, arg5, arg7)
    }

    fun finish_sync<T0, T1>(arg0: &mut Pool<T0, T1>) {
        maybe_distribute_lp_yield<T0, T1>(arg0);
    }

    public fun flag_add() : u64 {
        2
    }

    public fun flag_bypass_venue() : u64 {
        256
    }

    public fun flag_collect() : u64 {
        8
    }

    public fun flag_flash_swap() : u64 {
        128
    }

    public fun flag_lending_deploy() : u64 {
        16
    }

    public fun flag_lending_recall() : u64 {
        32
    }

    public fun flag_partner_swaps() : u64 {
        64
    }

    public fun flag_remove() : u64 {
        4
    }

    public fun flag_swap() : u64 {
        1
    }

    public fun flash_active<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.flash_active
    }

    public fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u32>, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
        assert_swap<T0, T1>(arg0);
        assert!(!perms_disable_flash_swap(&arg0.permissions), 418);
        assert_no_lending<T0, T1>(arg0);
        assert!(arg2 > 0, 401);
        assert!(0x1::option::is_some<u64>(&arg4), 432);
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let v3 = &mut v1;
        let v4 = &mut v2;
        let (v5, v6, v7, v8) = run_swap_core<T0, T1>(arg0, arg1, true, arg2, v3, v4, true, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
        let v9 = v5;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(v9.consumed <= *0x1::option::borrow<u64>(&arg4), 432);
        };
        assert!(v9.total_out >= arg3, 402);
        assert!(v9.total_out > 0, 410);
        let (v10, v11) = if (arg1) {
            assert_idle_output<T0, T1>(arg0, idle_y<T0, T1>(arg0), v9.total_out);
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>(v6);
            (0x2::balance::zero<T0>(), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_y<T0, T1>(&mut arg0.custody, v7))
        } else {
            assert_idle_output<T0, T1>(arg0, idle_x<T0, T1>(arg0), v9.total_out);
            0x2::balance::destroy_zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>(v7);
            (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_x<T0, T1>(&mut arg0.custody, v6), 0x2::balance::zero<T1>())
        };
        arg0.flash_active = true;
        let v12 = FlashSwapReceipt<T0, T1>{
            pool_id            : v0,
            swap_for_y         : arg1,
            consumed           : v9.consumed,
            total_protocol_fee : v9.total_protocol_fee,
            total_fee          : v9.total_fee,
            total_out          : v9.total_out,
            bin_inputs         : v8,
        };
        (v10, v11, v12)
    }

    public fun get_active_bin_ratio<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        let v0 = arg0.active_bin_id;
        if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v0)) {
            return (0, 0)
        };
        preview_bin_reserves<T0, T1>(arg0, 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v0))
    }

    public fun get_bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : (u64, u64, u128) {
        if (0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1)) {
            let v3 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1);
            let (v4, v5) = preview_bin_reserves<T0, T1>(arg0, v3);
            (v4, v5, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v3))
        } else {
            (0, 0, 0)
        }
    }

    public fun get_bins_in_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32, arg2: u32) : (vector<u32>, vector<u64>, vector<u64>, vector<u128>) {
        assert!(arg2 >= arg1, 407);
        assert!(arg2 - arg1 < 256, 407);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        while (arg1 <= arg2) {
            if (0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1)) {
                let v4 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, arg1);
                let (v5, v6) = preview_bin_reserves<T0, T1>(arg0, v4);
                0x1::vector::push_back<u32>(&mut v0, arg1);
                0x1::vector::push_back<u64>(&mut v1, v5);
                0x1::vector::push_back<u64>(&mut v2, v6);
                0x1::vector::push_back<u128>(&mut v3, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v4));
            };
            if (arg1 == arg2) {
                break
            };
            arg1 = arg1 + 1;
        };
        (v0, v1, v2, v3)
    }

    public fun get_current_price<T0, T1>(arg0: &Pool<T0, T1>) : 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fixed_point64::FP64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::get_price(arg0.active_bin_id, arg0.bin_step)
    }

    public fun get_position_total_value<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position) : (u64, u64) {
        get_position_value<T0, T1>(arg0, arg1)
    }

    public fun get_position_value<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position) : (u64, u64) {
        assert_not_flash_active<T0, T1>(arg0);
        assert_position_pool<T0, T1>(arg0, arg1);
        let v0 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(v0)) {
            let v4 = *0x1::vector::borrow<u32>(v0, v3);
            if (0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v4) && 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::matches_generation(arg1, v4, bin_generation<T0, T1>(arg0, v4))) {
                let v5 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v4);
                let v6 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(arg1, v4);
                let v7 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v5);
                if (v7 > 0) {
                    let (v8, v9) = preview_bin_reserves<T0, T1>(arg0, v5);
                    v1 = v1 + 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((v8 as u128), v6, v7);
                    v2 = v2 + 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((v9 as u128), v6, v7);
                };
            };
            v3 = v3 + 1;
        };
        let v10 = if (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::fits_u64(v1)) {
            (v1 as u64)
        } else {
            18446744073709551615
        };
        let v11 = if (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::fits_u64(v2)) {
            (v2 as u64)
        } else {
            18446744073709551615
        };
        (v10, v11)
    }

    entry fun guardian_disable<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::GuardianCap, arg2: &mut Pool<T0, T1>, arg3: u64) {
        assert_known_flags(arg3);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_guardian_cap(arg0, arg1);
        assert_version<T0, T1>(arg2);
        assert_not_flash_active<T0, T1>(arg2);
        let v0 = &mut arg2.permissions;
        set_perm_flag(v0, arg3);
        emit_permissions<T0, T1>(arg2);
    }

    entry fun guardian_pause<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::GuardianCap, arg2: &mut Pool<T0, T1>) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_guardian_cap(arg0, arg1);
        assert_version<T0, T1>(arg2);
        assert_not_flash_active<T0, T1>(arg2);
        arg2.paused = true;
        let v0 = PoolPausedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg2),
            by_guardian : true,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public(friend) fun idle_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<T0, T1>(&arg0.custody)
    }

    public(friend) fun idle_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_y<T0, T1>(&arg0.custody)
    }

    public fun is_paused<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_swap_enabled<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        !arg0.paused && !perms_disable_swap(&arg0.permissions)
    }

    public fun lazer_feed_id_x<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.lazer_feed_id_x
    }

    public fun lazer_feed_id_y<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.lazer_feed_id_y
    }

    public fun lazer_feeds_configured<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        feeds_configured<T0, T1>(arg0)
    }

    public fun lending_active<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending)
    }

    public fun lending_external_reward_balance<T0, T1, T2>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::external_reward_balance<T2>(&arg0.lending)
    }

    public fun lending_last_sync_ts_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::last_sync_ts_ms(&arg0.lending)
    }

    public fun lending_lifetime_yield_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lifetime_yield_x(&arg0.lending)
    }

    public fun lending_lifetime_yield_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lifetime_yield_y(&arg0.lending)
    }

    public fun lending_live_underlying_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(&arg0.custody)
    }

    public fun lending_live_underlying_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(&arg0.custody)
    }

    public fun lending_lp_yield_growth_x<T0, T1>(arg0: &Pool<T0, T1>) : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_x(&arg0.lending)
    }

    public fun lending_lp_yield_growth_y<T0, T1>(arg0: &Pool<T0, T1>) : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_y(&arg0.lending)
    }

    public fun lending_lp_yield_share_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_share_bps(&arg0.lending)
    }

    public(friend) fun lending_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::PoolLending {
        &mut arg0.lending
    }

    public(friend) fun lending_parts_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : (&mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::PoolLending, &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>) {
        (&mut arg0.lending, &mut arg0.custody)
    }

    public fun lending_pending_protocol_yield_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::pending_protocol_yield_x(&arg0.lending)
    }

    public fun lending_pending_protocol_yield_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::pending_protocol_yield_y(&arg0.lending)
    }

    public(friend) fun lending_ref<T0, T1>(arg0: &Pool<T0, T1>) : &0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::PoolLending {
        &arg0.lending
    }

    public(friend) fun maybe_distribute_lp_yield<T0, T1>(arg0: &mut Pool<T0, T1>) {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::distribute_lp_yield(&mut arg0.lending, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(&arg0.custody), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(&arg0.custody));
    }

    entry fun migrate<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::OperatorCap, arg2: &mut Pool<T0, T1>) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_operator_cap(arg0, arg1);
        assert_not_flash_active<T0, T1>(arg2);
        assert!(arg2.version < 1, 409);
        arg2.version = 1;
        let v0 = PoolMigratedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg2),
            old_version : arg2.version,
            new_version : 1,
        };
        0x2::event::emit<PoolMigratedEvent>(v0);
    }

    public fun min_liquidity_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_liquidity_x
    }

    public fun min_liquidity_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_liquidity_y
    }

    public fun needs_migration<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.version < 1
    }

    fun new_pool<T0, T1>(arg0: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters, arg1: u32, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert_valid_lazer_feed_ids(arg4, arg5);
        assert!(arg2 > 0 && arg3 > 0, 438);
        Pool<T0, T1>{
            id                  : 0x2::object::new(arg6),
            version             : 1,
            bin_step            : 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::bin_step(&arg0),
            active_bin_id       : arg1,
            bins                : 0x2::table::new<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(arg6),
            next_bin_generation : 1,
            fee_params          : arg0,
            vol_state           : 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::new_volatility_state(),
            custody             : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::new<T0, T1>(),
            protocol_balance_x  : 0x2::balance::zero<T0>(),
            protocol_balance_y  : 0x2::balance::zero<T1>(),
            paused              : false,
            permissions         : default_perms(),
            lending             : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::new(arg6),
            bitmap              : 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::new_bitmap(arg6),
            oracle_bin_id       : 0,
            oracle_last_updated : 0,
            lazer_feed_id_x     : arg4,
            lazer_feed_id_y     : arg5,
            flash_active        : false,
            min_liquidity_x     : arg2,
            min_liquidity_y     : arg3,
            extra               : 0x2::bag::new(arg6),
        }
    }

    fun new_remove_plan<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : RemovalAccountingPlan<T0, T1> {
        RemovalAccountingPlan<T0, T1>{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            need_x  : arg1,
            need_y  : arg2,
        }
    }

    fun open_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::balance::Balance<T0>, arg3: &0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock) : (LendingSwapPlan<T0, T1>, 0x2::object::ID, u64) {
        let v0 = if (arg4) {
            0x2::balance::value<T0>(arg2)
        } else {
            0x2::balance::value<T1>(arg3)
        };
        assert_swap_pre<T0, T1>(arg0, v0);
        let v1 = 0x2::object::id<Pool<T0, T1>>(arg0);
        sync_swap<T0, T1>(arg0, arg1, v1, arg10);
        (plan_lending_swap<T0, T1>(arg0, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10), v1, 0x2::clock::timestamp_ms(arg10))
    }

    entry fun operator_disable<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::OperatorCap, arg2: &mut Pool<T0, T1>, arg3: u64) {
        assert_known_flags(arg3);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_operator_cap(arg0, arg1);
        assert_version<T0, T1>(arg2);
        assert_not_flash_active<T0, T1>(arg2);
        let v0 = &mut arg2.permissions;
        set_perm_flag(v0, arg3);
        emit_permissions<T0, T1>(arg2);
    }

    entry fun operator_enable<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::OperatorCap, arg2: &mut Pool<T0, T1>, arg3: u64) {
        assert_known_flags(arg3);
        assert!(arg3 & 256 == 0, 448);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_operator_cap(arg0, arg1);
        assert_version<T0, T1>(arg2);
        assert_not_flash_active<T0, T1>(arg2);
        let v0 = &mut arg2.permissions;
        clear_perm_flag(v0, arg3);
        emit_permissions<T0, T1>(arg2);
    }

    fun oracle_age_ms<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        if (arg0.oracle_bin_id == 0) {
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64()
        } else if (arg1 >= arg0.oracle_last_updated) {
            arg1 - arg0.oracle_last_updated
        } else {
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64()
        }
    }

    public fun oracle_bin_id<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.oracle_bin_id
    }

    fun oracle_fee_fresh<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        feeds_configured<T0, T1>(arg0) && oracle_age_ms<T0, T1>(arg0, arg1) < (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::oracle_max_age_ms(&arg0.fee_params) as u64)
    }

    public fun oracle_last_updated<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.oracle_last_updated
    }

    public fun oracle_max_age_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::oracle_max_age_ms(&arg0.fee_params) as u64)
    }

    public fun oracle_verified<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.oracle_bin_id > 0
    }

    entry fun pause<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Pool<T0, T1>) {
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        arg1.paused = true;
        let v0 = PoolPausedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg1),
            by_guardian : false,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public(friend) fun pay_recipient<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun perms_bypass_venue(arg0: &PoolPermissions) : bool {
        arg0.flags & 256 != 0
    }

    public fun perms_disable_add(arg0: &PoolPermissions) : bool {
        arg0.flags & 2 != 0
    }

    public fun perms_disable_collect(arg0: &PoolPermissions) : bool {
        arg0.flags & 8 != 0
    }

    public fun perms_disable_flash_swap(arg0: &PoolPermissions) : bool {
        arg0.flags & 128 != 0
    }

    public fun perms_disable_lending_deploy(arg0: &PoolPermissions) : bool {
        arg0.flags & 16 != 0
    }

    public fun perms_disable_lending_recall(arg0: &PoolPermissions) : bool {
        arg0.flags & 32 != 0
    }

    public fun perms_disable_partner_swaps(arg0: &PoolPermissions) : bool {
        arg0.flags & 64 != 0
    }

    public fun perms_disable_remove(arg0: &PoolPermissions) : bool {
        arg0.flags & 4 != 0
    }

    public fun perms_disable_swap(arg0: &PoolPermissions) : bool {
        arg0.flags & 1 != 0
    }

    public fun perms_flags(arg0: &PoolPermissions) : u64 {
        arg0.flags
    }

    fun plan_lending_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u32>, arg8: &0x2::clock::Clock) : LendingSwapPlan<T0, T1> {
        LendingSwapPlan<T0, T1>{
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b          : arg1,
            by_amount_in : arg2,
            amount       : arg3,
            limit        : arg4,
            amount_in    : arg5,
            max_consumed : arg6,
            limit_bin_id : arg7,
            output_need  : preview_recall<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8),
        }
    }

    public fun pool_permissions<T0, T1>(arg0: &Pool<T0, T1>) : PoolPermissions {
        arg0.permissions
    }

    fun prepare_recall<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: LendingSwapReady<T0, T1>, arg4: u64) : (SwapEffects, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>) {
        let LendingSwapReady {
            pool_id      : v0,
            a2b          : v1,
            by_amount_in : v2,
            amount       : v3,
            limit        : v4,
            amount_in    : v5,
            max_consumed : v6,
            limit_bin_id : v7,
        } = arg3;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
        let (v8, v9, v10) = prepare_swap<T0, T1>(arg0, v1, v2, v3, v4, v5, arg1, arg2, v6, v7, arg4);
        let v11 = v8;
        let v12 = if (v1) {
            idle_y<T0, T1>(arg0)
        } else {
            idle_x<T0, T1>(arg0)
        };
        assert!(v12 >= v11.total_out, 415);
        (v11, v9, v10)
    }

    fun prepare_remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &vector<u32>, arg4: &vector<u128>, arg5: &0x2::clock::Clock) : (u64, u64) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
        assert_remove<T0, T1>(arg0);
        assert_position_pool<T0, T1>(arg0, arg1);
        let v0 = 0x1::vector::length<u32>(arg3);
        assert!(v0 > 0, 404);
        assert!(v0 == 0x1::vector::length<u128>(arg4), 405);
        assert_ascending_bins(arg3);
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending) && !perms_bypass_venue(&arg0.permissions)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::sync<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg2, 0x2::object::id<Pool<T0, T1>>(arg0), arg5);
        };
        maybe_distribute_lp_yield<T0, T1>(arg0);
        preview_remove<T0, T1>(arg0, arg1, arg3, arg4)
    }

    fun prepare_remove_no_lending<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &vector<u32>, arg3: &vector<u128>) : (u64, u64) {
        assert_version<T0, T1>(arg0);
        assert_not_flash_active<T0, T1>(arg0);
        assert_remove<T0, T1>(arg0);
        assert_position_pool<T0, T1>(arg0, arg1);
        let v0 = 0x1::vector::length<u32>(arg2);
        assert!(v0 > 0, 404);
        assert!(v0 == 0x1::vector::length<u128>(arg3), 405);
        assert_ascending_bins(arg2);
        assert_no_lending_exit<T0, T1>(arg0);
        maybe_distribute_lp_yield<T0, T1>(arg0);
        preview_remove<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun prepare_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::balance::Balance<T0>, arg7: &mut 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u32>, arg10: u64) : (SwapEffects, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>) {
        if (arg2) {
            assert!(0x1::option::is_some<u64>(&arg8), 432);
        };
        let (v0, v1, v2, _) = run_swap_core<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, false, arg8, arg9, arg10);
        let v4 = v0;
        if (arg2) {
            if (0x1::option::is_some<u64>(&arg8)) {
                assert!(v4.consumed <= *0x1::option::borrow<u64>(&arg8), 432);
            };
            assert!(v4.total_out >= arg4, 402);
            assert!(v4.total_out > 0, 410);
        } else {
            assert!(arg3 > 0, 401);
            assert!(arg5 >= v4.consumed && v4.consumed <= arg4, 402);
        };
        (v4, v1, v2)
    }

    fun preview_bin_reserves<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>) : (u64, u64) {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::preview_credited_reserves<T0, T1>(arg1, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_x(&arg0.lending), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_y(&arg0.lending))
    }

    fun preview_recall<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u32>, arg8: &0x2::clock::Clock) : u64 {
        if (arg2) {
            assert!(0x1::option::is_some<u64>(&arg6), 432);
        };
        let v0 = simulate_core<T0, T1>(arg0, arg3, arg1, arg2, arg6, arg7, arg8);
        if (arg2) {
            assert!(v0.amount_out >= arg4, 402);
            assert!(v0.amount_out > 0, 410);
        } else {
            assert!(arg3 > 0, 401);
            assert!(arg5 >= v0.consumed_in && v0.consumed_in <= arg4, 402);
        };
        v0.amount_out
    }

    fun preview_remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &vector<u32>, arg3: &vector<u128>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg2)) {
            let v3 = *0x1::vector::borrow<u32>(arg2, v2);
            assert!(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::has_bin(arg1, v3), 419);
            if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v3)) {
                v2 = v2 + 1;
                continue
            };
            if (!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::matches_generation(arg1, v3, bin_generation<T0, T1>(arg0, v3))) {
                v2 = v2 + 1;
                continue
            };
            credit_bin_yield<T0, T1>(arg0, v3);
            let v4 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v3);
            let v5 = *0x1::vector::borrow<u128>(arg3, v2);
            let v6 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(arg1, v3);
            let v7 = if (v5 > v6) {
                v6
            } else {
                v5
            };
            let v8 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v4);
            assert!(v8 > 0, 419);
            v0 = v0 + (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v4) as u128), v7, v8) as u64);
            v1 = v1 + (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v4) as u128), v7, v8) as u64);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun protocol_fee_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.protocol_balance_x)
    }

    public fun protocol_fee_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.protocol_balance_y)
    }

    public fun quote_add_liquidity_active_bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = arg0.active_bin_id;
        if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v0)) {
            return (arg1, arg2)
        };
        let v1 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v0);
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(v1) == 0) {
            return (arg1, arg2)
        };
        let (v2, v3) = preview_bin_reserves<T0, T1>(arg0, v1);
        if (v2 == 0 && v3 == 0) {
            return (arg1, arg2)
        };
        if (v2 == 0) {
            return (0, arg2)
        };
        if (v3 == 0) {
            return (arg1, 0)
        };
        let v4 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg1 as u128), (v3 as u128), (v2 as u128));
        if (v4 <= (arg2 as u128)) {
            return (arg1, (v4 as u64))
        };
        let v5 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg2 as u128), (v2 as u128), (v3 as u128));
        if (!0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::fits_u64(v5)) {
            return (0, 0)
        };
        ((v5 as u64), (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor(v5, (v3 as u128), (v2 as u128)) as u64))
    }

    public fun quote_amount_out(arg0: &SwapQuote) : u64 {
        arg0.amount_out
    }

    public fun quote_bins_crossed(arg0: &SwapQuote) : u32 {
        arg0.bins_crossed
    }

    public fun quote_consumed_in(arg0: &SwapQuote) : u64 {
        arg0.consumed_in
    }

    public fun quote_final_active_bin_id(arg0: &SwapQuote) : u32 {
        arg0.final_active_bin_id
    }

    fun quote_impl<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = simulate_core<T0, T1>(arg0, arg1, arg2, true, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg3);
        (v0.amount_out, v0.total_fee)
    }

    public fun quote_protocol_fee(arg0: &SwapQuote) : u64 {
        arg0.protocol_fee
    }

    public fun quote_refund_in(arg0: &SwapQuote) : u64 {
        arg0.refund_in
    }

    public fun quote_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        quote_impl<T0, T1>(arg0, arg2, arg1, arg3)
    }

    public fun quote_total_fee(arg0: &SwapQuote) : u64 {
        arg0.total_fee
    }

    fun recall_output<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: LendingSwapPlan<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : LendingSwapReady<T0, T1> {
        assert!(arg2 == arg3.pool_id, 403);
        if (should_jit_recall<T0, T1>(arg0)) {
            if (arg3.a2b) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_y<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg1, arg2, arg3.output_need, arg4, arg5);
            } else {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_x<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg1, arg2, arg3.output_need, arg4, arg5);
            };
        };
        finish_recall<T0, T1>(arg0, arg3)
    }

    fun recall_output_sui_x<T0>(arg0: &mut Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::object::ID, arg4: LendingSwapPlan<0x2::sui::SUI, T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : LendingSwapReady<0x2::sui::SUI, T0> {
        assert!(arg3 == arg4.pool_id, 403);
        if (should_jit_recall<0x2::sui::SUI, T0>(arg0)) {
            if (arg4.a2b) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_y<0x2::sui::SUI, T0>(&mut arg0.lending, &mut arg0.custody, arg1, arg3, arg4.output_need, arg5, arg6);
            } else {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_x_sui<T0>(&mut arg0.lending, &mut arg0.custody, arg1, arg3, arg4.output_need, arg2, arg5, arg6);
            };
        };
        finish_recall<0x2::sui::SUI, T0>(arg0, arg4)
    }

    public fun receipt_consumed<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.consumed
    }

    public fun receipt_swap_for_y<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : bool {
        arg0.swap_for_y
    }

    public fun receipt_total_out<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.total_out
    }

    public fun refresh_oracle_bin_id<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::clock::Clock) {
        assert_refresh<T0, T1>(arg0);
        if (!feeds_configured<T0, T1>(arg0)) {
            return
        };
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::compute_oracle_bin_id<T0, T1>(arg1, arg0.lazer_feed_id_x, arg0.lazer_feed_id_y, arg2, arg3, arg0.bin_step, (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::oracle_max_age_ms(&arg0.fee_params) as u64), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::oracle_max_conf_bps(&arg0.fee_params), (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::oracle_max_pair_skew_ms(&arg0.fee_params) as u64), arg4);
        if (0x1::option::is_none<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::OracleBinUpdate>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::OracleBinUpdate>(v0);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::bin_id(&v1);
        let v3 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::oracle_adapter::oldest_ms(&v1);
        let v4 = apply_oracle_update<T0, T1>(arg0, v2, v3);
        if (!v4) {
            return
        };
        let v5 = OracleBinIdRefreshedEvent{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            oracle_bin_id   : v2,
            oldest_price_ms : v3,
        };
        0x2::event::emit<OracleBinIdRefreshedEvent>(v5);
    }

    public fun remove_liquidity_no_lending<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: vector<u32>, arg3: vector<u128>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_remove_deadline(arg7, arg6);
        let (v0, v1) = prepare_remove_no_lending<T0, T1>(arg0, arg1, &arg2, &arg3);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v3 = new_remove_plan<T0, T1>(arg0, v0, v1);
        let v4 = finish_remove_recall<T0, T1>(arg0, arg1, &arg2, &arg3, v3);
        finish_remove<T0, T1>(arg0, arg1, v2, arg2, &arg3, v4, arg4, arg5, arg8)
    }

    public fun remove_liquidity_x_sui<T0>(arg0: &mut Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u128>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        check_remove_deadline(arg9, arg8);
        let (v0, v1) = prepare_remove<0x2::sui::SUI, T0>(arg0, arg1, arg2, &arg3, &arg4, arg9);
        let v2 = 0x2::object::id<Pool<0x2::sui::SUI, T0>>(arg0);
        let v3 = new_remove_plan<0x2::sui::SUI, T0>(arg0, v0, v1);
        let (v4, v5) = remove_needs<0x2::sui::SUI, T0>(&v3);
        if (should_jit_recall<0x2::sui::SUI, T0>(arg0)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_x_sui<T0>(&mut arg0.lending, &mut arg0.custody, arg2, v2, v4, arg5, arg9, arg10);
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::jit_recall_if_short_y<0x2::sui::SUI, T0>(&mut arg0.lending, &mut arg0.custody, arg2, v2, v5, arg9, arg10);
        };
        let v6 = finish_remove_recall<0x2::sui::SUI, T0>(arg0, arg1, &arg3, &arg4, v3);
        finish_remove<0x2::sui::SUI, T0>(arg0, arg1, v2, arg3, &arg4, v6, arg6, arg7, arg10)
    }

    fun remove_needs<T0, T1>(arg0: &RemovalAccountingPlan<T0, T1>) : (u64, u64) {
        (arg0.need_x, arg0.need_y)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let FlashSwapReceipt {
            pool_id            : v0,
            swap_for_y         : v1,
            consumed           : v2,
            total_protocol_fee : v3,
            total_fee          : v4,
            total_out          : v5,
            bin_inputs         : v6,
        } = arg3;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 403);
        arg0.flash_active = false;
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v2, 411);
            deposit_flash_input_x<T0, T1>(arg0, arg1, v3, v6);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v2, 411);
            deposit_flash_input_y<T0, T1>(arg0, arg2, v3, v6);
            0x2::balance::destroy_zero<T0>(arg1);
        };
        let v7 = FlashSwapEvent{
            pool_id       : v0,
            swap_for_y    : v1,
            amount_in     : v2,
            amount_out    : v5,
            fee           : v4,
            protocol_fee  : v3,
            active_bin_id : arg0.active_bin_id,
        };
        0x2::event::emit<FlashSwapEvent>(v7);
        assert_reserve_solvency<T0, T1>(arg0);
    }

    fun reset_dead_bin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u32) {
        let v0 = 0x2::table::remove<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, arg2);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::total_shares<T0, T1>(&v0);
        assert!(v1 > 0, 443);
        let (v2, v3) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::remove_liquidity<T0, T1>(&mut v0, &mut arg0.custody, v1);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::destroy_empty<T0, T1>(v0);
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::unset(&mut arg0.bitmap, arg2);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T1>(v3);
        let v4 = BinGenerationRetiredEvent{
            pool_id      : arg1,
            bin_id       : arg2,
            generation   : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::generation<T0, T1>(&v0),
            total_shares : v1,
        };
        0x2::event::emit<BinGenerationRetiredEvent>(v4);
    }

    fun run_idle_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u32>, arg9: &0x2::clock::Clock) : (SwapEffects, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>, 0x2::object::ID, u64) {
        let v0 = if (arg3) {
            0x2::balance::value<T0>(arg1)
        } else {
            0x2::balance::value<T1>(arg2)
        };
        assert_swap_pre<T0, T1>(arg0, v0);
        assert_no_lending<T0, T1>(arg0);
        let v1 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let (v3, v4, v5) = prepare_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, v0, arg1, arg2, arg7, arg8, v2);
        let v6 = v3;
        assert_output<T0, T1>(arg0, arg3, v6.total_out);
        (v6, v4, v5, v1, v2)
    }

    fun run_swap_core<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u32>, arg9: u64) : (SwapEffects, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>, 0x2::balance::Balance<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>, vector<BinInput>) {
        let v0 = oracle_fee_fresh<T0, T1>(arg0, arg9);
        let v1 = if (arg2 && 0x1::option::is_some<u64>(&arg7)) {
            let v2 = *0x1::option::borrow<u64>(&arg7);
            if (arg3 < v2) {
                arg3
            } else {
                v2
            }
        } else {
            arg3
        };
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x2::balance::zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>();
        let v9 = 0x2::balance::zero<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>();
        let v10 = 0x1::vector::empty<BinInput>();
        let v11 = arg0.active_bin_id;
        let v12 = 0;
        let v13 = vector[];
        let v14 = vector[];
        let v15 = vector[];
        let v16 = vector[];
        let v17 = vector[];
        let v18 = vector[];
        let v19 = vector[];
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::update_references(&mut arg0.vol_state, &arg0.fee_params, v11, arg9);
        while (v3 > 0) {
            if (v12 == 256) {
                assert!(arg2, 431);
                break
            };
            v12 = v12 + 1;
            let v20 = arg0.active_bin_id;
            let v21 = v20;
            if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v20)) {
                let (v22, v23) = if (arg1) {
                    0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::find_next_below(&arg0.bitmap, v20)
                } else {
                    0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::find_next_above(&arg0.bitmap, v20)
                };
                let v24 = if (v22) {
                    0x1::option::some<u32>(v23)
                } else {
                    0x1::option::none<u32>()
                };
                let v25 = advance_active<T0, T1>(arg0, v24, arg2, true, v11);
                if (!v25) {
                    break
                };
                v21 = arg0.active_bin_id;
            };
            credit_bin_yield<T0, T1>(arg0, v21);
            if (arg1 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)) == 0 || 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)) == 0) {
                let v26 = if (arg1) {
                    if (v21 == 0) {
                        0x1::option::none<u32>()
                    } else {
                        0x1::option::some<u32>(v21 - 1)
                    }
                } else if (v21 >= 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::max_bin_id()) {
                    0x1::option::none<u32>()
                } else {
                    0x1::option::some<u32>(v21 + 1)
                };
                let v27 = advance_active<T0, T1>(arg0, v26, arg2, true, v11);
                if (!v27) {
                    break
                } else {
                    continue
                };
            };
            if (0x1::option::is_some<u32>(&arg8)) {
                let v28 = *0x1::option::borrow<u32>(&arg8);
                if (arg1 && v21 < v28 || !arg1 && v21 > v28) {
                    assert!(arg2, 431);
                    arg0.active_bin_id = v11;
                    break
                };
            };
            let v29 = arg0.vol_state;
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::update_volatility_accumulator(&mut v29, &arg0.fee_params, v21);
            let v30 = if (v0) {
                0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::apply_oracle_distance_fee(&arg0.fee_params, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &v29, arg9), arg0.oracle_bin_id, v21, arg1, discount_fresh<T0, T1>(arg0, arg9))
            } else {
                0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &v29, arg9)
            };
            let v31 = if (arg2) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::swap_with_fees<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21), v3, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::price<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)), v30, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::fee_precision(), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::protocol_share(&arg0.fee_params), arg1)
            } else {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::swap_exact_out_with_fees<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21), v3, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::price<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)), v30, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::fee_precision(), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::protocol_share(&arg0.fee_params), arg1)
            };
            let v32 = v31;
            let v33 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_consumed(&v32);
            let v34 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_out(&v32);
            let v35 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_protocol_fee(&v32);
            let v36 = v35 + 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_lp_fee(&v32);
            if (v33 == 0 && v34 == 0) {
                arg0.active_bin_id = v11;
                break
            };
            arg0.vol_state = v29;
            0x1::vector::push_back<u32>(&mut v13, v21);
            0x1::vector::push_back<u64>(&mut v14, v33);
            0x1::vector::push_back<u64>(&mut v15, v34);
            0x1::vector::push_back<u64>(&mut v16, v36);
            0x1::vector::push_back<u64>(&mut v17, v35);
            let v37 = v33 - v35;
            if (arg1) {
                if (arg6) {
                    let v38 = BinInput{
                        bin_id : v21,
                        amount : v37,
                    };
                    0x1::vector::push_back<BinInput>(&mut v10, v38);
                } else {
                    assert!(0x2::balance::value<T0>(arg4) >= v33, 402);
                    seal_bin_yield<T0, T1>(arg0, v21, v37, 0);
                    0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::apply_swap_in_x<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v21), &mut arg0.custody, 0x2::balance::split<T0>(arg4, v37));
                    0x2::balance::join<T0>(&mut arg0.protocol_balance_x, 0x2::balance::split<T0>(arg4, v35));
                };
                0x2::balance::join<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::YToken<T1>>(&mut v9, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::take_out_y<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v21), v34));
            } else {
                if (arg6) {
                    let v39 = BinInput{
                        bin_id : v21,
                        amount : v37,
                    };
                    0x1::vector::push_back<BinInput>(&mut v10, v39);
                } else {
                    assert!(0x2::balance::value<T1>(arg5) >= v33, 402);
                    seal_bin_yield<T0, T1>(arg0, v21, 0, v37);
                    0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::apply_swap_in_y<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v21), &mut arg0.custody, 0x2::balance::split<T1>(arg5, v37));
                    0x2::balance::join<T1>(&mut arg0.protocol_balance_y, 0x2::balance::split<T1>(arg5, v35));
                };
                0x2::balance::join<0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::XToken<T0>>(&mut v8, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::take_out_x<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, v21), v34));
            };
            let v40 = 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21);
            0x1::vector::push_back<u64>(&mut v18, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(v40));
            0x1::vector::push_back<u64>(&mut v19, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(v40));
            v4 = v4 + v33;
            v5 = v5 + v34;
            v7 = v7 + v35;
            v6 = v6 + v36;
            let v41 = if (arg2) {
                v33
            } else {
                v34
            };
            let v42 = v3 - v41;
            v3 = v42;
            if (arg1 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_y<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)) == 0 || 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::reserve_x<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v21)) == 0) {
                let v43 = if (arg1) {
                    if (v21 == 0) {
                        0x1::option::none<u32>()
                    } else {
                        0x1::option::some<u32>(v21 - 1)
                    }
                } else if (v21 >= 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::max_bin_id()) {
                    0x1::option::none<u32>()
                } else {
                    0x1::option::some<u32>(v21 + 1)
                };
                let v44 = advance_active<T0, T1>(arg0, v43, arg2, v42 > 0, v21);
                if (!v44) {
                    break
                } else {
                    continue
                };
            };
            if (arg2 && v42 > 0) {
                break
            };
        };
        if (!arg2 && v3 > 0) {
            abort 412
        };
        let v45 = arg0.active_bin_id;
        let v46 = if (v45 >= v11) {
            v45 - v11
        } else {
            v11 - v45
        };
        let v47 = SwapEffects{
            total_out           : v5,
            total_protocol_fee  : v7,
            total_fee           : v6,
            consumed            : v4,
            bins_crossed        : v46,
            trace_bin_ids       : v13,
            trace_amounts_in    : v14,
            trace_amounts_out   : v15,
            trace_fees          : v16,
            trace_protocol_fees : v17,
            trace_reserves_x    : v18,
            trace_reserves_y    : v19,
        };
        (v47, v8, v9, v10)
    }

    fun seal_bin_yield<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u64, arg3: u64) {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::seal_yield_interval_before_reserve_growth<T0, T1>(0x2::table::borrow_mut<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&mut arg0.bins, arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_x(&arg0.lending), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::lp_yield_growth_y(&arg0.lending), arg2, arg3);
    }

    fun set_perm_flag(arg0: &mut PoolPermissions, arg1: u64) {
        arg0.flags = arg0.flags | arg1;
    }

    entry fun set_pool_fee_params<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::OperatorCap, arg2: &mut Pool<T0, T1>, arg3: 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::FeeParameters) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_operator_cap(arg0, arg1);
        assert_version<T0, T1>(arg2);
        assert_not_flash_active<T0, T1>(arg2);
        assert!(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::bin_step(&arg3) == arg2.bin_step, 447);
        arg2.fee_params = arg3;
        let v0 = FeeParamsUpdatedEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg2),
            fee_params : arg3,
        };
        0x2::event::emit<FeeParamsUpdatedEvent>(v0);
    }

    entry fun set_pool_permissions<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert_known_flags(arg2);
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        let v0 = PoolPermissions{flags: arg2};
        arg1.permissions = v0;
        let v1 = PoolPermissionsUpdatedEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg1),
            permissions : arg1.permissions,
        };
        0x2::event::emit<PoolPermissionsUpdatedEvent>(v1);
    }

    fun should_jit_recall<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_enabled(&arg0.lending)) {
            if (!perms_disable_lending_recall(&arg0.permissions)) {
                !perms_bypass_venue(&arg0.permissions)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun simulate_core<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u32>, arg6: &0x2::clock::Clock) : SwapQuote {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = arg0.bin_step;
        let v2 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::max_bin_id();
        let v3 = if (arg3 && 0x1::option::is_some<u64>(&arg4)) {
            let v4 = *0x1::option::borrow<u64>(&arg4);
            if (arg1 < v4) {
                arg1
            } else {
                v4
            }
        } else {
            arg1
        };
        let v5 = v3;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = arg0.active_bin_id;
        let v11 = arg0.active_bin_id;
        let v12 = v11;
        let v13 = 0;
        let v14 = arg0.vol_state;
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::update_references(&mut v14, &arg0.fee_params, v11, v0);
        while (v5 > 0) {
            if (v13 == 256) {
                assert!(arg3, 431);
                break
            };
            v13 = v13 + 1;
            if (!0x2::table::contains<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v12)) {
                let (v15, v16) = if (arg2) {
                    0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::find_next_below(&arg0.bitmap, v12)
                } else {
                    0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap::find_next_above(&arg0.bitmap, v12)
                };
                if (!v15) {
                    break
                };
                if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v16, v1)) {
                    v12 = v10;
                    break
                };
                v12 = v16;
            };
            let (v17, v18) = preview_bin_reserves<T0, T1>(arg0, 0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v12));
            let v19 = if (arg2) {
                v18
            } else {
                v17
            };
            if (v19 == 0) {
                if (arg2) {
                    if (v12 == 0) {
                        break
                    };
                    let v20 = v12 - 1;
                    if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v20, v1)) {
                        v12 = v10;
                        break
                    };
                    v12 = v20;
                    continue
                };
                if (v12 >= v2) {
                    break
                };
                let v21 = v12 + 1;
                if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v21, v1)) {
                    v12 = v10;
                    break
                };
                v12 = v21;
                continue
            };
            if (0x1::option::is_some<u32>(&arg5)) {
                let v22 = *0x1::option::borrow<u32>(&arg5);
                if (arg2 && v12 < v22 || !arg2 && v12 > v22) {
                    assert!(arg3, 431);
                    v12 = v10;
                    break
                };
            };
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::update_volatility_accumulator(&mut v14, &arg0.fee_params, v12);
            let v23 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::get_total_fee(&arg0.fee_params, &v14, v0);
            let v24 = v23;
            if (oracle_fee_fresh<T0, T1>(arg0, v0)) {
                v24 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::apply_oracle_distance_fee(&arg0.fee_params, v23, arg0.oracle_bin_id, v12, arg2, discount_fresh<T0, T1>(arg0, v0));
            };
            let v25 = if (arg3) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::quote_exact_in(v5, v19, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::price<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v12)), v24, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::fee_precision(), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::protocol_share(&arg0.fee_params), arg2)
            } else {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::quote_exact_out(v5, v19, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::price<T0, T1>(0x2::table::borrow<u32, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::Bin<T0, T1>>(&arg0.bins, v12)), v24, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee::fee_precision(), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fee_params::protocol_share(&arg0.fee_params), arg2)
            };
            let v26 = v25;
            let v27 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_consumed(&v26);
            let v28 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_out(&v26);
            if (v27 == 0 && v28 == 0) {
                v12 = v10;
                break
            };
            v6 = v6 + v27;
            v7 = v7 + v28;
            v8 = v8 + 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_protocol_fee(&v26) + 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_lp_fee(&v26);
            v9 = v9 + 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::result_protocol_fee(&v26);
            let v29 = if (arg3) {
                v27
            } else {
                v28
            };
            v5 = v5 - v29;
            v10 = v12;
            if (v28 == v19) {
                if (arg2) {
                    if (v12 == 0) {
                        break
                    };
                    let v30 = v12 - 1;
                    if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v30, v1)) {
                        break
                    };
                    v12 = v30;
                    continue
                };
                if (v12 >= v2) {
                    break
                };
                let v31 = v12 + 1;
                if (!0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::bin::is_priceable(v31, v1)) {
                    break
                };
                v12 = v31;
                continue
            };
            v5 = 0;
        };
        if (!arg3 && v5 > 0) {
            abort 412
        };
        let v32 = if (v10 >= v12) {
            v10 - v12
        } else {
            v12 - v10
        };
        let v33 = if (arg3) {
            arg1 - v6
        } else {
            0
        };
        SwapQuote{
            consumed_in         : v6,
            refund_in           : v33,
            amount_out          : v7,
            total_fee           : v8,
            protocol_fee        : v9,
            bins_crossed        : v32,
            final_active_bin_id : v12,
        }
    }

    public fun simulate_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u32>, arg6: &0x2::clock::Clock) : SwapQuote {
        simulate_core<T0, T1>(arg0, arg3, arg1, arg2, arg4, arg5, arg6)
    }

    public fun swap_no_lending<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u32>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg1;
        let v1 = &mut arg2;
        let (v2, v3, v4, v5, _) = run_idle_swap<T0, T1>(arg0, v0, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        complete_swap<T0, T1>(arg0, arg1, arg2, v3, v4, arg3, v2, v5, 0x2::tx_context::sender(arg10))
    }

    public fun swap_sui_x<T0>(arg0: &mut Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u32>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = open_swap<0x2::sui::SUI, T0>(arg0, arg1, &arg3, &arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v3 = recall_output_sui_x<T0>(arg0, arg1, arg2, v1, v0, arg11, arg12);
        finish_swap<0x2::sui::SUI, T0>(arg0, arg3, arg4, v3, v2, v1, 0x2::tx_context::sender(arg12))
    }

    public fun swap_sui_x_with_partner<T0>(arg0: &mut Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<T0>, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u32>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = open_swap<0x2::sui::SUI, T0>(arg0, arg1, &arg4, &arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v3 = recall_output_sui_x<T0>(arg0, arg1, arg3, v1, v0, arg12, arg13);
        finish_swap_partner<0x2::sui::SUI, T0>(arg0, arg2, arg4, arg5, v3, v2, v1, 0x2::tx_context::sender(arg13))
    }

    public fun swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u32>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (arg5) {
            assert_not_sui<T1>();
        } else {
            assert_not_sui<T0>();
        };
        let (v0, v1, v2) = open_swap<T0, T1>(arg0, arg1, &arg3, &arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v3 = recall_output<T0, T1>(arg0, arg1, v1, v0, arg11, arg12);
        finish_swap_partner<T0, T1>(arg0, arg2, arg3, arg4, v3, v2, v1, 0x2::tx_context::sender(arg12))
    }

    public fun swap_with_partner_no_lending<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u32>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg2;
        let v1 = &mut arg3;
        let (v2, v3, v4, v5, v6) = run_idle_swap<T0, T1>(arg0, v0, v1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        complete_swap_partner<T0, T1>(arg0, arg1, arg2, arg3, v3, v4, arg4, v2, v5, v6, 0x2::tx_context::sender(arg11))
    }

    fun sync_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::is_initialized(&arg0.lending) && !perms_bypass_venue(&arg0.permissions)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::sync<T0, T1>(&mut arg0.lending, &mut arg0.custody, arg1, arg2, arg3);
        };
        finish_sync<T0, T1>(arg0);
    }

    public fun total_backing_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::backing_u128_x<T0, T1>(&arg0.custody)
    }

    public fun total_backing_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::backing_u128_y<T0, T1>(&arg0.custody)
    }

    fun total_reserve_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(&arg0.custody)
    }

    fun total_reserve_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(&arg0.custody)
    }

    entry fun unpause<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Pool<T0, T1>) {
        assert_version<T0, T1>(arg1);
        assert_not_flash_active<T0, T1>(arg1);
        arg1.paused = false;
        let v0 = PoolUnpausedEvent{pool_id: 0x2::object::id<Pool<T0, T1>>(arg1)};
        0x2::event::emit<PoolUnpausedEvent>(v0);
    }

    public fun valuation_is_provisional<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        let (v0, v1) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending::pending_burn(&arg0.lending);
        v0 > 0 || v1 > 0
    }

    // decompiled from Move bytecode v7
}

