module 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::market_liquidation_entry {
    public entry fun liquidate<T0, T1>(arg0: &mut 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0xfe010e5c88720ce4ef690bc78e48cb957feff54e9c2745597a1644ecc3364dfe::pyth_oracle::Oracle, arg8: &mut 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::farming_core::Farming, arg9: &mut 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::farming_core::Pool<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, _, v3, _, v5) = 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::market::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::farming_core::stake_adjust<T0>(arg8, arg9, arg0, arg1, arg2, v3, false, arg6, arg10);
    }

    // decompiled from Move bytecode v6
}

