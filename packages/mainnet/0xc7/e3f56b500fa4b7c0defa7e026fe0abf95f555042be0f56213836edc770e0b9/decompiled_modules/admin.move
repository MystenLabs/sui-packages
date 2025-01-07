module 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::AdminCap, arg1: &mut 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::Vault<T0, T1, T2, 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::set_slippage<T0, T1, T2, 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::AdminCap, arg1: &mut 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::Vault<T0, T1, T2, 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::error::upper_lower_trigger_price_incompatible());
        0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config::set_trigger_price_scalling(0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::vault::borrow_mut_config<T0, T1, T2, 0xc7e3f56b500fa4b7c0defa7e026fe0abf95f555042be0f56213836edc770e0b9::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

