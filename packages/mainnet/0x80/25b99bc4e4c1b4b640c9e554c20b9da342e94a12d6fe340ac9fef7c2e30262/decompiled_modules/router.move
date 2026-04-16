module 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::router {
    struct FeeCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_open: bool,
        fee_amount: u64,
        fee_coin_type: 0x1::type_name::TypeName,
        recipient: address,
    }

    public fun borrow<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        assert!(arg4 > 0, 13906834947438215180);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::borrow());
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = if (0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::is_long<T0>(arg3)) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v0, 13906834990388019214);
        let v1 = if (0x1::type_name::with_defining_ids<T3>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v2 = resolve_reserve_index<T0, 0x2::sui::SUI>(arg0);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg0, v2, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), arg6, arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, v2, &v3, arg5, arg7);
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, v2, v3, arg7);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T3>>(v4, arg7)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T3>(arg0, resolve_reserve_index<T0, T3>(arg0), 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), arg6, arg4, arg7)
        };
        let v5 = v1;
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_borrow_event<T0, T3>(arg3, 0x2::coin::value<T3>(&v5), arg6);
        v5
    }

    public fun close_position<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: &0x2::clock::Clock) {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::close_position());
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(&arg3, &arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(&arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        assert!(0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::lending_market_id<T0>(&arg3) == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0), 13906834758459129860);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_close_position_event<T0>(&arg3, arg4);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(&arg3));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg0, v0, arg4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, v0);
        assert!(0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v1)), 13906834809998868486);
        assert!(0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v1)), 13906834827178868744);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v2)) {
            assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::shares(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v2, v3)) == 0, 13906834857243770890);
            v3 = v3 + 1;
        };
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::destroy_position<T0>(arg3);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::destroy_position_cap(arg2);
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: 0x2::coin::Coin<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::deposit());
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = if (0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::is_long<T0>(arg3)) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T2>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v0, 13906835810725986306);
        let (v1, v2) = deduct_fee<T3>(arg4, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::open_fee_rate<T1, T2>(arg1), arg6);
        let v3 = v1;
        deposit_into_suilend<T0, T3>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), v3, arg5, arg6);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_deposit_event<T0, T3>(arg3, 0x2::coin::value<T3>(&v3), arg5);
        transfer_fee<T3>(v2, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1), true, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::fee_recipient<T1, T2>(arg1), arg6);
    }

    public fun open_position<T0, T1, T2>(arg0: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg0);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::open_position());
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg1, arg4);
        let v1 = 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg0);
        let v2 = 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::create_position<T0>(v0, arg2, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), v1, arg3, arg4);
        let (v3, v4) = if (arg2) {
            (0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T2>())
        } else {
            (0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T1>())
        };
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_open_position_event(v2, v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0), arg2, v3, v4, 0x2::tx_context::sender(arg4), arg3);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::new_position_cap(v2, arg4)
    }

    public fun repay<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::repay());
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = if (0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::is_long<T0>(arg3)) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v0, 13906835282445926416);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T3>(arg0, resolve_reserve_index<T0, T3>(arg0), 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_id<T0>(arg3), arg5, arg4, arg6);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_repay_event<T0, T3>(arg3, 0x2::coin::value<T3>(arg4) - 0x2::coin::value<T3>(arg4), arg5);
    }

    public fun withdraw<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::withdraw());
        assert!(arg5 > 0, 13906835419884617740);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = if (0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::is_long<T0>(arg3)) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T2>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v0, 13906835462834683922);
        let v1 = withdraw_from_suilend<T0, T3>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = deduct_fee<T3>(v1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::close_fee_rate<T1, T2>(arg1), arg8);
        let v4 = v2;
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_withdraw_event<T0, T3>(arg3, 0x2::coin::value<T3>(&v4), arg7);
        transfer_fee<T3>(v3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1), false, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::fee_recipient<T1, T2>(arg1), arg8);
        v4
    }

    public(friend) fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 1000000, 13906836545166573588);
        ((((arg1 as u128) * (arg0 as u128) + (1000000 as u128) - 1) / (1000000 as u128)) as u64)
    }

    fun cast_as_type<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, T1>(&mut v0, true)
    }

    public fun claim_rewards<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::claim_reward());
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), arg7, arg4, arg5, arg6, arg8);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::emit_claim_reward_event<T0, T3>(arg3, 0x2::coin::value<T3>(&v0), arg7);
        v0
    }

    public fun compound_debt<T0, T1, T2>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: u64) : u64 {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_id<T0>(arg3)));
        if (arg4 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0)) {
            abort 13906836631066050582
        };
        let v1 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::cumulative_borrow_rate<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v1))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_cumulative_borrow_rate(v1))))
    }

    fun deduct_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v0) > 0, 13906836472152391704);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::balance::split<T0>(&mut v0, calculate_fee(arg1, 0x2::coin::value<T0>(&arg0))))
    }

    fun deposit_into_suilend<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = resolve_reserve_index<T0, T1>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, v0, arg1, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, v0, arg3, arg2, arg4), arg4);
    }

    fun resolve_reserve_index<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        assert!(v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0)), 13906834479287697434);
        v0
    }

    fun transfer_fee<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            let v0 = FeeCollectedEvent{
                market_id     : arg1,
                is_open       : arg2,
                fee_amount    : 0x2::balance::value<T0>(&arg0),
                fee_coin_type : 0x1::type_name::with_defining_ids<T0>(),
                recipient     : arg3,
            };
            0x2::event::emit<FeeCollectedEvent>(v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun withdraw_auto_deposit<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>, arg2: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::PositionCap, arg3: &0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::Position<T0>, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_version<T1, T2>(arg1);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::check_permission<T1, T2>(arg1, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::permissions::withdraw());
        assert!(arg5 > 0, 13906835613158146060);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_position_cap_match<T0>(arg3, arg2);
        0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::assert_market_match<T0>(arg3, 0x2::object::id<0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::market::Market<T1, T2>>(arg1));
        let v0 = if (0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::is_long<T0>(arg3)) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T2>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() != v0, 13906835660403834908);
        withdraw_from_suilend<T0, T3>(arg0, 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position::obligation_owner_cap<T0>(arg3), arg4, arg5, arg6, arg7, arg8)
    }

    fun withdraw_from_suilend<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x1::option::destroy_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(arg2);
            let v1 = resolve_reserve_index<T0, 0x2::sui::SUI>(arg0);
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, v1, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg0, v1, arg1, arg5, arg3, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg6);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, v1, &v2, arg4, arg6);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, v1, v2, arg6);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>>(v3, arg6)
        } else {
            let v4 = resolve_reserve_index<T0, T1>(arg0);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg0, v4, arg1, arg5, arg3, arg6), arg2, arg6)
        }
    }

    // decompiled from Move bytecode v7
}

