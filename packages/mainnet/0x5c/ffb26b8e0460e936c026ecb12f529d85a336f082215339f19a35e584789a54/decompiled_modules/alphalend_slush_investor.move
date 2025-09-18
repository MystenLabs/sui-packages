module 0x5cffb26b8e0460e936c026ecb12f529d85a336f082215339f19a35e584789a54::alphalend_slush_investor {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        alphalend_position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        minimum_swap_amount: u64,
        market_id: u64,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        location: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        fee_collected: u64,
        location: u64,
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, v1, arg2), arg2, arg3)));
        };
        let v3 = collect_reward<T0, T0>(arg0, arg1, arg2, arg3);
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v3));
        let v4 = RewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v4);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>())));
        };
        let v5 = get_total_invested<T0>(arg0, arg1, arg2);
        let v6 = AutoCompoundingEvent{
            investor_id     : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount : 0x2::balance::value<T0>(&v2),
            total_amount    : v5,
            fee_collected   : 0,
            location        : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v6);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, 0x2::coin::from_balance<T0>(v2, arg3), arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg1, arg2);
    }

    fun collect_reward<T0, T1>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T1>(arg1, arg0.market_id, &arg0.alphalend_position_cap, arg2, arg3);
        let v2 = v0;
        0x2::coin::join<T1>(&mut v2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg1, v1, arg2, arg3));
        v2
    }

    public(friend) fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg1, arg6);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(&mut v1, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>())));
        };
        let v2 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true) {
            0x2::balance::join<T2>(&mut v2, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())));
        };
        if (arg4) {
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(collect_reward<T0, T1>(arg0, arg1, arg6, arg7)));
            let v3 = 0x2::balance::value<T1>(&v1);
            if (v3 >= arg0.minimum_swap_amount && arg5) {
                let (v4, _) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg6, arg3, arg2, v1, 0x2::balance::zero<T2>(), true, true, v3, 0, v4);
                let v8 = v6;
                assert!(0x2::balance::value<T1>(&v8) == 0, 2000);
                0x2::balance::destroy_zero<T1>(v8);
                0x2::balance::join<T2>(&mut v2, v7);
                update_free_rewards<T0, T2>(arg0, v2);
            } else {
                update_free_rewards<T0, T1>(arg0, v1);
                update_free_rewards<T0, T2>(arg0, v2);
            };
        } else {
            0x2::balance::join<T2>(&mut v2, 0x2::coin::into_balance<T2>(collect_reward<T0, T2>(arg0, arg1, arg6, arg7)));
            let v9 = 0x2::balance::value<T2>(&v2);
            if (v9 >= arg0.minimum_swap_amount && arg5) {
                let (_, v11) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg6, arg3, arg2, 0x2::balance::zero<T1>(), v2, false, true, v9, 0, v11);
                let v14 = v13;
                assert!(0x2::balance::value<T2>(&v14) == 0, 2001);
                0x2::balance::destroy_zero<T2>(v14);
                0x2::balance::join<T1>(&mut v1, v12);
                update_free_rewards<T0, T1>(arg0, v1);
            } else {
                update_free_rewards<T0, T2>(arg0, v2);
                update_free_rewards<T0, T1>(arg0, v1);
            };
        };
    }

    public(friend) fun create_investor<T0>(arg0: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Investor<T0> {
        Investor<T0>{
            id                     : 0x2::object::new(arg3),
            alphalend_position_cap : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position_for_partner(arg1, arg0, 0, arg3),
            free_rewards           : 0x2::bag::new(arg3),
            tokensDeposited        : 0,
            minimum_swap_amount    : 200000,
            market_id              : arg2,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, arg2, arg3, arg4);
        arg0.tokensDeposited = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg3) as u64);
    }

    public(friend) fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = if (v0 >= 100 && v0 <= 500) {
            v1 * 999499874 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 997496867 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 992471662 / 1000000000
        } else {
            v1 * 987420882 / 1000000000
        };
        let v3 = if (v0 >= 100 && v0 <= 500) {
            v1 * 1000499875 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 1002496882 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 1007472083 / 1000000000
        } else {
            v1 * 1012422836 / 1000000000
        };
        (v2, v3)
    }

    public(friend) fun get_total_invested<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.tokensDeposited == 0) {
            return 0
        };
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg2) as u64)
    }

    public(friend) fun has_unclaimed_rewards<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg1, &arg0.alphalend_position_cap, arg2);
        0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&v0) > 0
    }

    public(friend) fun recast_balance_type<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T2> {
        update_free_rewards<T0, T1>(arg0, arg1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true, 13906834663969652735);
        0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()), 0x2::balance::value<T1>(&arg1))
    }

    public(friend) fun set_minimum_swap_amount<T0>(arg0: &mut Investor<T0>, arg1: u64) {
        arg0.minimum_swap_amount = arg1;
    }

    public(friend) fun split_external_reward<T0>(arg0: &mut Investor<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock) {
        let v0 = get_total_invested<T0>(arg0, arg3, arg4);
        let v1 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0 - arg0.tokensDeposited)), arg2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensDeposited)));
        let v2 = RewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
            location  : 1,
        };
        0x2::event::emit<RewardEvent>(v2);
        update_free_rewards<T0, T0>(arg0, 0x2::balance::split<T0>(arg1, v1));
    }

    public(friend) fun update_free_rewards<T0, T1>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>(), arg1);
        };
    }

    public(friend) fun withdraw_from_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = get_total_invested<T0>(arg0, arg1, arg4);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, (((arg2 as u256) * (v0 as u256) / (arg3 as u256)) as u64), arg4), arg4, arg5);
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg1, arg4);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v6
}

