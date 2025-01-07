module 0x6bbb1e48e434578d373dd1a88cb0ea449cca4421aed301203ceca8e9a084eb26::memepad {
    struct MemeLaunchPad has key {
        id: 0x2::object::UID,
        meme_cap: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MemepadCapability,
        master_key: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::GameMasterKey,
        curve: CurveParams,
        admin_fee_pct: u64,
        is_live: bool,
        no_bee_launch_enabled: bool,
        pool_init_fee: u64,
        mean_fdv_increase_per_step: u64,
        market_cap_for_migration: u64,
        meme_supply_dist: MemeSupplyConfig,
        amm_pool_config: LaunchConfig,
        supported_memes: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct MemeSupplyConfig has store {
        bonding_curve_pct: u64,
        pool_amt_pct: u64,
        bribes_amt_pct: u64,
        bee_amt_pct: u64,
    }

    struct LaunchConfig has store {
        init_params: vector<u64>,
        weights: vector<u64>,
    }

    struct MemePool<phantom T0> has key {
        id: 0x2::object::UID,
        bee_version: u64,
        total_meme_supply: u64,
        init_timestamp: u64,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        fees_collected: 0x2::balance::Balance<0x2::sui::SUI>,
        curve: CurveParams,
        amm_pool_type: 0x1::ascii::String,
        cur_step: u64,
        meme_available: 0x2::balance::Balance<T0>,
        sui_available: 0x2::balance::Balance<0x2::sui::SUI>,
        cur_market_cap: u64,
        meme_for_pool: 0x2::balance::Balance<T0>,
        burn_tax: u64,
        policy_cap: 0x1::option::Option<0x2::token::TokenPolicyCap<T0>>,
        bee_bribes: BeeBribes<T0>,
        mean_fdv_increase_per_step: u64,
        market_cap_for_migration: u64,
        has_migrated: bool,
        version: u64,
    }

    struct BeeBribes<phantom T0> has store {
        memes_bribe: 0x2::balance::Balance<T0>,
        per_cycle_bribe: u64,
        latest_cycle: u64,
        for_bee_per_cycle: u64,
        bee_share_claimable: u64,
    }

    struct CurveParams has copy, store {
        a: u64,
        b: u64,
        swap_fee_bps: u64,
    }

    struct MemesByBee has store, key {
        id: 0x2::object::UID,
        memes: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
    }

    struct MemeCustody<phantom T0> has store, key {
        id: 0x2::object::UID,
        meme_balance: 0x2::balance::Balance<T0>,
    }

    struct Consumption has drop {
        dummy_field: bool,
    }

    struct ConsumptionCondition has drop, store {
        percent: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct NewMemePoolCreated has copy, drop {
        meme_pool_addr: address,
        amm_pool_type: 0x1::ascii::String,
        meme_identifier: 0x1::ascii::String,
        init_timestamp: u64,
        burn_tax: u64,
        total_meme_supply: u64,
        meme_tradable_amt: u64,
        meme_for_pool_amt: u64,
        memes_for_bee_amt: u64,
        meme_for_bribes_amt: u64,
        bribe_cycles: u64,
        bee_version: u64,
        trainer_addr: address,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        mean_fdv_increase_per_step: u64,
        market_cap_for_migration: u64,
    }

    struct LiquidityMigratedToAmmPool has copy, drop {
        meme_pool_addr: address,
        meme_identifier: 0x1::ascii::String,
        meme_available_amt: u64,
        sui_available_amt: u64,
    }

    struct BribesAddedForEmissions has copy, drop {
        meme_pool_addr: address,
        meme_identifier: 0x1::ascii::String,
        latest_cycle: u64,
        remaining_meme_for_bribes: u64,
        bee_share_claimable: u64,
    }

    struct MemePoolFeeClaimed has copy, drop {
        meme_pool_addr: address,
        admin_fee_amt: u64,
        meme_pool_fee_amt: u64,
    }

    struct MemesBought has copy, drop {
        meme_pool_addr: address,
        sui_spent: u64,
        memes_bought: u64,
        protocol_fees: u64,
        clock: u64,
        cur_step: u64,
        cur_market_cap: u64,
        cur_1m_price: u64,
    }

    struct MemesSold has copy, drop {
        meme_pool_addr: address,
        memes_sold: u64,
        sold_for_sui: u64,
        protocol_fees: u64,
        clock: u64,
        cur_step: u64,
        cur_market_cap: u64,
        cur_1m_price: u64,
    }

    struct MemePoolMigrationPossible has copy, drop {
        meme_pool_addr: address,
        meme_identifier: 0x1::ascii::String,
        cur_market_cap: u64,
        cur_step: u64,
        cur_1m_price: u64,
    }

    struct MemeBurnt has copy, drop {
        identifier: 0x1::ascii::String,
        meme_to_burn_amt: u64,
    }

    public fun swap_meme_with_tax<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::token::Token<T0>, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_migrated, 3550);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v1 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, arg7, arg8, arg11);
        let (v2, v3) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::swap_meme_with_tax<0x2::sui::SUI, T0, T1>(arg0, &arg1.treasury_cap, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), arg6, 0x2::coin::into_balance<T0>(v1), arg9, arg10);
        let v4 = v2;
        0x2::balance::join<0x2::sui::SUI>(&mut v4, v0);
        let v5 = 0x2::tx_context::sender(arg11);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v3, v5, arg11);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg11), arg11);
    }

    public entry fun add_bribe_for_emissions<T0, T1>(arg0: &MemeLaunchPad, arg1: &mut MemePool<T1>, arg2: &mut 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::DragonFood, arg3: &mut 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::PoolHive<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 3548);
        assert!(arg1.has_migrated && 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_available) == 0, 3550);
        0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::update_food_cycle(arg2, arg5);
        let (v0, _, _) = 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::get_ongoing_cycle(arg2);
        let v3 = 0;
        while (0x2::balance::value<T1>(&arg1.bee_bribes.memes_bribe) > 0 && v3 < arg4) {
            let v4 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u64(v0 + 1, arg1.bee_bribes.latest_cycle + 1);
            let v5 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(0x2::balance::value<T1>(&arg1.bee_bribes.memes_bribe), arg1.bee_bribes.per_cycle_bribe);
            let v6 = v5 / 2;
            0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::add_bribe_for_emissions<T0, T1>(arg2, arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.bee_bribes.memes_bribe, v5), arg5), v4, v6, v5 - v6, arg5);
            arg1.bee_bribes.latest_cycle = v4;
            arg1.bee_bribes.bee_share_claimable = arg1.bee_bribes.bee_share_claimable + arg1.bee_bribes.for_bee_per_cycle;
            v3 = v3 + 1;
        };
        if (arg1.burn_tax > 0) {
            0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::mark_bribe_as_meme_token<T0, T1>(&arg0.meme_cap, arg3);
        };
        let v7 = BribesAddedForEmissions{
            meme_pool_addr            : 0x2::object::uid_to_address(&arg1.id),
            meme_identifier           : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            latest_cycle              : arg1.bee_bribes.latest_cycle,
            remaining_meme_for_bribes : 0x2::balance::value<T1>(&arg1.bee_bribes.memes_bribe),
            bee_share_claimable       : arg1.bee_bribes.bee_share_claimable,
        };
        0x2::event::emit<BribesAddedForEmissions>(v7);
    }

    public entry fun claim_voting_rewards_two_pool_with_burn_tax<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T2>, arg2: &mut 0x2::token::TokenPolicy<T2>, arg3: &mut 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::DragonFood, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg5: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg6: &mut 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::PoolHive<T0>, arg7: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::claim_voting_rewards_two_pool_with_burn_tax<T0, T1, T2>(arg0, arg3, &arg1.treasury_cap, arg4, arg5, arg6, arg7, arg8);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg8), arg8);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg8), arg8);
        let v3 = 0x2::tx_context::sender(arg8);
        transfer_meme_balance_as_token<T2>(arg1, arg2, v2, v3, arg8);
    }

    public fun add_liquidity_to_amm_pool_burn_tax<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: u64) : 0x2::balance::Balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>> {
        assert!(arg1.has_migrated, 3550);
        0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::add_liquidity<0x2::sui::SUI, T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun buy_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg1.burn_tax == 0, 3550);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let (v1, v2) = internal_buy_memes<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        (v1, v0)
    }

    public fun calculate_marketcap(arg0: u64, arg1: u64) : u64 {
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg1 / 1000000 / 1000000) as u256), (arg0 as u256), (1000000000 as u256)) as u64)
    }

    public fun claim_meme_for_bee<T0>(arg0: &MemeLaunchPad, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg2: &mut MemePool<T0>, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 3548);
        assert!(arg2.bee_version == arg5, 3556);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::does_trainer_owns_bee(arg4, arg5), 3557);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_withdraw_bee(&arg0.master_key, arg1, arg4, arg5);
        let v2 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::borrow_store_from_bee<MemesByBee>(&arg0.master_key, &mut v1);
        let v3 = 0x2::dynamic_object_field::remove<0x1::ascii::String, MemeCustody<T0>>(&mut v2.id, v0);
        let v4 = 0x2::balance::split<T0>(&mut v3.meme_balance, arg2.bee_bribes.bee_share_claimable);
        arg2.bee_bribes.bee_share_claimable = 0;
        if (0x2::balance::value<T0>(&v3.meme_balance) == 0) {
            0x2::linked_table::remove<0x1::ascii::String, address>(&mut v2.memes, v0);
            let MemeCustody {
                id           : v5,
                meme_balance : v6,
            } = v3;
            0x2::object::delete(v5);
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::dynamic_object_field::add<0x1::ascii::String, MemeCustody<T0>>(&mut v2.id, v0, v3);
        };
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_deposit_bee(&arg0.master_key, arg1, arg4, v1);
        if (arg2.burn_tax > 0) {
            let v7 = 0x2::tx_context::sender(arg6);
            transfer_meme_balance_as_token<T0>(arg2, arg3, v4, v7, arg6);
        } else {
            0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v4, 0x2::tx_context::sender(arg6), arg6);
        };
    }

    public fun claim_meme_pool_fee<T0>(arg0: &MemeLaunchPad, arg1: &mut MemePool<T0>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::FeeCollector<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fees_collected);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0) * arg0.admin_fee_pct / 100;
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::add_to_admin_fee(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v1));
        let v2 = MemePoolFeeClaimed{
            meme_pool_addr    : 0x2::object::uid_to_address(&arg1.id),
            admin_fee_amt     : v1,
            meme_pool_fee_amt : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<MemePoolFeeClaimed>(v2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg3, v0);
    }

    public fun compute_meme_to_buy<T0>(arg0: &MemePool<T0>, arg1: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.cur_step;
        let v1 = arg0.cur_market_cap;
        let v2 = 0;
        let v3 = 0x2::balance::value<T0>(&arg0.meme_available);
        let v4 = 0;
        let v5 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1 as u256), (arg0.curve.swap_fee_bps as u256), (10000 as u256)) as u64);
        let v6 = v5;
        arg1 = arg1 - v5;
        while (arg1 > 0 && v3 >= v4) {
            let v7 = compute_next_step_price((arg0.curve.a as u256), (arg0.curve.b as u256), v0, arg0.mean_fdv_increase_per_step, v1, arg0.total_meme_supply, true);
            v2 = v7;
            v1 = calculate_marketcap(v7, arg0.total_meme_supply);
            if (arg1 >= v7) {
                v4 = v4 + 1000000 * 1000000;
                arg1 = arg1 - v7;
                v0 = v0 + 1;
                continue
            };
            v4 = v4 + (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1 as u256), ((1000000 * 1000000) as u256), (v7 as u256)) as u64);
            arg1 = 0;
        };
        if (arg1 > 0) {
            let v8 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v5 as u256), (arg1 as u256), ((arg1 + v5) as u256)) as u64);
            v6 = v5 - v8;
            arg1 = arg1 + v8;
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(v4, v3), v6, arg1, v0, v1, v2)
    }

    public fun compute_next_step_price(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u64 {
        if (arg2 > 1500) {
            arg2 = 1500 / 2;
        };
        if (arg4 > 0) {
            let v0 = arg3 * (1500 - arg2) / 1500;
            let v1 = if (arg6) {
                arg4 + v0
            } else if (arg4 > v0) {
                arg4 - v0
            } else {
                0
            };
            return v1 * (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((1000000000 as u256) * (1000000 as u256), (1000000 as u256), (arg5 as u256)) as u64)
        };
        (arg0 as u64)
    }

    public fun compute_sui_to_return_for_memes<T0>(arg0: &MemePool<T0>, arg1: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.cur_step;
        let v1 = arg0.cur_market_cap;
        let v2 = 0;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_available);
        let v4 = 0;
        while (arg1 > 0 && v3 >= v4) {
            let v5 = compute_next_step_price((arg0.curve.a as u256), (arg0.curve.b as u256), v0, arg0.mean_fdv_increase_per_step, v1, arg0.total_meme_supply, false);
            v2 = v5;
            v1 = calculate_marketcap(v5, arg0.total_meme_supply);
            if (arg1 >= 1000000 * 1000000) {
                v4 = v4 + v5;
                arg1 = arg1 - 1000000 * 1000000;
                v0 = v0 - 1;
                continue
            };
            v4 = v4 + (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1 as u256), (v5 as u256), ((1000000 * 1000000) as u256)) as u64);
            arg1 = 0;
        };
        let v6 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(v4, v3);
        let v7 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v6 as u256), (arg0.curve.swap_fee_bps as u256), (10000 as u256)) as u64);
        (v6 - v7, v7, arg1, v0, v1, v2)
    }

    public entry fun entry_add_liquidity_to_amm_pool_burn_tax<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::token::Token<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v1 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, arg6, arg7, arg9);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg9), arg9);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>(add_liquidity_to_amm_pool_burn_tax<T0, T1>(arg0, arg1, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), 0x2::coin::into_balance<T0>(v1), arg8), 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun entry_buy_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_memes<T0>(arg0, arg1, arg2, arg3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun entry_buy_memes_slippage<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_memes<T0>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) >= arg4, 3558);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v2, 0x2::tx_context::sender(arg5), arg5);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun entry_buy_memes_with_tax<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let (v1, v2) = internal_buy_memes<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        let v3 = 0x2::tx_context::sender(arg5);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v1, v3, arg5);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun entry_buy_memes_with_tax_slippage<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let (v1, v2) = internal_buy_memes<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg4));
        let v3 = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        assert!(0x2::balance::value<T0>(&v3) >= arg5, 3558);
        let v4 = 0x2::tx_context::sender(arg6);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v3, v4, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_remove_liquidity_to_amm_pool_burn_tax<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: 0x2::coin::Coin<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>(arg4);
        let (v1, v2) = remove_liquidity_from_amm_pool_burn_tax<T0, T1>(arg0, arg1, arg2, arg3, 0x2::balance::split<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>(&mut v0, arg5), arg6, arg7, arg8, arg9);
        0x2::balance::join<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>(&mut v0, v1);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg9), arg9);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>(v0, 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun entry_sell_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_memes<T0>(arg0, arg1, arg2, arg3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg4), arg4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun entry_sell_memes_slippage<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_memes<T0>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) >= arg4, 3558);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg5), arg5);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v2, 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun entry_sell_memes_with_tax<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::coin::into_balance<T0>(v0);
        let (v2, v3) = internal_sell_memes<T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v1, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(arg4, 0x2::balance::value<T0>(&v1))));
        0x2::balance::join<T0>(&mut v1, v3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg5), arg5);
        let v4 = 0x2::tx_context::sender(arg5);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v1, v4, arg5);
    }

    public entry fun entry_sell_memes_with_tax_slippage<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, arg3, arg4, arg6);
        let v1 = 0x2::coin::into_balance<T0>(v0);
        let (v2, v3) = internal_sell_memes<T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v1, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(arg4, 0x2::balance::value<T0>(&v1))));
        let v4 = v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v4) >= arg5, 3558);
        0x2::balance::join<T0>(&mut v1, v3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg6), arg6);
        let v5 = 0x2::tx_context::sender(arg6);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v1, v5, arg6);
    }

    public entry fun entry_sell_memes_with_tax_slippage_wtht_drop<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = &mut arg3;
        let v1 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, v0, arg4, arg6);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let (v3, v4) = internal_sell_memes<T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v2, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(arg4, 0x2::balance::value<T0>(&v2))));
        let v5 = v3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v5) >= arg5, 3558);
        0x2::balance::join<T0>(&mut v2, v4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v5, 0x2::tx_context::sender(arg6), arg6);
        let v6 = 0x2::tx_context::sender(arg6);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v2, v6, arg6);
        let v7 = 0x2::tx_context::sender(arg6);
        transfer_meme_token_wtht_drop<T0>(arg1, arg2, arg3, v7, arg6);
    }

    public entry fun entry_sell_memes_with_tax_wtht_drop<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_tax > 0, 3550);
        let v0 = &mut arg3;
        let v1 = unwrap_meme_tokens_to_coins<T0>(arg1, arg2, v0, arg4, arg5);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let (v3, v4) = internal_sell_memes<T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v2, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::min_u64(arg4, 0x2::balance::value<T0>(&v2))));
        0x2::balance::join<T0>(&mut v2, v4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg5), arg5);
        let v5 = 0x2::tx_context::sender(arg5);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v2, v5, arg5);
        let v6 = 0x2::tx_context::sender(arg5);
        transfer_meme_token_wtht_drop<T0>(arg1, arg2, arg3, v6, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_meme_launchpad(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MemepadCapability, arg2: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::GameMasterKey, arg3: bool, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchConfig{
            init_params : arg4,
            weights     : arg5,
        };
        let v1 = CurveParams{
            a            : 700000000,
            b            : 240000,
            swap_fee_bps : 30,
        };
        let v2 = MemeSupplyConfig{
            bonding_curve_pct : 40,
            pool_amt_pct      : 30,
            bribes_amt_pct    : 20,
            bee_amt_pct       : 10,
        };
        let v3 = MemeLaunchPad{
            id                         : 0x2::object::new(arg6),
            meme_cap                   : arg1,
            master_key                 : arg2,
            curve                      : v1,
            admin_fee_pct              : 50,
            is_live                    : arg3,
            no_bee_launch_enabled      : false,
            pool_init_fee              : 15000000000,
            mean_fdv_increase_per_step : 69,
            market_cap_for_migration   : 15000,
            meme_supply_dist           : v2,
            amm_pool_config            : v0,
            supported_memes            : 0x2::linked_table::new<0x1::ascii::String, address>(arg6),
            bag                        : 0x2::bag::new(arg6),
            version                    : 0,
        };
        0x2::transfer::share_object<MemeLaunchPad>(v3);
    }

    public entry fun init_meme_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemeLaunchPad, arg2: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::PoolRegistry, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg5: 0x2::coin::TreasuryCap<T0>, arg6: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::FeeCollector<0x2::sui::SUI>, arg7: &mut 0x2::coin::CoinMetadata<T0>, arg8: 0x1::string::String, arg9: 0x1::ascii::String, arg10: 0x1::string::String, arg11: 0x1::ascii::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg15: u64, arg16: 0x2::coin::Coin<0x2::sui::SUI>, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 3548);
        assert!(0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::is_weighted<T1>(), 3554);
        assert!(arg1.is_live, 3550);
        assert!(arg17 <= 10, 3546);
        assert!(arg18 > 0 && arg18 <= 100, 3553);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v2, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg14);
        0x2::coin::update_name<T0>(&arg5, arg7, arg8);
        0x2::coin::update_symbol<T0>(&arg5, arg7, arg9);
        0x2::coin::update_description<T0>(&arg5, arg7, arg10);
        0x2::coin::update_icon_url<T0>(&arg5, arg7, arg11);
        let v5 = 0x2::object::new(arg19);
        let v6 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg5, 1000000000000000, arg19));
        let v7 = 1000000000000000 * arg1.meme_supply_dist.bonding_curve_pct / 100;
        let v8 = 1000000000000000 * arg1.meme_supply_dist.pool_amt_pct / 100;
        let v9 = 1000000000000000 * arg1.meme_supply_dist.bee_amt_pct / 100;
        let v10 = v9;
        let v11 = 1000000000000000 * arg1.meme_supply_dist.bribes_amt_pct / 100;
        let v12 = v11;
        let v13 = arg1.pool_init_fee;
        if (arg15 > 0) {
            v13 = 0;
            let v14 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::launch_meme_pool_via_bee(arg0, &arg1.meme_cap, arg4, arg14, arg15, v0);
            let (_, v16, _, _, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_master_key_info(&arg1.master_key);
            if (!0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::store_exists_for_bee(&v14, v16)) {
                let v21 = MemesByBee{
                    id    : 0x2::object::new(arg19),
                    memes : 0x2::linked_table::new<0x1::ascii::String, address>(arg19),
                };
                0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::add_store_to_bee<MemesByBee>(&arg1.master_key, &mut v14, 0x2::object::uid_to_address(&v21.id), v21);
            };
            let v22 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::borrow_store_from_bee<MemesByBee>(&arg1.master_key, &mut v14);
            0x2::linked_table::push_back<0x1::ascii::String, address>(&mut v22.memes, v0, 0x2::object::uid_to_address(&v5));
            let v23 = MemeCustody<T0>{
                id           : 0x2::object::new(arg19),
                meme_balance : 0x2::balance::split<T0>(&mut v6, v9),
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, MemeCustody<T0>>(&mut v22.id, v0, v23);
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_deposit_bee(&arg1.master_key, arg4, arg14, v14);
        } else {
            v12 = v11 + v9;
            v10 = 0;
            assert!(arg1.no_bee_launch_enabled, 3551);
        };
        let v24 = 0x2::coin::into_balance<0x2::sui::SUI>(arg16);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg6, 0x2::balance::split<0x2::sui::SUI>(&mut v24, v13));
        let v25 = 0x1::option::none<0x2::token::TokenPolicyCap<T0>>();
        let v26 = false;
        if (arg17 > 0) {
            v26 = true;
            let (v27, v28) = 0x2::token::new_policy<T0>(&arg5, arg19);
            let v29 = v28;
            let v30 = v27;
            let v31 = &mut v30;
            set_rules<T0>(v31, &v29, arg17, arg19);
            0x2::token::share_policy<T0>(v30);
            0x1::option::fill<0x2::token::TokenPolicyCap<T0>>(&mut v25, v29);
        };
        let v32 = BeeBribes<T0>{
            memes_bribe         : v6,
            per_cycle_bribe     : v12 / arg18,
            latest_cycle        : 0,
            for_bee_per_cycle   : v10 / arg18,
            bee_share_claimable : 0,
        };
        let v33 = MemePool<T0>{
            id                         : v5,
            bee_version                : arg15,
            total_meme_supply          : 1000000000000000,
            init_timestamp             : 0x2::clock::timestamp_ms(arg0),
            twitter                    : arg12,
            telegram                   : arg13,
            treasury_cap               : arg5,
            fees_collected             : 0x2::balance::zero<0x2::sui::SUI>(),
            curve                      : arg1.curve,
            amm_pool_type              : v1,
            cur_step                   : 0,
            meme_available             : 0x2::balance::split<T0>(&mut v6, v7),
            sui_available              : 0x2::balance::zero<0x2::sui::SUI>(),
            cur_market_cap             : 0,
            meme_for_pool              : 0x2::balance::split<T0>(&mut v6, v8),
            burn_tax                   : arg17,
            policy_cap                 : v25,
            bee_bribes                 : v32,
            mean_fdv_increase_per_step : arg1.mean_fdv_increase_per_step,
            market_cap_for_migration   : arg1.market_cap_for_migration,
            has_migrated               : false,
            version                    : 0,
        };
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.supported_memes, v0, 0x2::object::uid_to_address(&v33.id));
        0x2::balance::join<0x2::sui::SUI>(&mut v24, 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::register_meme_pool<0x2::sui::SUI, T0, T1>(arg0, arg2, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v24, 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::get_kraft_fee(arg3)), arg6, arg7, arg1.amm_pool_config.init_params, 0x1::option::none<vector<u256>>(), 0x1::option::some<vector<u64>>(arg1.amm_pool_config.weights), v26, &v33.treasury_cap, arg19));
        let v34 = NewMemePoolCreated{
            meme_pool_addr             : 0x2::object::uid_to_address(&v33.id),
            amm_pool_type              : v1,
            meme_identifier            : v0,
            init_timestamp             : v33.init_timestamp,
            burn_tax                   : arg17,
            total_meme_supply          : 1000000000000000,
            meme_tradable_amt          : v7,
            meme_for_pool_amt          : v8,
            memes_for_bee_amt          : v10,
            meme_for_bribes_amt        : v12,
            bribe_cycles               : arg18,
            bee_version                : arg15,
            trainer_addr               : v2,
            twitter                    : arg12,
            telegram                   : arg13,
            mean_fdv_increase_per_step : v33.mean_fdv_increase_per_step,
            market_cap_for_migration   : v33.market_cap_for_migration,
        };
        0x2::event::emit<NewMemePoolCreated>(v34);
        0x2::transfer::share_object<MemePool<T0>>(v33);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v24, 0x2::tx_context::sender(arg19), arg19);
    }

    fun internal_buy_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg1.has_migrated, 3555);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let (v1, v2, v3, v4, v5, v6) = compute_meme_to_buy<T0>(arg1, v0);
        arg1.cur_step = v4;
        arg1.cur_market_cap = v5;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v0 - v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees_collected, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_available, v7);
        let v8 = MemesBought{
            meme_pool_addr : 0x2::object::uid_to_address(&arg1.id),
            sui_spent      : v0 - v3,
            memes_bought   : v1,
            protocol_fees  : v2,
            clock          : 0x2::clock::timestamp_ms(arg0),
            cur_step       : v4,
            cur_market_cap : v5,
            cur_1m_price   : v6,
        };
        0x2::event::emit<MemesBought>(v8);
        if (arg1.has_migrated == false && v5 >= arg1.market_cap_for_migration) {
            arg1.has_migrated = true;
            let v9 = MemePoolMigrationPossible{
                meme_pool_addr  : 0x2::object::uid_to_address(&arg1.id),
                meme_identifier : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                cur_market_cap  : v5,
                cur_step        : v4,
                cur_1m_price    : v6,
            };
            0x2::event::emit<MemePoolMigrationPossible>(v9);
        };
        (0x2::balance::split<T0>(&mut arg1.meme_available, v1), arg2)
    }

    fun internal_sell_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        assert!(!arg1.has_migrated, 3555);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3, v4, v5, v6) = compute_sui_to_return_for_memes<T0>(arg1, v0);
        arg1.cur_step = v4;
        arg1.cur_market_cap = v5;
        0x2::balance::join<T0>(&mut arg1.meme_available, 0x2::balance::split<T0>(&mut arg2, v0));
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_available, v1 + v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees_collected, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v2));
        let v8 = MemesSold{
            meme_pool_addr : 0x2::object::uid_to_address(&arg1.id),
            memes_sold     : v0 - v3,
            sold_for_sui   : v1,
            protocol_fees  : v2,
            clock          : 0x2::clock::timestamp_ms(arg0),
            cur_step       : v4,
            cur_market_cap : v5,
            cur_1m_price   : v6,
        };
        0x2::event::emit<MemesSold>(v8);
        if (arg1.has_migrated == false && v5 >= arg1.market_cap_for_migration) {
            arg1.has_migrated = true;
            let v9 = MemePoolMigrationPossible{
                meme_pool_addr  : 0x2::object::uid_to_address(&arg1.id),
                meme_identifier : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                cur_market_cap  : v5,
                cur_step        : v4,
                cur_1m_price    : v6,
            };
            0x2::event::emit<MemePoolMigrationPossible>(v9);
        };
        (v7, arg2)
    }

    public entry fun migrate_liquidity_to_amm_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &MemeLaunchPad, arg2: &mut MemePool<T0>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>) {
        assert!(arg2.version == 0, 3548);
        assert!(arg2.has_migrated && 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_available) > 0, 3550);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg2.meme_available);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg2.meme_for_pool));
        0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::dangerous_burn_lp_coins<0x2::sui::SUI, T0, T1>(arg3, 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::add_liquidity<0x2::sui::SUI, T0, T1>(arg0, arg3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.sui_available), v0, 0));
        let v1 = LiquidityMigratedToAmmPool{
            meme_pool_addr     : 0x2::object::uid_to_address(&arg2.id),
            meme_identifier    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            meme_available_amt : 0x2::balance::value<T0>(&v0),
            sui_available_amt  : 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_available),
        };
        0x2::event::emit<LiquidityMigratedToAmmPool>(v1);
    }

    public fun query_memes_balance_for_dragon_bee<T0>(arg0: &MemeLaunchPad, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg3: u64) : u64 {
        let v0 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_withdraw_bee(&arg0.master_key, arg1, arg2, arg3);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_deposit_bee(&arg0.master_key, arg1, arg2, v0);
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x1::ascii::String, MemeCustody<T0>>(&0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::borrow_store_from_bee<MemesByBee>(&arg0.master_key, &mut v0).id, 0x1::type_name::into_string(0x1::type_name::get<T0>())).meme_balance)
    }

    public fun query_memes_by_dragon_bee(arg0: &MemeLaunchPad, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg3: u64, arg4: 0x1::option::Option<0x1::ascii::String>) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_withdraw_bee(&arg0.master_key, arg1, arg2, arg3);
        let v3 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::borrow_store_from_bee<MemesByBee>(&arg0.master_key, &mut v2);
        let v4 = if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            arg4
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&v3.memes)
        };
        while (0x1::option::is_some<0x1::ascii::String>(&v4)) {
            let v5 = *0x1::option::borrow<0x1::ascii::String>(&v4);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&v3.memes, v5));
            v4 = *0x2::linked_table::next<0x1::ascii::String, address>(&v3.memes, v5);
        };
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::game_master_deposit_bee(&arg0.master_key, arg1, arg2, v2);
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&v3.memes))
    }

    public fun remove_liquidity_from_amm_pool_burn_tax<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: 0x2::balance::Balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<0x2::sui::SUI, T0, T1>>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg1.has_migrated, 3550);
        let (v0, v1, v2) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::remove_liquidity_burn_tax<0x2::sui::SUI, T0, T1>(arg0, &arg1.treasury_cap, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x2::tx_context::sender(arg8);
        transfer_meme_balance_as_token<T0>(arg1, arg2, v1, v3, arg8);
        (v2, v0)
    }

    public fun sell_memes<T0>(arg0: &0x2::clock::Clock, arg1: &mut MemePool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg1.burn_tax == 0, 3550);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2) = internal_sell_memes<T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3));
        0x2::balance::join<T0>(&mut v0, v2);
        (v0, v1)
    }

    fun set_consumption_pct<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Consumption>(arg0)) {
            let v0 = ConsumptionCondition{percent: arg2};
            let v1 = Consumption{dummy_field: false};
            0x2::token::add_rule_config<T0, Consumption, ConsumptionCondition>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Consumption{dummy_field: false};
            0x2::token::rule_config_mut<T0, Consumption, ConsumptionCondition>(v2, arg0, arg1).percent = arg2;
        };
    }

    public fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::transfer_action(), arg3);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::spend_action(), arg3);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::to_coin_action(), arg3);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::from_coin_action(), arg3);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::transfer_action(), arg2);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::to_coin_action(), arg2);
        set_consumption_pct<T0>(arg0, arg1, v0, arg3);
    }

    public fun switch_meme_launchpad(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut MemeLaunchPad, arg2: bool, arg3: bool) {
        arg1.is_live = arg2;
        arg1.no_bee_launch_enabled = arg3;
    }

    public fun transfer_meme_balance_as_token<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg2, arg4), arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v2;
        verify<T0>(arg1, v4, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v2, arg4);
        let v9 = &mut v3;
        transfer_meme_token<T0>(arg0, arg1, v9, 0x2::token::value<T0>(&v3), arg3, arg4);
        0x2::token::destroy_zero<T0>(v3);
    }

    public fun transfer_meme_token<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::token::Token<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::split<T0>(arg2, arg3, arg5);
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::transfer_action();
        let v3 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg1).percent, &v2) as u128), (100 as u128));
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(0x1::option::borrow<0x2::token::TokenPolicyCap<T0>>(&arg0.policy_cap), 0x2::token::transfer<T0>(v0, arg4, arg5), arg5);
        let v8 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg5), arg5);
        let v9 = &mut v8;
        verify<T0>(arg1, v9, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg1, v8, arg5);
        let v14 = MemeBurnt{
            identifier       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            meme_to_burn_amt : v3,
        };
        0x2::event::emit<MemeBurnt>(v14);
        0x2::token::flush<T0>(arg1, &mut arg0.treasury_cap, arg5);
        arg0.total_meme_supply = arg0.total_meme_supply - v3;
    }

    public fun transfer_meme_token_wtht_drop<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: 0x2::token::Token<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::token::value<T0>(&arg2) == 0) {
            0x2::token::destroy_zero<T0>(arg2);
        } else {
            let v0 = Consumption{dummy_field: false};
            let v1 = 0x2::token::transfer_action();
            let v2 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((0x2::token::value<T0>(&arg2) as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v0, arg1).percent, &v1) as u128), (100 as u128));
            let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(0x1::option::borrow<0x2::token::TokenPolicyCap<T0>>(&arg0.policy_cap), 0x2::token::transfer<T0>(arg2, arg3, arg4), arg4);
            let v7 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut arg2, v2, arg4), arg4);
            let v8 = &mut v7;
            verify<T0>(arg1, v8, arg4);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg1, v7, arg4);
            let v13 = MemeBurnt{
                identifier       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                meme_to_burn_amt : v2,
            };
            0x2::event::emit<MemeBurnt>(v13);
            0x2::token::flush<T0>(arg1, &mut arg0.treasury_cap, arg4);
            arg0.total_meme_supply = arg0.total_meme_supply - v2;
        };
    }

    fun unwrap_meme_tokens_to_coins<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::token::Token<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::split<T0>(arg2, arg3, arg4);
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::to_coin_action();
        let v3 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg1).percent, &v2) as u128), (100 as u128));
        let (v4, v5) = 0x2::token::to_coin<T0>(v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(0x1::option::borrow<0x2::token::TokenPolicyCap<T0>>(&arg0.policy_cap), v5, arg4);
        let v10 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg4), arg4);
        let v11 = &mut v10;
        verify<T0>(arg1, v11, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg1, v10, arg4);
        let v16 = MemeBurnt{
            identifier       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            meme_to_burn_amt : v3,
        };
        0x2::event::emit<MemeBurnt>(v16);
        0x2::token::flush<T0>(arg1, &mut arg0.treasury_cap, arg4);
        arg0.total_meme_supply = arg0.total_meme_supply - v3;
        v4
    }

    public fun update_launchpad_meme_supply_config(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut MemeLaunchPad, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 + arg3 + arg4 + arg5 == 100, 3552);
        arg1.meme_supply_dist.bonding_curve_pct = arg2;
        arg1.meme_supply_dist.pool_amt_pct = arg3;
        arg1.meme_supply_dist.bribes_amt_pct = arg4;
        arg1.meme_supply_dist.bee_amt_pct = arg5;
    }

    public fun update_launchpad_pool_init_config(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut MemeLaunchPad, arg2: vector<u64>, arg3: vector<u64>) {
        arg1.amm_pool_config.init_params = arg2;
        arg1.amm_pool_config.weights = arg3;
    }

    public fun update_meme_launchpad(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut MemeLaunchPad, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert!(arg8 <= 10000, 3544);
        if (arg6 > 0 && arg7 > 0) {
            arg1.curve.a = arg6;
            arg1.curve.b = arg7;
        };
        if (arg3 < 100) {
            arg1.admin_fee_pct = arg3;
        };
        if (arg8 > 0) {
            arg1.curve.swap_fee_bps = arg8;
        };
        if (arg2 > 0) {
            arg1.pool_init_fee = arg2;
        };
        if (arg4 > 0) {
            arg1.market_cap_for_migration = arg4;
        };
        if (arg5 > 0) {
            arg1.mean_fdv_increase_per_step = arg5;
        };
    }

    public fun update_meme_pool<T0>(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut MemePool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg6 <= 10000, 3544);
        if (arg4 > 0 && arg5 > 0) {
            arg1.curve.a = arg4;
            arg1.curve.b = arg5;
        };
        if (arg6 > 0) {
            arg1.curve.swap_fee_bps = arg6;
        };
        if (arg2 > 0) {
            arg1.market_cap_for_migration = arg2;
        };
        if (arg3 > 0) {
            arg1.mean_fdv_increase_per_step = arg3;
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Consumption>(arg0)) {
            let v0 = Consumption{dummy_field: false};
            0x2::token::add_approval<T0, Consumption>(v0, arg1, arg2);
            return
        };
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg0);
        let v3 = 0x2::token::action<T0>(arg1);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v2.percent, &v3)) {
            let v4 = Consumption{dummy_field: false};
            0x2::token::add_approval<T0, Consumption>(v4, arg1, arg2);
            return
        };
        let v5 = 0x2::token::action<T0>(arg1);
        assert!(*0x2::vec_map::get<0x1::string::String, u64>(&v2.percent, &v5) == 0, 3547);
        let v6 = Consumption{dummy_field: false};
        0x2::token::add_approval<T0, Consumption>(v6, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

