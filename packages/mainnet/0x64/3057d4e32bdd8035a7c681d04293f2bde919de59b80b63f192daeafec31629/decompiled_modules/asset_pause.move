module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::asset_admin::update_asset_paused_state<T0, T1>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::roles::SuperAdminRole, arg1: &0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg2: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg3: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg4: u8) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg1);
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::asset_admin::update_asset_paused_state<T0, T1>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

