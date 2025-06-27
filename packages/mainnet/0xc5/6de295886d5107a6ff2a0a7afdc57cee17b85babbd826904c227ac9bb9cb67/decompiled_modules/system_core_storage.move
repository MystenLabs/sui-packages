module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage {
    struct Storage has key {
        id: 0x2::object::UID,
        app_cap: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap,
    }

    public(friend) fun get_app_cap(arg0: &Storage) : &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap {
        &arg0.app_cap
    }

    public fun initialize_cap_with_governance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id      : 0x2::object::new(arg2),
            app_cap : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::register_cap_with_governance(arg0, arg1, arg2),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    // decompiled from Move bytecode v6
}

