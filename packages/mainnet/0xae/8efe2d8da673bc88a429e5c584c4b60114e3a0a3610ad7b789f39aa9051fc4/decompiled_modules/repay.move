module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg2: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg3: 0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_paused(arg2), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::market_paused_error());
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::zero_amount_error());
        assert!(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::repay_locked(arg1) == false, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>();
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::accrue_all_interests(arg2, v0);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg3));
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::handle_repay<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::handle_inflow<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::decrease_debt(arg1, v1, v5);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        if (0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

