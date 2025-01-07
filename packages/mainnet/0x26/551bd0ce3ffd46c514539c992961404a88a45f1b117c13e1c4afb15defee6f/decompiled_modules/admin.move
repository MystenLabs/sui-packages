module 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::AdminCap, arg1: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::set_slippage<T0, T1, T2, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::AdminCap, arg1: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 9);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::config::set_trigger_price_scalling(0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::borrow_mut_config<T0, T1, T2, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

