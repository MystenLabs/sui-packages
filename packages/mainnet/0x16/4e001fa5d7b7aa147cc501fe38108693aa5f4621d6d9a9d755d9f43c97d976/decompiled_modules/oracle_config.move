module 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::oracle_config {
    struct OracleConfig has key {
        id: 0x2::object::UID,
        price_service_endpoint: 0x1::string::String,
        pyth_state_id: 0x1::string::String,
        wormhole_state_id: 0x1::string::String,
        pyth_rule_package_id: 0x1::string::String,
        pyth_rule_config_obj: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef,
    }

    public fun modify_price_service_endpoint(arg0: &mut OracleConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.price_service_endpoint = arg2;
    }

    public fun modify_pyth_rule_config_obj(arg0: &mut OracleConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef) {
        arg0.pyth_rule_config_obj = arg2;
    }

    public fun modify_pyth_rule_package_id(arg0: &mut OracleConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.pyth_rule_package_id = arg2;
    }

    public fun modify_pyth_state_id(arg0: &mut OracleConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.pyth_state_id = arg2;
    }

    public fun modify_wormhole_state_id(arg0: &mut OracleConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String) {
        arg0.wormhole_state_id = arg2;
    }

    public fun new_oracle_config(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id                     : 0x2::object::new(arg5),
            price_service_endpoint : arg0,
            pyth_state_id          : arg1,
            wormhole_state_id      : arg2,
            pyth_rule_package_id   : arg3,
            pyth_rule_config_obj   : arg4,
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

