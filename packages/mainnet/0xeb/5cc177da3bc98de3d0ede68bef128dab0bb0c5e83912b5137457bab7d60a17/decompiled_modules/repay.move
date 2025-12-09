module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::Version, arg1: &mut 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg2: &mut 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg3: 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::is_paused(arg2), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::market_paused_error());
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::zero_amount_error());
        assert!(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::repay_locked(arg1) == false, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>();
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::accrue_all_interests(arg2, v0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&arg3));
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::handle_repay<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::handle_inflow<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::decrease_debt(arg1, v1, v5);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        if (0x2::coin::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

