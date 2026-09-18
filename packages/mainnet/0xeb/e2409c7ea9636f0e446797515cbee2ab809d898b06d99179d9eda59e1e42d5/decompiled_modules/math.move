module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::math {
    fun pow10(arg0: u32) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun rate_1e15(arg0: u128, arg1: u8, arg2: u128, arg3: u8) : u128 {
        assert!(arg0 > 0 && arg2 > 0, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_price());
        assert!(arg1 <= 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::max_exponent() && arg3 <= 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::max_exponent(), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_exponent());
        let v0 = pow10((0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::constants::rate_output_decimals() as u32)) * (arg0 as u256) * pow10((arg3 as u32)) / pow10((arg1 as u32)) * (arg2 as u256);
        assert!(v0 > 0 && v0 <= 340282366920938463463374607431768211455, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::admin_module_invalid_price());
        (v0 as u128)
    }

    // decompiled from Move bytecode v7
}

