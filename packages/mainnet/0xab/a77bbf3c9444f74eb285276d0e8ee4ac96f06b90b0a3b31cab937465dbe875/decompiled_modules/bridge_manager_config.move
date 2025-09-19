module 0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::bridge_manager_config {
    struct BridgeManagerConfig has key {
        id: 0x2::object::UID,
        action_enabled: bool,
    }

    public fun action_enabled(arg0: &BridgeManagerConfig) : bool {
        arg0.action_enabled
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeManagerConfig{
            id             : 0x2::object::new(arg0),
            action_enabled : true,
        };
        0x2::transfer::share_object<BridgeManagerConfig>(v0);
    }

    public fun update_bridge_manager_config(arg0: &0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::admin_cap::AdminCap, arg1: &mut BridgeManagerConfig, arg2: bool) {
        arg1.action_enabled = arg2;
    }

    // decompiled from Move bytecode v6
}

