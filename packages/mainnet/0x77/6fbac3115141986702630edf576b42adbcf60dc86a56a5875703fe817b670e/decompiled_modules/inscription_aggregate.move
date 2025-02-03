module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_aggregate {
    public entry fun delete(arg0: 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_delete_logic::verify(&arg0, arg1);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::drop_inscription(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_delete_logic::mutate(&v0, arg0, arg1));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::emit_inscription_deleted(v0);
    }

    public entry fun mint(arg0: u8, arg1: u64, arg2: u64, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_mint_logic::verify(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_mint_logic::mutate(&v0, arg6);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::set_inscription_minted_id(&mut v0, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::id(&v1));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::transfer_object(v1, 0x2::tx_context::sender(arg6));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::emit_inscription_minted(v0);
    }

    // decompiled from Move bytecode v6
}

