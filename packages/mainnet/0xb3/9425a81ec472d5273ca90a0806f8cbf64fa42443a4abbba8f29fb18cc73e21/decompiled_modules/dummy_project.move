module 0xb39425a81ec472d5273ca90a0806f8cbf64fa42443a4abbba8f29fb18cc73e21::dummy_project {
    struct DUMMY_PROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<DUMMY_PROJECT>>(0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::new_project_admin_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::AirdropTokenWithdrawCap<DUMMY_PROJECT>>(0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::new_airdrop_token_withdraw_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

