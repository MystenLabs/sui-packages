module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::Version, arg1: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg2: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg3: 0x2::coin::Coin<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::is_paused(arg2), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::market_paused_error());
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::zero_amount_error());
        assert!(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::repay_locked(arg1) == false, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>();
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::accrue_all_interests(arg2, v0);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(&arg3));
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::handle_repay<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::handle_inflow<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        if (v4 > 0) {
            0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        };
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::decrease_debt(arg1, v1, v5);
        if (0x2::coin::value<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

