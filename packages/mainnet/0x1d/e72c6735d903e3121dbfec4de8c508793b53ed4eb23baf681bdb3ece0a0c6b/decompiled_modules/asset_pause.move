module 0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg1: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg2: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg0);
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset_admin::update_asset_paused_state<T0, T1>(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::roles::SuperAdminRole, arg1: &0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::DragonBallCollector, arg2: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg3: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::Market<T0>, arg4: u8) {
        0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::ensure_functional(arg1);
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset_admin::update_asset_paused_state<T0, T1>(0xb6f15a830dd527f06a27f5bf388be79e29df8f81bee9364cc45c3ea944bc0312::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

