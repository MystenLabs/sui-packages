module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::create_pool {
    public fun create_pool<T0, T1>(arg0: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: bool, arg4: u64, arg5: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::PoolCap) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg5);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::new<T0, T1>(arg0, arg3, arg1, arg2, arg4, arg6)
    }

    public entry fun create_pool_entry<T0, T1>(arg0: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: bool, arg4: u64, arg5: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::assert_current_version(arg5);
        let (v0, v1) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::new<T0, T1>(arg0, arg3, arg1, arg2, arg4, arg6);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::transfer<T0, T1>(v0);
        0x2::transfer::public_transfer<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::PoolCap>(v1, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

