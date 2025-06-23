module 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::zero_obj {
    public fun zero_obj_mint<T0>(arg0: &0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::nft::NftConfig, arg1: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let v0 = 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::borrow_from_treasury<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0x60c049b5aea93660573019b2ed5d657245212a998e030981589726d11fe);
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_zero_object_event(arg4);
        if (0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::nft::check_before_tge(arg0, arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>>(0x2::coin::from_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(v0, 1), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

