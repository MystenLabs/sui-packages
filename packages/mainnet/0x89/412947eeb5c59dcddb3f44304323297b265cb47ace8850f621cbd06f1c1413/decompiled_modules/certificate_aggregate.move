module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_aggregate {
    public entry fun issue(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issue_logic::verify(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_issue_logic::mutate(&v0, arg9);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::set_certificate_issued_id(&mut v0, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::id(&v1));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::transfer_object(v1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::certificate_issued_inscriber(&v0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate::emit_certificate_issued(v0);
    }

    // decompiled from Move bytecode v6
}

