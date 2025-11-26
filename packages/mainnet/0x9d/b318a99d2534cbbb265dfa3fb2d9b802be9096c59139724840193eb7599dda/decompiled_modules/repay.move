module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg3: 0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::is_paused(arg2), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::market_paused_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::zero_amount_error());
        assert!(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::repay_locked(arg1) == false, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>();
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::accrue_all_interests(arg2, v0);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::no_debt_error());
        let v4 = 0x2::math::min(v2, 0x2::coin::value<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&arg3));
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_repay<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&mut arg3, v4, arg5), arg5);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_inflow<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg2, v4, v0);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

