module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_minted {
    public fun amount(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_amount(arg0)
    }

    public fun content(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : 0x1::string::String {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_content(arg0)
    }

    public fun hash(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : vector<u8> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_hash(arg0)
    }

    public fun id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : 0x1::option::Option<0x2::object::ID> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_id(arg0)
    }

    public fun inscriber(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : address {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_inscriber(arg0)
    }

    public fun nonce(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : u128 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_nonce(arg0)
    }

    public fun round(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_round(arg0)
    }

    public fun slot_number(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : u8 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_slot_number(arg0)
    }

    public fun timestamp(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::InscriptionMinted) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscription_minted_timestamp(arg0)
    }

    // decompiled from Move bytecode v6
}

