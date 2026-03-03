module 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::asset_admin::update_asset_paused_state<T0, T1>(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::roles::SuperAdminRole, arg1: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg2: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg3: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg4: u8) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg1);
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::asset_admin::update_asset_paused_state<T0, T1>(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

