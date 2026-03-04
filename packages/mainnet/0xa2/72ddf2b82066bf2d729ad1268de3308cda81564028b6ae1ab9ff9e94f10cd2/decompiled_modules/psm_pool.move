module 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::psm_pool {
    struct PsmPool has key {
        id: 0x2::object::UID,
        table: 0x2::vec_map::VecMap<0x1::string::String, PsmPoolObjectInfo>,
    }

    struct PsmPoolObjectInfo has drop, store {
        pool: 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef,
    }

    public fun modify_psm_pool_obj(arg0: &mut PsmPool, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x1::string::String, arg3: PsmPoolObjectInfo) {
        if (0x2::vec_map::contains<0x1::string::String, PsmPoolObjectInfo>(&arg0.table, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_psm_pool(arg0: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PsmPool{
            id    : 0x2::object::new(arg1),
            table : 0x2::vec_map::empty<0x1::string::String, PsmPoolObjectInfo>(),
        };
        0x2::transfer::share_object<PsmPool>(v0);
    }

    public fun new_psm_pool_object_info(arg0: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg1: 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::share::SharedObjectRef) : PsmPoolObjectInfo {
        PsmPoolObjectInfo{pool: arg1}
    }

    // decompiled from Move bytecode v6
}

