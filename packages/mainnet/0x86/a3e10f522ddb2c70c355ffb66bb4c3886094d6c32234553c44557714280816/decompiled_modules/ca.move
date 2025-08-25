module 0x86a3e10f522ddb2c70c355ffb66bb4c3886094d6c32234553c44557714280816::ca {
    public fun can(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 >= arg3 * 99 / 100, 101);
    }

    // decompiled from Move bytecode v6
}

