module 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::decimal {
    public fun register_decimals<T0>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::decimals_admin::register_decimals<T0>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::decimals_admin::register_decimals_with_currency<T0>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

