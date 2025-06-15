module 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        use_clmm: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = KriyaSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : 0,
            use_clmm   : arg3,
        };
        0x2::event::emit<KriyaSwapExecuted>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun get_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_sui_usdt_pool() : address {
        @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7
    }

    // decompiled from Move bytecode v6
}

