module 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::user_entry {
    public fun deposit<T0>(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg1: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg2: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::secure_vault::SecureVault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 20000);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::deposit<T0>(arg1, arg0, arg2, 0x2::tx_context::sender(arg5), 0x2::balance::split<T0>(&mut v0, arg4));
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config, arg2: &mut 0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::ActiveVault<T0>, arg3: u256, arg4: u64, arg5: u64, arg6: address, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::withdraw<T0>(arg2, arg0, arg1, arg3, arg4, 0x2::tx_context::sender(arg9), arg5, arg6, arg7, arg8), arg9), arg6);
    }

    // decompiled from Move bytecode v6
}

