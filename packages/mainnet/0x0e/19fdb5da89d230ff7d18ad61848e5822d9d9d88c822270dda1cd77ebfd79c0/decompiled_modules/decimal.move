module 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::decimal {
    public fun register_decimals<T0>(arg0: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::decimals_admin::register_decimals<T0>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

