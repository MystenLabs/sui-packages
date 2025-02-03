module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_mint_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted, arg1: &mut 0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::new_inscription(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::hash(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::slot_number(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::round(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::inscriber(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::timestamp(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::amount(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::nonce(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted::content(arg0), arg1)
    }

    public(friend) fun verify(arg0: u8, arg1: u64, arg2: u64, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted {
        assert!(arg2 <= 385802469, 100);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::new_inscription_minted(arg0, arg1, arg2, arg3, arg4, v0, v1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::hash_util::hash_inscription(arg0, arg1, v0, v1, arg2, arg3))
    }

    // decompiled from Move bytecode v6
}

