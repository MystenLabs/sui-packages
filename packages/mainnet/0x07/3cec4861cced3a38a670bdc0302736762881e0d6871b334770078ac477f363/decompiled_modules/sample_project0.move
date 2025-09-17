module 0x73cec4861cced3a38a670bdc0302736762881e0d6871b334770078ac477f363::sample_project0 {
    struct SAMPLE_PROJECT0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3c4bdf9047c2e45ae413fc322568b576e8070fb3521c5c3b305f6c665ac74a5e::roles::ProjectAdminCap<SAMPLE_PROJECT0>>(0x3c4bdf9047c2e45ae413fc322568b576e8070fb3521c5c3b305f6c665ac74a5e::roles::new_project_admin_cap<SAMPLE_PROJECT0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

