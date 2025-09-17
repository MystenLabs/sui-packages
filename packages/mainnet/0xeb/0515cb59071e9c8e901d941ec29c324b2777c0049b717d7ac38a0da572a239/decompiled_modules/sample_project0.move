module 0xeb0515cb59071e9c8e901d941ec29c324b2777c0049b717d7ac38a0da572a239::sample_project0 {
    struct SAMPLE_PROJECT0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x180450ec0a4c369b41f3a15840619728fa7ee8d047e8553ab7ff09799d11de7c::roles::ProjectAdminCap<SAMPLE_PROJECT0>>(0x180450ec0a4c369b41f3a15840619728fa7ee8d047e8553ab7ff09799d11de7c::roles::new_project_admin_cap<SAMPLE_PROJECT0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

