module 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::decimal {
    public fun register_decimals<T0>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::decimals_admin::register_decimals<T0>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

