module 0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::psm_pool {
    struct PsmPool has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, PsmPoolObjectInfo>,
    }

    struct PsmPoolObjectInfo has drop, store {
        pool: 0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::share::SharedObjectRef,
    }

    public fun modify_psm_pool_obj(arg0: &mut PsmPool, arg1: &0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::admin::AdminCap, arg2: 0x1::string::String, arg3: PsmPoolObjectInfo) {
        if (0x2::table::contains<0x1::string::String, PsmPoolObjectInfo>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, PsmPoolObjectInfo>(&mut arg0.table, arg2, arg3);
    }

    public fun new_psm_pool_object_info(arg0: &0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::admin::AdminCap, arg1: 0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::share::SharedObjectRef) : PsmPoolObjectInfo {
        PsmPoolObjectInfo{pool: arg1}
    }

    // decompiled from Move bytecode v6
}

