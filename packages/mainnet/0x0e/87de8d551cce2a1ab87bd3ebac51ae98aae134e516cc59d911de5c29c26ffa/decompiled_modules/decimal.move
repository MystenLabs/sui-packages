module 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::decimal {
    public fun register_decimals<T0>(arg0: &0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::DragonBallCollector, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_can_summon_shenron(arg0);
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::decimals_admin::register_decimals<T0>(0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

