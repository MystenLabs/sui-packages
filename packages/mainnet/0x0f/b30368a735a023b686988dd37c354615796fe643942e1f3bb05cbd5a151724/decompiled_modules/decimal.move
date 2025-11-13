module 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::decimal {
    public fun register_decimals<T0>(arg0: &0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::decimals_admin::register_decimals<T0>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

