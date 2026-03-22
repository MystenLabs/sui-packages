module 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::update_asset_paused_state<T0, T1>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::roles::SuperAdminRole, arg1: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg3: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg4: u8) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::update_asset_paused_state<T0, T1>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

