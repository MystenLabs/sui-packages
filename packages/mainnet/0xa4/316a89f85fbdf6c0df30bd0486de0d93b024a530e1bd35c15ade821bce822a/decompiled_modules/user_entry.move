module 0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::user_entry {
    public fun deposit<T0>(arg0: &0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::Config, arg1: &mut 0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::ActiveVault<T0>, arg2: &mut 0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::secure_vault::SecureVault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 20000);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::deposit<T0>(arg1, arg0, arg2, 0x2::tx_context::sender(arg5), 0x2::balance::split<T0>(&mut v0, arg4));
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::Config, arg2: &mut 0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::ActiveVault<T0>, arg3: u256, arg4: u64, arg5: u64, arg6: address, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa4316a89f85fbdf6c0df30bd0486de0d93b024a530e1bd35c15ade821bce822a::active_vault::withdraw<T0>(arg2, arg0, arg1, arg3, arg4, 0x2::tx_context::sender(arg9), arg5, arg6, arg7, arg8), arg9), arg6);
    }

    // decompiled from Move bytecode v6
}

