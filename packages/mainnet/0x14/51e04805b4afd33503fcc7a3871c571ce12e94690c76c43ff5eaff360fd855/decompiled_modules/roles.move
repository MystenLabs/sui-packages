module 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::roles {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProjectAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_project_admin_cap<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ProjectAdminCap<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 13906834277422596097);
        ProjectAdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

