module 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::AdminCap, arg1: &mut 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::Vault<T0, T1, T2, 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::set_slippage<T0, T1, T2, 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::AdminCap, arg1: &mut 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::Vault<T0, T1, T2, 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::error::upper_lower_trigger_price_incompatible());
        0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::config::set_trigger_price_scalling(0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::vault::borrow_mut_config<T0, T1, T2, 0x5864471c4b0599e39fe65d858a15b2991ed10b207c8fcec556632f00a82a15d1::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

