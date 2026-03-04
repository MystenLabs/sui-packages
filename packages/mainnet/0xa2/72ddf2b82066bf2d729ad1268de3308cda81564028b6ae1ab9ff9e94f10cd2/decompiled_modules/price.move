module 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::price {
    struct PriceConfig has key {
        id: 0x2::object::UID,
        table: 0x2::vec_map::VecMap<0x1::string::String, 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef>,
    }

    public fun modify_price_config(arg0: &mut PriceConfig, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String, arg3: 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef) {
        if (0x2::vec_map::contains<0x1::string::String, 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef>(&arg0.table, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef>(&mut arg0.table, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef>(&mut arg0.table, arg2, arg3);
    }

    public fun new_price_config(arg0: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceConfig{
            id    : 0x2::object::new(arg1),
            table : 0x2::vec_map::empty<0x1::string::String, 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef>(),
        };
        0x2::transfer::share_object<PriceConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

