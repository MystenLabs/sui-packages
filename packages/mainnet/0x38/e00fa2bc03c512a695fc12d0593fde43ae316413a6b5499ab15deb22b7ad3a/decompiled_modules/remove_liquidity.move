module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::remove_liquidity {
    public fun remove_liquidity<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::KdxLpToken<T0, T1>, arg2: bool, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1::option::Option<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::LiquidityRemovedEvent>) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg3);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg4)
    }

    public entry fun remove_liquidity_entry<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::KdxLpToken<T0, T1>, arg2: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg2);
        let (v0, v1, _) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::remove_liquidity<T0, T1>(arg0, arg1, false, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

