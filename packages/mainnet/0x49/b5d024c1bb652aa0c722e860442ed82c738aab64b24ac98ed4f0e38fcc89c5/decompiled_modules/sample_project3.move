module 0x49b5d024c1bb652aa0c722e860442ed82c738aab64b24ac98ed4f0e38fcc89c5::sample_project3 {
    struct SAMPLE_PROJECT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_PROJECT3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3ac3024ca31a200b2b5e0298f50562e55d56de089bb8b0fcdb755b46c5712b88::roles::ProjectAdminCap<SAMPLE_PROJECT3>>(0x3ac3024ca31a200b2b5e0298f50562e55d56de089bb8b0fcdb755b46c5712b88::roles::new_project_admin_cap<SAMPLE_PROJECT3>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x3ac3024ca31a200b2b5e0298f50562e55d56de089bb8b0fcdb755b46c5712b88::roles::AirdropTokenWithdrawCap<SAMPLE_PROJECT3>>(0x3ac3024ca31a200b2b5e0298f50562e55d56de089bb8b0fcdb755b46c5712b88::roles::new_airdrop_token_withdraw_cap<SAMPLE_PROJECT3>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

