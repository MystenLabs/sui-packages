module 0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::script {
    public entry fun add_pool<T0, T1>(arg0: &mut 0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::oracle_driven_pool::add_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun destroy_pool<T0, T1>(arg0: &mut 0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::AdminCap, arg1: &0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::oracle_driven_pool::Pool<T0, T1>) {
        0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::assert_version(arg0);
        0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::oracle_driven_pool::destroy_pool<T0, T1>(arg0, arg1);
    }

    public entry fun migrate_admin(arg0: &mut 0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::AdminCap, arg1: &0x2::tx_context::TxContext) {
        0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::migrate(arg0, arg1);
    }

    public entry fun migrate_pool<T0, T1>(arg0: &0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::ownable::AdminCap, arg1: &mut 0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x7892e043a01e97766065f348a7cc634495b62e4a6763ef3dbe2104a4476a10bd::oracle_driven_pool::migrate<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

