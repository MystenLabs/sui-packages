module 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::launcher {
    public entry fun launch<T0>(arg0: &mut 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::TokenRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg7 <= 500, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1, arg3, arg9), arg4);
        if (arg8) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, arg4);
        } else {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg1);
        };
        0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::register_token(arg0, 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::fee_distributor::create_vault<T0>(arg4, arg5, arg6, arg7, arg9), 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::staking_pool::create_pool<T0>(arg9), 0x2::coin::get_name<T0>(arg2), 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg2)), arg4, arg9);
    }

    // decompiled from Move bytecode v6
}

