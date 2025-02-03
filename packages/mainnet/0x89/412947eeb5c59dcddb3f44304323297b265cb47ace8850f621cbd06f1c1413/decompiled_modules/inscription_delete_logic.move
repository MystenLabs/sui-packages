module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_delete_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionDeleted, arg1: 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg2: &0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription {
        arg1
    }

    public(friend) fun verify(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg1: &0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionDeleted {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::new_inscription_deleted(arg0)
    }

    // decompiled from Move bytecode v6
}

