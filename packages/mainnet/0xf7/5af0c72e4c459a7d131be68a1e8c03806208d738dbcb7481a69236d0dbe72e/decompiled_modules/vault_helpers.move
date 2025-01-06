module 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::vault_helpers {
    public(friend) fun admin_deposit_session_helper<T0, T1>(arg0: &mut 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::SessionFlow<T0, T1>) {
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::assert_move<T0, T1>(arg0);
        if (0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::from_lending_pool<T0, T1>(arg0)) {
            0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::allow_consoom<T0, T1>(arg0);
        } else {
            0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_to_lending_pool<T0, T1>(arg0);
            0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_as_done<T0, T1>(arg0);
        };
    }

    public(friend) fun admin_withdrawal_session_helper<T0, T1>(arg0: u64) : 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::SessionFlow<T0, T1> {
        let v0 = 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::create_session<T0, T1>(0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::move_kind(), arg0);
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_from_lending_pool<T0, T1>(&mut v0);
        v0
    }

    public(friend) fun public_deposit_session_helper<T0, T1>(arg0: &mut 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::SessionFlow<T0, T1>) {
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::assert_deposit<T0, T1>(arg0);
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_as_done<T0, T1>(arg0);
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_to_lending_pool<T0, T1>(arg0);
    }

    public(friend) fun public_withdrawal_session_helper<T0, T1>(arg0: &mut 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::SessionFlow<T0, T1>) {
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::assert_withdrawal<T0, T1>(arg0);
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_as_done<T0, T1>(arg0);
        0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::session_flow::register_from_lending_pool<T0, T1>(arg0);
    }

    // decompiled from Move bytecode v6
}

