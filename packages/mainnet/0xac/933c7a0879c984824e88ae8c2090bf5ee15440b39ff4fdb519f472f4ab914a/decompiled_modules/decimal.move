module 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::decimal {
    public fun register_decimals<T0>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::decimals_admin::register_decimals<T0>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

