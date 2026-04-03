module 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_locked_loop_investor {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        alphalend_position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        free_rewards: 0x2::bag::Bag,
        tokens_deposited_as_collateral: u64,
        t_debt: u64,
        allowed_coin_types_for_swap: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>,
        current_debt_to_supply_ratio: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_borrow_percentage: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        market_id: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        cur_total_debt: u64,
        accrued_borrow_interest: u64,
        fee_collected: u64,
    }

    struct RepayEvent has copy, drop {
        investor_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun add_or_remove_coin_type_for_swap<T0>(arg0: &mut Investor<T0>, arg1: 0x1::type_name::TypeName, arg2: u8) {
        if (arg2 == 1 && !0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, arg1, true);
        } else if (arg2 == 0 && 0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, &arg1);
        };
    }

    public(friend) fun admin_borrow<T0>(arg0: &mut Investor<T0>, arg1: u64, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        autocompound<T0>(arg0, arg2, arg3, arg4);
        borrow_and_redeposit_t<T0>(arg0, arg2, arg1, arg3, arg4);
        update_investor_state<T0>(arg0, arg2, arg3);
        assert!(arg0.t_debt < 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokens_deposited_as_collateral), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg2, arg0.market_id) as u16)), arg0.safe_borrow_percentage))), 2001);
    }

    public(friend) fun admin_repay<T0>(arg0: &mut Investor<T0>, arg1: u64, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_t_borrowed<T0>(arg0, arg2, arg3);
        autocompound<T0>(arg0, arg2, arg3, arg4);
        repay_to_alphalend<T0>(arg0, arg2, 0x1::u64::min(arg1, v0 + 1), arg3, arg4);
        update_investor_state<T0>(arg0, arg2, arg3);
        assert!(arg0.tokens_deposited_as_collateral > 0, 2003);
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_collateral<T0>(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<T0>();
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg1, arg0.market_id, &arg0.alphalend_position_cap, arg2, arg3);
        0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v2));
        0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v3, arg2, arg3)));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>())));
        };
        let v4 = get_total_t_borrowed<T0>(arg0, arg1, arg2);
        let v5 = if (v4 > arg0.t_debt) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.t_debt)))
        } else {
            0
        };
        if (0x2::balance::value<T0>(&v1) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, 0x2::coin::from_balance<T0>(v1, arg3), arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        let v6 = AutoCompoundingEvent{
            investor_id             : 0x2::object::id<Investor<T0>>(arg0),
            compound_amount         : 0x2::balance::value<T0>(&v1),
            total_amount            : arg0.tokens_deposited_as_collateral,
            cur_total_debt          : arg0.t_debt,
            accrued_borrow_interest : v5,
            fee_collected           : 0,
        };
        0x2::event::emit<AutoCompoundingEvent>(v6);
        update_investor_state<T0>(arg0, arg1, arg2);
    }

    fun borrow_and_redeposit_t<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, arg2, arg3, arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_deposit<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v0, arg3, arg4), v1, arg3);
    }

    fun collect_reward<T0, T1>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T1>(arg1, arg0.market_id, &arg0.alphalend_position_cap, arg2, arg3);
        let v2 = v0;
        0x2::coin::join<T1>(&mut v2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg1, v1, arg2, arg3));
        v2
    }

    public(friend) fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_collateral<T0>(arg0, arg1, arg7);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &v1)) {
            let v3 = 0x1::type_name::with_defining_ids<T2>();
            0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &v3)
        } else {
            false
        };
        assert!(v2, 2006);
        let v4 = 0x2::balance::zero<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>())));
        };
        let v5 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true) {
            0x2::balance::join<T2>(&mut v5, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())));
        };
        if (arg4) {
            0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(collect_reward<T0, T1>(arg0, arg1, arg7, arg8)));
            let v6 = 0x2::balance::value<T1>(&v4);
            if (v6 >= arg6 && arg5) {
                let (v7, _) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg7, arg3, arg2, v4, 0x2::balance::zero<T2>(), true, true, v6, 0, v7);
                let v11 = v9;
                assert!(0x2::balance::value<T1>(&v11) == 0, 2004);
                0x2::balance::destroy_zero<T1>(v11);
                0x2::balance::join<T2>(&mut v5, v10);
                update_free_rewards<T0, T2>(arg0, v5);
            } else {
                update_free_rewards<T0, T1>(arg0, v4);
                update_free_rewards<T0, T2>(arg0, v5);
            };
        } else {
            0x2::balance::join<T2>(&mut v5, 0x2::coin::into_balance<T2>(collect_reward<T0, T2>(arg0, arg1, arg7, arg8)));
            let v12 = 0x2::balance::value<T2>(&v5);
            if (v12 >= arg6 && arg5) {
                let (_, v14) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg7, arg3, arg2, 0x2::balance::zero<T1>(), v5, false, true, v12, 0, v14);
                let v17 = v16;
                assert!(0x2::balance::value<T2>(&v17) == 0, 2005);
                0x2::balance::destroy_zero<T2>(v17);
                0x2::balance::join<T1>(&mut v4, v15);
                update_free_rewards<T0, T1>(arg0, v4);
            } else {
                update_free_rewards<T0, T2>(arg0, v5);
                update_free_rewards<T0, T1>(arg0, v4);
            };
        };
    }

    public(friend) fun create_investor<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg3: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg4: &mut 0x2::tx_context::TxContext) : Investor<T0> {
        Investor<T0>{
            id                             : 0x2::object::new(arg4),
            alphalend_position_cap         : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position_for_partner(arg0, arg3, 0, arg4),
            free_rewards                   : 0x2::bag::new(arg4),
            tokens_deposited_as_collateral : 0,
            t_debt                         : 0,
            allowed_coin_types_for_swap    : arg2,
            current_debt_to_supply_ratio   : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            safe_borrow_percentage         : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(8000),
            market_id                      : arg1,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, arg2, arg3, arg4);
        let v0 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::coin::value<T0>(&arg2)), arg0.current_debt_to_supply_ratio), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), arg0.current_debt_to_supply_ratio)));
        if (v0 > 0) {
            borrow_and_redeposit_t<T0>(arg0, arg1, v0, arg3, arg4);
        };
        update_investor_state<T0>(arg0, arg1, arg3);
    }

    public(friend) fun emergency_repay<T0>(arg0: &mut Investor<T0>, arg1: u64, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_collateral<T0>(arg0, arg2, arg3);
        if (v0 == 0) {
            return
        };
        let v1 = get_total_t_borrowed<T0>(arg0, arg2, arg3);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg2, arg0.market_id) as u16)), arg0.safe_borrow_percentage);
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1);
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(v3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v4, v2))) {
            let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg1));
            let v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v5, v4)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), v5)));
            if (v6 > 0) {
                repay_to_alphalend<T0>(arg0, arg2, v6, arg3, arg4);
                update_investor_state<T0>(arg0, arg2, arg3);
            };
        };
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

    public(friend) fun get_total_collateral<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg2) as u64)
    }

    public(friend) fun get_total_t_borrowed<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg2)
    }

    public(friend) fun repay_to_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_withdraw<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, arg2, arg3, arg4);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v0, arg3, arg4);
        let v3 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T0>(arg1, &arg0.alphalend_position_cap, v1, arg0.market_id, v2, arg3, arg4);
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            update_free_rewards<T0, T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        };
        let v4 = RepayEvent{
            investor_id : 0x2::object::id<Investor<T0>>(arg0),
            amount      : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<RepayEvent>(v4);
    }

    public(friend) fun set_safe_borrow_percentage_bps<T0>(arg0: &mut Investor<T0>, arg1: u64) {
        arg0.safe_borrow_percentage = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg1);
    }

    public(friend) fun total_supplied_without_debt<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        update_investor_state<T0>(arg0, arg1, arg2);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokens_deposited_as_collateral), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.t_debt)))
    }

    public(friend) fun update_free_rewards<T0, T1>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>(), arg1);
        };
    }

    fun update_investor_state<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        let v0 = get_total_collateral<T0>(arg0, arg1, arg2);
        let v1 = get_total_t_borrowed<T0>(arg0, arg1, arg2);
        arg0.t_debt = v1;
        arg0.tokens_deposited_as_collateral = v0;
        if (v0 == 0) {
            arg0.current_debt_to_supply_ratio = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        } else {
            arg0.current_debt_to_supply_ratio = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0));
        };
    }

    public(friend) fun withdraw_from_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = get_total_collateral<T0>(arg0, arg1, arg4);
        let v1 = get_total_t_borrowed<T0>(arg0, arg1, arg4);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div_round_up(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3)));
        let v3 = v2;
        if (v2 == v1 && v1 > 0) {
            v3 = v2 + 1;
        };
        repay_to_alphalend<T0>(arg0, arg1, v3, arg4, arg5);
        let v4 = get_total_collateral<T0>(arg0, arg1, arg4);
        let v5 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3)))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4)))), arg4), arg4, arg5));
        update_investor_state<T0>(arg0, arg1, arg4);
        v5
    }

    // decompiled from Move bytecode v6
}

