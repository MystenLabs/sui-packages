module 0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config {
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

    public fun update_bridge_manager_config(arg0: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::admin_cap::AdminCap, arg1: &mut BridgeManagerConfig, arg2: bool) {
        arg1.action_enabled = arg2;
    }

    // decompiled from Move bytecode v6
}

