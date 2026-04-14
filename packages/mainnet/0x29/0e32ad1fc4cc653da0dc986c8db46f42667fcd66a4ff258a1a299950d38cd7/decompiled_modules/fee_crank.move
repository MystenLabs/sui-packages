module 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::fee_crank {
    public fun crank_fees<T0, T1, T2: store>(arg0: &mut 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::pool::Pool<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::BToken<T0>, 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::BToken<T1>, T2>, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &mut 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::Bank<T0>, arg3: &mut 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::Bank<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        let (v0, v1) = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::pool::collect_protocol_fees<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::BToken<T0>, 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::BToken<T1>, T2>(arg0);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::move_fees<T0>(arg2, v0);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::move_fees<T1>(arg3, v1);
    }

    // decompiled from Move bytecode v6
}

