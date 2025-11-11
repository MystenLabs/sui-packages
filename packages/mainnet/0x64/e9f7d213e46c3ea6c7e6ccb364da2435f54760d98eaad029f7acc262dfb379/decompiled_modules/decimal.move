module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::decimal {
    public fun register_decimals<T0>(arg0: &0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::decimals_admin::register_decimals<T0>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

