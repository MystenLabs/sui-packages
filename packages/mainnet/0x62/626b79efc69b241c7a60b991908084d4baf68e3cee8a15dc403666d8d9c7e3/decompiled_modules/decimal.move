module 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::decimal {
    public fun register_decimals<T0>(arg0: &0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::decimals_admin::register_decimals<T0>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

