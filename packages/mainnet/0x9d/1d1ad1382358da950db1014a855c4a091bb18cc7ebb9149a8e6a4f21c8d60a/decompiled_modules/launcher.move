module 0x9d1d1ad1382358da950db1014a855c4a091bb18cc7ebb9149a8e6a4f21c8d60a::launcher {
    public entry fun launch<T0>(arg0: &mut 0x9d1d1ad1382358da950db1014a855c4a091bb18cc7ebb9149a8e6a4f21c8d60a::token_factory::TokenRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg7 <= 500, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1, arg3, arg9), arg4);
        if (arg8) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, arg4);
        } else {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg1);
        };
        0x9d1d1ad1382358da950db1014a855c4a091bb18cc7ebb9149a8e6a4f21c8d60a::token_factory::register_token(arg0, 0x9d1d1ad1382358da950db1014a855c4a091bb18cc7ebb9149a8e6a4f21c8d60a::fee_distributor::create_vault<T0>(arg4, arg5, arg6, arg7, arg9), 0x9d1d1ad1382358da950db1014a855c4a091bb18cc7ebb9149a8e6a4f21c8d60a::staking_pool::create_pool<T0>(arg9), 0x2::coin::get_name<T0>(arg2), 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg2)), arg4, arg9);
    }

    // decompiled from Move bytecode v6
}

