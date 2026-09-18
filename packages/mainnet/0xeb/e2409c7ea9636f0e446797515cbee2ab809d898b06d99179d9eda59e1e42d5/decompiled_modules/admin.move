module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::admin {
    public fun create_oracle(arg0: &mut 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::registry::OracleRegistry, arg1: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::Auth, arg2: 0x1::string::String, arg3: u128, arg4: u8, arg5: u128, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::assert_has<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::ConfigRole>(arg1, 0x2::tx_context::sender(arg7));
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::share(0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::create(arg0, arg2, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::math::rate_1e15(arg3, arg4, arg5, arg6)));
    }

    public fun set_price(arg0: &mut 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle, arg1: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::Auth, arg2: u128, arg3: u8, arg4: u128, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::assert_has<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::ConfigRole>(arg1, 0x2::tx_context::sender(arg6));
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::assert_version(arg0);
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::set_rate(arg0, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::math::rate_1e15(arg2, arg3, arg4, arg5));
    }

    public fun set_rate(arg0: &mut 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle, arg1: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::Auth, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::assert_has<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth::ConfigRole>(arg1, 0x2::tx_context::sender(arg3));
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::assert_version(arg0);
        assert!(arg2 > 0, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_price());
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::set_rate(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

