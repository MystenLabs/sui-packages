module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::revenue_admin::take_revenue<T0, T1>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

