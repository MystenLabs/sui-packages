module 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market_user_entry {
    public entry fun accrue_interest(arg0: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::accrue_interest(arg0, arg1, arg2);
    }

    public entry fun set_authorization(arg0: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::set_authorization(arg0, arg1, arg2, arg3);
    }

    public entry fun supply<T0>(arg0: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2) = 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::supply<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
    }

    public entry fun withdraw<T0>(arg0: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<address>(), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

