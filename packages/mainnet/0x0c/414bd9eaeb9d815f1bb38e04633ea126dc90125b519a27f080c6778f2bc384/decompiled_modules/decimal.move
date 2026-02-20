module 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::decimal {
    public fun register_decimals<T0>(arg0: &0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg1: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg2: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg0);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::decimals_admin::register_decimals<T0>(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

