module 0xb299084d61d936fcc24510d08ca928cee245aa2ecb836db8c8873464c46e90ab::dummy_project {
    struct DUMMY_PROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x584527cda0e8a467f7e3f01baee93d86b0bce219c5238c6c722223ce7dc7748f::roles::ProjectAdminCap<DUMMY_PROJECT>>(0x584527cda0e8a467f7e3f01baee93d86b0bce219c5238c6c722223ce7dc7748f::roles::new_project_admin_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x584527cda0e8a467f7e3f01baee93d86b0bce219c5238c6c722223ce7dc7748f::roles::AirdropTokenWithdrawCap<DUMMY_PROJECT>>(0x584527cda0e8a467f7e3f01baee93d86b0bce219c5238c6c722223ce7dc7748f::roles::new_airdrop_token_withdraw_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

