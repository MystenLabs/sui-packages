module 0x782fcde2c848cab9e52a78f1eff69f52ff0c2e6b93c5541cab7f35b97454f6d2::sample_project2 {
    struct SAMPLE_PROJECT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<SAMPLE_PROJECT2>>(0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::new_project_admin_cap<SAMPLE_PROJECT2>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

