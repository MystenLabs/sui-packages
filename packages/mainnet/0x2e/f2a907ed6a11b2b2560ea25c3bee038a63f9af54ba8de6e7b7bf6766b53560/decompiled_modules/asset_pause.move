module 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset_admin::update_asset_paused_state<T0, T1>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::roles::SuperAdminRole, arg1: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg2: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg3: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg4: u8) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg1);
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset_admin::update_asset_paused_state<T0, T1>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

