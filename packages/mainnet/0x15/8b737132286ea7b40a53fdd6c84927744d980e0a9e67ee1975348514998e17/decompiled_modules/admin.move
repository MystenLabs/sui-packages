module 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::AdminCap, arg1: &mut 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::Vault<T0, T1, T2, 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::set_slippage<T0, T1, T2, 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::AdminCap, arg1: &mut 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::Vault<T0, T1, T2, 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::error::upper_lower_trigger_price_incompatible());
        0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::config::set_trigger_price_scalling(0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vault::borrow_mut_config<T0, T1, T2, 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

