module 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::alphalend_adapter {
    struct AlphaLendPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        market_id: u64,
        deposited: u64,
    }

    fun assert_position_match<T0>(arg0: &AlphaLendPosition<T0>, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg2: u64) {
        assert!(arg0.vault_id == 0x2::object::id<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg1), 605);
        assert!(arg0.market_id == arg2, 604);
    }

    public fun collect_reward<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::RebalancerCap, arg1: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &AlphaLendPosition<T0>, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        assert_position_match<T0>(arg4, arg2, arg5);
        let v0 = 0x2::bag::new(arg8);
        let v1 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg3, arg5, &arg4.position_cap, arg7, arg8);
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg3, v3, arg6, arg7, arg8);
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v2);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), v4);
            0x2::coin::value<0x2::sui::SUI>(&v4)
        } else {
            let (v5, v6) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg3, arg5, &arg4.position_cap, arg7, arg8);
            let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v6, arg7, arg8);
            0x2::coin::join<T0>(&mut v7, v5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), v7);
            0x2::coin::value<T0>(&v7)
        };
        let v8 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::bag::destroy_empty(v0);
        let v9 = 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::deduct_fee_on_yield<T0>(arg1, 0x2::coin::balance_mut<T0>(&mut v8), v1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::add_yield<T0>(arg2, 0x2::coin::into_balance<T0>(v8));
        if (v9 > 0) {
            0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition<T0>>(arg4), v9, 0x2::clock::timestamp_ms(arg7));
        };
    }

    public fun deposit<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::RebalancerCap, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut AlphaLendPosition<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        assert!(arg6 > 0, 600);
        assert_position_match<T0>(arg4, arg2, arg5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg3, &arg4.position_cap, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::borrow_balance_mut<T0>(arg2), arg6), arg8), arg7, arg8);
        arg4.deposited = arg4.deposited + arg6;
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_deposited(0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg5)), 0x2::tx_context::sender(arg8), arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun get_claimable_rewards<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &AlphaLendPosition<T0>, arg2: &0x2::clock::Clock) : vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg0, &arg1.position_cap, arg2)
    }

    public fun get_collateral_amount<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &AlphaLendPosition<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg1.position_cap), arg3)
    }

    public fun init_position<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::AdminCap, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg5);
        let v1 = AlphaLendPosition<T0>{
            id           : 0x2::object::new(arg5),
            vault_id     : 0x2::object::id<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg2),
            position_cap : v0,
            market_id    : arg4,
            deposited    : 0,
        };
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::register_position(arg2, 0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition<T0>>(&v1), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)));
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_position_created(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition<T0>>(&v1), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v0), 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<AlphaLendPosition<T0>>(v1);
    }

    public fun withdraw<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::RebalancerCap, arg1: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut AlphaLendPosition<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        assert!(arg6 > 0, 600);
        assert_position_match<T0>(arg4, arg2, arg5);
        let v0 = 0x2::bag::new(arg10);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg3, arg5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg4.position_cap), arg9);
        assert!(v1 >= arg6, 606);
        let v2 = (((arg4.deposited as u128) * (arg6 as u128) / (v1 as u128)) as u64);
        let v3 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg3, &arg4.position_cap, arg5, arg6, arg9), arg8, arg9, arg10);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), v4);
            0x2::coin::value<0x2::sui::SUI>(&v4)
        } else {
            let v5 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg3, &arg4.position_cap, arg5, arg6, arg9), arg9, arg10);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), v5);
            0x2::coin::value<T0>(&v5)
        };
        let v6 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::bag::destroy_empty(v0);
        let v7 = if (v3 > v2) {
            v3 - v2
        } else {
            0
        };
        let v8 = 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::deduct_fee_on_yield<T0>(arg1, &mut v6, v7);
        assert!(arg6 - v8 >= arg7, 607);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::add_yield<T0>(arg2, v6);
        arg4.deposited = arg4.deposited - v3;
        if (v8 > 0) {
            0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition<T0>>(arg4), v8, 0x2::clock::timestamp_ms(arg9));
        };
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_withdrawn(0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg5)), 0x2::tx_context::sender(arg10), v3, 0, 0x2::clock::timestamp_ms(arg9));
    }

    // decompiled from Move bytecode v6
}

