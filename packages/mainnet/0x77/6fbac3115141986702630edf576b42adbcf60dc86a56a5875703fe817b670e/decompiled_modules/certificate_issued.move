module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued {
    public fun amount(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_amount(arg0)
    }

    public fun id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : 0x1::option::Option<0x2::object::ID> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_id(arg0)
    }

    public fun inscriber(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : address {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscriber(arg0)
    }

    public fun inscription_content(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : 0x1::string::String {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscription_content(arg0)
    }

    public fun inscription_hash(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : vector<u8> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscription_hash(arg0)
    }

    public fun inscription_id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : 0x2::object::ID {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscription_id(arg0)
    }

    public fun inscription_nonce(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : u128 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscription_nonce(arg0)
    }

    public fun inscription_timestamp(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscription_timestamp(arg0)
    }

    public fun round(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_round(arg0)
    }

    public fun slot_number(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued) : u8 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_slot_number(arg0)
    }

    // decompiled from Move bytecode v6
}

