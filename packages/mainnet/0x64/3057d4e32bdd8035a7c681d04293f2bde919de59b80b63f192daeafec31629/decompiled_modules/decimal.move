module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::decimal {
    public fun register_decimals<T0>(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::decimals_admin::register_decimals<T0>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::decimals_admin::register_decimals_with_currency<T0>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

