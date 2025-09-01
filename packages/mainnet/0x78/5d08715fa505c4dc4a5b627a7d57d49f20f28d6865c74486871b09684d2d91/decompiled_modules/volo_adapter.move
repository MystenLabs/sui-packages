module 0x785d08715fa505c4dc4a5b627a7d57d49f20f28d6865c74486871b09684d2d91::volo_adapter {
    struct VoloAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VoloAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VoloPass has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Volo has drop {
        dummy_field: bool,
    }

    fun err_already_registered() {
        abort 101
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_not_whitelisted_source() {
        abort 102
    }

    // decompiled from Move bytecode v6
}

