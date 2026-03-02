module 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::psm_pool {
    struct PsmPool has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, PsmPoolObjectInfo>,
    }

    struct PsmPoolObjectInfo has drop, store {
        pool: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef,
    }

    public fun modify_psm_pool_obj(arg0: &mut PsmPool, arg1: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg2: 0x1::string::String, arg3: PsmPoolObjectInfo) {
        if (0x2::table::contains<0x1::string::String, PsmPoolObjectInfo>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_psm_pool(arg0: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PsmPool{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::string::String, PsmPoolObjectInfo>(arg1),
        };
        0x2::transfer::share_object<PsmPool>(v0);
    }

    public fun new_psm_pool_object_info(arg0: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg1: 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share::SharedObjectRef) : PsmPoolObjectInfo {
        PsmPoolObjectInfo{pool: arg1}
    }

    // decompiled from Move bytecode v6
}

