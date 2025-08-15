module 0xbc7834f9d7a512a8eec4c19a88696abeb5081506306361006d3e37a4e1fc12c6::account_based {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0 == 0x2::bcs::to_bytes<address>(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

