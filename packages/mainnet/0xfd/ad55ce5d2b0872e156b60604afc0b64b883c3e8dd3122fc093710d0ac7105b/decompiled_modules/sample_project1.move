module 0xfdad55ce5d2b0872e156b60604afc0b64b883c3e8dd3122fc093710d0ac7105b::sample_project1 {
    struct SAMPLE_PROJECT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x362c88679a0a010c8f09b561cbb09b3d5d1e1885c3096869c9776e16e3d83fe3::roles::ProjectAdminCap<SAMPLE_PROJECT1>>(0x362c88679a0a010c8f09b561cbb09b3d5d1e1885c3096869c9776e16e3d83fe3::roles::new_project_admin_cap<SAMPLE_PROJECT1>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

