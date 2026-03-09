module 0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::DragonBallCollector, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_functional(arg0);
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::asset_admin::update_asset_paused_state<T0, T1>(0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::roles::SuperAdminRole, arg1: &0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::DragonBallCollector, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg3: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg4: u8) {
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_functional(arg1);
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::asset_admin::update_asset_paused_state<T0, T1>(0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

