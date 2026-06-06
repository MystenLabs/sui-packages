module 0x65035d5b13c77f257ead8bd6ef315c0035c37a881455e962f268b8fb1a8ba3ba::seal_policy {
    public fun seal_approve(arg0: vector<u8>, arg1: address, arg2: &0x65035d5b13c77f257ead8bd6ef315c0035c37a881455e962f268b8fb1a8ba3ba::walsocial::Registry, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 == arg1) {
            return
        };
        assert!(0x65035d5b13c77f257ead8bd6ef315c0035c37a881455e962f268b8fb1a8ba3ba::walsocial::is_following(arg2, v0, arg1), 1);
    }

    // decompiled from Move bytecode v7
}

