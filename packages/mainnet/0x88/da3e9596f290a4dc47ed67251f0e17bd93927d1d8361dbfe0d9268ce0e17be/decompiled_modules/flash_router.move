module 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::flash_router {
    public fun flash_arb<T0, T1>(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg5 == 0) {
            let (v0, v1) = 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_deepbook::borrow_base<T0, T1>(arg0, arg3, arg6);
            let v2 = 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_cetus::swap_quote_to_base<T0, T1>(arg2, 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_cetus::swap_base_to_quote<T0, T1>(arg1, v0, arg6), arg6);
            0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_deepbook::repay_base<T0, T1>(arg0, &mut v2, v1, arg6);
            assert!(0x2::coin::value<T0>(&v2) >= arg4, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            assert!(arg5 == 1, 2);
            let (v3, v4) = 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_deepbook::borrow_quote<T0, T1>(arg0, arg3, arg6);
            let v5 = 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_cetus::swap_base_to_quote<T0, T1>(arg2, 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_cetus::swap_quote_to_base<T0, T1>(arg1, v3, arg6), arg6);
            0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_deepbook::repay_quote<T0, T1>(arg0, &mut v5, v4, arg6);
            assert!(0x2::coin::value<T1>(&v5) >= arg4, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg6));
        };
    }

    // decompiled from Move bytecode v6
}

