module 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::revenue_admin::take_revenue<T0, T1>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

