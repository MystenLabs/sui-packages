module 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::AdminCap, arg1: &mut 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::Vault<T0, T1, T2, 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::set_slippage<T0, T1, T2, 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::AdminCap, arg1: &mut 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::Vault<T0, T1, T2, 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::error::upper_lower_trigger_price_incompatible());
        0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::config::set_trigger_price_scalling(0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::vault::borrow_mut_config<T0, T1, T2, 0x2272b52cef5779e5488417ca9fcafdd148058135244d09d19af1296e636406d1::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

