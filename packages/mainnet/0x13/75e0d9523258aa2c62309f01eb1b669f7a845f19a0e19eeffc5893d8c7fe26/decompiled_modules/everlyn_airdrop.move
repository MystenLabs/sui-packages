module 0x1375e0d9523258aa2c62309f01eb1b669f7a845f19a0e19eeffc5893d8c7fe26::everlyn_airdrop {
    struct EVERLYN_AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVERLYN_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<EVERLYN_AIRDROP>>(0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::new_project_admin_cap<EVERLYN_AIRDROP>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::AirdropTokenWithdrawCap<EVERLYN_AIRDROP>>(0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::new_airdrop_token_withdraw_cap<EVERLYN_AIRDROP>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

