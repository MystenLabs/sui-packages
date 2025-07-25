module 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::alphafi_alphalend_single_loop_investor {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        minimum_swap_amount: u64,
        current_debt_to_supply_ratio: u256,
        safe_borrow_percentage: u64,
        performance_fee: u64,
        max_cap_performance_fee: u64,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        location: u64,
    }

    struct CheckRatio has copy, drop {
        ratio: u256,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        cur_total_debt: u64,
        accrued_interest: u64,
        fee_collected: u64,
        location: u64,
    }

    struct DebugNewEvent has copy, drop {
        a: u256,
        b: u256,
        location: u64,
    }

    fun borrow<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T0>(arg1, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), arg2, arg3, arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_deposit<T0>(arg1, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v0, arg3, arg4), v1, arg3);
    }

    public fun admin_borrow<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u64, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7);
        borrow<T0>(arg2, arg5, arg3, arg6, arg7);
        let v0 = get_total_invested<T0>(arg2, arg5, arg6);
        arg2.tokensDeposited = v0;
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg5, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg2.position_cap), arg6);
        update_debt_in_df<T0>(arg2, (v1 as u256));
        assert!((v1 as u256) < (v0 as u256) * (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg5, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id")) as u256) * (arg2.safe_borrow_percentage as u256) / 1000000, 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::error::high_debt());
        arg2.current_debt_to_supply_ratio = (((v1 as u256) * 100000000000000000000 / (v0 as u256)) as u256);
        let v2 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v0 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v2);
    }

    public fun admin_repay<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u64, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        assert!(arg3 <= 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg5, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg2.position_cap), arg6), 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::error::repay_amount_more_than_debt());
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7);
        repay_to_alphalend<T0>(arg2, arg5, arg3, arg6, arg7);
        let v0 = get_total_invested<T0>(arg2, arg5, arg6);
        assert!(v0 > 0, 999999999);
        arg2.tokensDeposited = v0;
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg5, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg2.position_cap), arg6);
        update_debt_in_df<T0>(arg2, (v1 as u256));
        arg2.current_debt_to_supply_ratio = (((v1 as u256) * 100000000000000000000 / (v0 as u256)) as u256);
        let v2 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v0 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v2);
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<T0>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg2, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), v1, arg3), arg3, arg4)));
        };
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg2, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), &arg0.position_cap, arg3, arg4);
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v3));
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v4, arg3, arg4)));
        let v5 = RewardEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v5);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v6 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"debt")
        } else {
            0
        };
        let v7 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg2, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg3) as u64) - (v6 as u64);
        let v8 = 0x2::balance::value<T0>(&v2);
        let v9 = if (v8 > (v7 as u64)) {
            ((v8 - (v7 as u64)) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, (v9 as u64)), arg4), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let v10 = get_total_invested<T0>(arg0, arg2, arg3);
        let v11 = AutoCompoundingEvent{
            investor_id      : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount  : v8,
            total_amount     : v10,
            cur_total_debt   : (v6 as u64),
            accrued_interest : (v7 as u64),
            fee_collected    : (v9 as u64),
            location         : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v11);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg2, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0x2::coin::from_balance<T0>(v2, arg4), arg3, arg4);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg2, arg3);
    }

    public fun change_safe_borrow<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u64) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        assert!(arg3 <= 9500, 0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::error::high_safe_borrow());
        arg2.safe_borrow_percentage = arg3;
    }

    public(friend) fun check_and_set_asset_ltv<T0>(arg0: &mut Investor<T0>, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol) {
        let v0 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id")) as u256);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"asset_ltv");
        if (v0 != *v1) {
            let v2 = DebugNewEvent{
                a        : (v0 as u256),
                b        : (*v1 as u256),
                location : 38888,
            };
            0x2::event::emit<DebugNewEvent>(v2);
            *v1 = v0;
        };
    }

    public(friend) fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg1, arg5);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
            0x2::balance::join<T1>(&mut v1, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())));
        };
        let v2 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v2, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        if (arg4) {
            let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T1>(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), &arg0.position_cap, arg5, arg6);
            let v5 = v3;
            0x2::coin::join<T1>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg1, v4, arg5, arg6));
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(v5));
            let v6 = 0x2::balance::value<T1>(&v1);
            if (v6 >= arg0.minimum_swap_amount) {
                let (v7, _) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg5, arg3, arg2, v1, 0x2::balance::zero<T2>(), true, true, v6, 0, v7);
                0x2::balance::destroy_zero<T1>(v9);
                0x2::balance::join<T2>(&mut v2, v10);
                update_free_rewards<T0, T2>(arg0, v2);
            } else {
                update_free_rewards<T0, T1>(arg0, v1);
                update_free_rewards<T0, T2>(arg0, v2);
            };
        } else {
            let (v11, v12) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T2>(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), &arg0.position_cap, arg5, arg6);
            let v13 = v11;
            0x2::coin::join<T2>(&mut v13, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T2>(arg1, v12, arg5, arg6));
            0x2::balance::join<T2>(&mut v2, 0x2::coin::into_balance<T2>(v13));
            let v14 = 0x2::balance::value<T2>(&v2);
            if (v14 >= arg0.minimum_swap_amount) {
                let (_, v16) = get_bluefin_sqrt_price_limits<T1, T2>(arg2);
                let (v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg5, arg3, arg2, 0x2::balance::zero<T1>(), v2, false, true, v14, 0, v16);
                0x2::balance::destroy_zero<T2>(v18);
                0x2::balance::join<T1>(&mut v1, v17);
                update_free_rewards<T0, T1>(arg0, v1);
            } else {
                update_free_rewards<T0, T2>(arg0, v2);
                update_free_rewards<T0, T1>(arg0, v1);
            };
        };
    }

    public fun create_investor<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        let v0 = Investor<T0>{
            id                           : 0x2::object::new(arg6),
            position_cap                 : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position_for_partner(arg3, arg2, 0, arg6),
            free_rewards                 : 0x2::bag::new(arg6),
            tokensDeposited              : 0,
            minimum_swap_amount          : 200000,
            current_debt_to_supply_ratio : 0,
            safe_borrow_percentage       : arg4,
            performance_fee              : 2000,
            max_cap_performance_fee      : 5000,
        };
        0x2::dynamic_field::add<vector<u8>, u256>(&mut v0.id, b"asset_ltv", (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg3, arg5) as u256));
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v0.id, b"market_id", arg5);
        0x2::transfer::public_share_object<Investor<T0>>(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), arg2, arg3, arg4);
        borrow<T0>(arg0, arg1, (((0x2::coin::value<T0>(&arg2) as u256) * arg0.current_debt_to_supply_ratio / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u64), arg3, arg4);
        let v0 = get_total_invested<T0>(arg0, arg1, arg3);
        arg0.tokensDeposited = v0;
        let v1 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg3) as u256);
        update_debt_in_df<T0>(arg0, v1);
    }

    public fun emergency_repay<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::EmergencyCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u256, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        let v0 = get_total_invested<T0>(arg2, arg4, arg5);
        if (v0 == 0) {
            return
        };
        let v1 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg4, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg2.position_cap), arg5) as u256);
        let v2 = 1000000;
        let v3 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg4, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id")) as u256) * (arg2.safe_borrow_percentage as u256);
        let v4 = DebugNewEvent{
            a        : v3 - arg3 * v2 / 10000,
            b        : v3,
            location : 99,
        };
        0x2::event::emit<DebugNewEvent>(v4);
        if (v1 >= (v0 as u256) * v3 / v2) {
            let v5 = (v3 - arg3 * v2 / 10000) * 100000000000000;
            if (v5 * (v0 as u256) < v1 * 100000000000000000000) {
                let v6 = (v1 * 100000000000000000000 - v5 * (v0 as u256)) / (100000000000000000000 - v5);
                if ((v6 as u64) > arg2.minimum_swap_amount) {
                    repay_to_alphalend<T0>(arg2, arg4, (v6 as u64), arg5, arg6);
                    let v7 = get_total_invested<T0>(arg2, arg4, arg5);
                    arg2.tokensDeposited = v7;
                    let v8 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg4, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg2.position_cap), arg5);
                    update_debt_in_df<T0>(arg2, (v8 as u256));
                    arg2.current_debt_to_supply_ratio = (((v8 as u256) * 100000000000000000000 / (arg2.tokensDeposited as u256)) as u256);
                };
            };
        };
    }

    public(friend) fun fix_ratio<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        let v0 = get_total_invested<T0>(arg0, arg1, arg2);
        arg0.tokensDeposited = v0;
        if ((arg0.tokensDeposited as u64) == 0) {
            return
        };
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg2);
        update_debt_in_df<T0>(arg0, (v1 as u256));
        arg0.current_debt_to_supply_ratio = (((v1 as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256);
        let v2 = CheckRatio{ratio: (((v1 as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256)};
        0x2::event::emit<CheckRatio>(v2);
    }

    fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
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
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg2) as u64)
    }

    public(friend) fun has_unclaimed_rewards<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg1, &arg0.position_cap, arg2);
        0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&v0) > 0
    }

    public(friend) fun repay_to_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_withdraw<T0>(arg1, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), arg2, arg3, arg4);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T0>(arg1, &arg0.position_cap, v1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v0, arg3, arg4), arg3, arg4);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            update_free_rewards<T0, T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        };
    }

    entry fun set_minimum_swap_amount<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u64) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::Version, arg2: &mut Investor<T0>, arg3: u64) {
        0x7fe41a98f3de9885d62b96aa8046bf65f22fe67fcaf53c6b2a305c9cb1b6c90f::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.max_cap_performance_fee, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun total_supplied_without_debt<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_total_invested<T0>(arg0, arg1, arg2);
        let v1 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg2) as u64);
        let v2 = DebugNewEvent{
            a        : (v0 as u256),
            b        : (v1 as u256),
            location : 71,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        (v0 as u64) - v1
    }

    fun update_debt_in_df<T0>(arg0: &mut Investor<T0>, arg1: u256) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"debt") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u256>(&mut arg0.id, b"debt", arg1);
        };
    }

    public(friend) fun update_free_rewards<T0, T1>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>(), arg1);
        };
    }

    public(friend) fun withdraw_from_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = get_total_invested<T0>(arg0, arg1, arg4);
        let v1 = (arg2 as u256) * (v0 as u256) / (arg3 as u256);
        let v2 = DebugNewEvent{
            a        : (arg2 as u256),
            b        : (arg3 as u256),
            location : 38,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        let v3 = (((arg2 as u256) * (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg4) as u256) / (arg3 as u256)) as u64);
        repay_to_alphalend<T0>(arg0, arg1, v3, arg4, arg5);
        let v4 = get_total_invested<T0>(arg0, arg1, arg4);
        let v5 = (v1 as u64) - v0 - v4;
        let v6 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v5 as u256),
            location : 40,
        };
        0x2::event::emit<DebugNewEvent>(v6);
        let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.position_cap, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), (v5 as u64), arg4), arg4, arg5);
        let v8 = get_total_invested<T0>(arg0, arg1, arg4);
        arg0.tokensDeposited = v8;
        let v9 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"market_id"), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg4) as u256);
        update_debt_in_df<T0>(arg0, v9);
        0x2::coin::into_balance<T0>(v7)
    }

    // decompiled from Move bytecode v6
}

