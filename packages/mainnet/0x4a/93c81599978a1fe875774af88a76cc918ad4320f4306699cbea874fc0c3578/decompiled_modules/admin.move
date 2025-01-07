module 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::AdminCap, arg1: &mut 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::Vault<T0, T1, T2, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::set_slippage<T0, T1, T2, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::AdminCap, arg1: &mut 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::Vault<T0, T1, T2, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::error::upper_lower_trigger_price_incompatible());
        0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::config::set_trigger_price_scalling(0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::borrow_mut_config<T0, T1, T2, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

