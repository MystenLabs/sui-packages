module 0xc2b94aed49e09731b8c109ffdef30e6f825a0f12070dd5bb500da98416205a44::tb {
    public fun ab<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg4);
        let (v0, v1) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::swap_x_for_y<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun abm<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg1) >= arg3, 2);
        ab<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun ba<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::swap_y_for_x<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v0);
        0x2::coin::into_balance<T0>(v1)
    }

    public fun bam<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg1) <= arg3, 2);
        ba<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ba<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun sxm<T0>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun xs<T0>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ab<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun xsm<T0>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

