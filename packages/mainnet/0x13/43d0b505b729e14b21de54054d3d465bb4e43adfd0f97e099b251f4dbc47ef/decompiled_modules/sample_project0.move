module 0x1343d0b505b729e14b21de54054d3d465bb4e43adfd0f97e099b251f4dbc47ef::sample_project0 {
    struct SAMPLE_PROJECT0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3ffbdc7845f2a7ec6c78f71c02dbb702b48dd337f1540aae6af911a716233e8c::roles::ProjectAdminCap<SAMPLE_PROJECT0>>(0x3ffbdc7845f2a7ec6c78f71c02dbb702b48dd337f1540aae6af911a716233e8c::roles::new_project_admin_cap<SAMPLE_PROJECT0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

