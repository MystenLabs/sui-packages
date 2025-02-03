module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::swap {
    public fun swap_token_x<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1::option::Option<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::SwapEvent<T0>>) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg4);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::swap_token_x<T0, T1>(arg0, arg1, arg2, arg3, arg5)
    }

    public fun swap_token_y<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::SwapEvent<T1>>) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg4);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::swap_token_y<T0, T1>(arg0, arg1, arg2, arg3, arg5)
    }

    public entry fun swap_token_x_entry<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg3);
        let (v0, _) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::swap_token_x<T0, T1>(arg0, arg1, arg2, false, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_token_y_entry<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg3);
        let (v0, _) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::swap_token_y<T0, T1>(arg0, arg1, arg2, false, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

