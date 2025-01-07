module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::add_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::KdxLpToken<T0, T1>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>, 0x1::option::Option<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::LiquidityAddedEvent>) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg6);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    public entry fun add_liquidity_entry<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg5);
        let (v0, v1, v2, _) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg6);
        let v4 = v2;
        let v5 = v1;
        0x2::transfer::public_transfer<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::KdxLpToken<T0, T1>>(v0, 0x2::tx_context::sender(arg6));
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v5), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v5);
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v4), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

