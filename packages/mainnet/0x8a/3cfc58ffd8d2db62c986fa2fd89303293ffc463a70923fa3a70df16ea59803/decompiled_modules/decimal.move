module 0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::decimal {
    public fun register_decimals<T0>(arg0: &0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::DragonBallCollector, arg1: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_can_summon_shenron(arg0);
        0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::decimals_admin::register_decimals<T0>(0x8a3cfc58ffd8d2db62c986fa2fd89303293ffc463a70923fa3a70df16ea59803::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

