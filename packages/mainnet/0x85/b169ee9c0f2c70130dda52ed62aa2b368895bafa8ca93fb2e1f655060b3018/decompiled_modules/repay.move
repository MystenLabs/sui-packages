module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::version::Version, arg1: &mut 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation, arg2: &mut 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::Market, arg3: 0x2::coin::Coin<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::is_paused(arg2), 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::market_paused_error());
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::zero_amount_error());
        assert!(0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::repay_locked(arg1) == false, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>();
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::accrue_all_interests(arg2, v0);
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(&arg3));
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::handle_repay<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::handle_inflow<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        if (v4 > 0) {
            0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        };
        0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::decrease_debt(arg1, v1, v5);
        if (0x2::coin::value<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

