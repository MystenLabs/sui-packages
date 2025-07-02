module 0xaac6e99a95b74c04bd63d77c0fdc25a665817d1619b4956d721a8fb5eba28505::swap_event {
    struct Xydl_Common_Swap_Event<phantom T0, phantom T1> has copy, drop {
        dex_id: u8,
        pool_id: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
    }

    public(friend) fun emit_common_swap<T0, T1>(arg0: u8, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = Xydl_Common_Swap_Event<T0, T1>{
            dex_id       : arg0,
            pool_id      : arg1,
            a2b          : arg2,
            amount_in    : arg3,
            amount_out   : arg4,
            by_amount_in : arg5,
        };
        0x2::event::emit<Xydl_Common_Swap_Event<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

