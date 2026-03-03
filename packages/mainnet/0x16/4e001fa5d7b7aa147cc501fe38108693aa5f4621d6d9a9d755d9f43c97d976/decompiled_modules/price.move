module 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::price {
    struct PriceConfig has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef>,
    }

    public fun modify_price_config(arg0: &mut PriceConfig, arg1: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef) {
        if (0x2::table::contains<0x1::string::String, 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef>(&mut arg0.table, arg2, arg3);
    }

    public fun new_price_config(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceConfig{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::string::String, 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share::SharedObjectRef>(arg1),
        };
        0x2::transfer::share_object<PriceConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

