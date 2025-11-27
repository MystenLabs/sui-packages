module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::Version, arg1: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg2: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg3: 0x2::coin::Coin<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::is_paused(arg2), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::market_paused_error());
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::zero_amount_error());
        assert!(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::repay_locked(arg1) == false, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>();
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::accrue_all_interests(arg2, v0);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(&arg3));
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::handle_repay<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::handle_inflow<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::decrease_debt(arg1, v1, v5);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        if (0x2::coin::value<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6474993339df31d9c6022a7e6fd1399cdfb2c067973a92ceef4516fa301323::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

