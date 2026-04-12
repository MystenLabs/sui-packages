module 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::script {
    public entry fun add_pool<T0, T1>(arg0: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::add_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun destroy_pool<T0, T1>(arg0: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::AdminCap, arg1: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::assert_version(arg0);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::destroy_pool<T0, T1>(arg0, arg1);
    }

    public entry fun migrate_admin(arg0: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::AdminCap, arg1: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::migrate(arg0, arg1);
    }

    public entry fun migrate_pool<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::AdminCap, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::migrate<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

