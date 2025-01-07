module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issue_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued, arg1: &mut 0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::Certificate {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::new_certificate(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscription_id(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscription_hash(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::slot_number(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::round(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscriber(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscription_timestamp(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::amount(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscription_nonce(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issued::inscription_content(arg0), arg1)
    }

    public(friend) fun verify(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String, arg9: &0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::CertificateIssued {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::new_certificate_issued(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

