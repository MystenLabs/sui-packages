module 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::AdminCap, arg1: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::set_slippage<T0, T1, T2, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::AdminCap, arg1: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::error::upper_lower_trigger_price_incompatible());
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::config::set_trigger_price_scalling(0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::borrow_mut_config<T0, T1, T2, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

