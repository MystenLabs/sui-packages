module 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::decimal {
    public fun register_decimals<T0>(arg0: &0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::decimals_admin::register_decimals<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

