module 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::revenue_admin::take_revenue<T0, T1>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

