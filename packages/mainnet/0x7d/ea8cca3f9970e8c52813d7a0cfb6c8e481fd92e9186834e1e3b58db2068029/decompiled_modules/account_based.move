module 0x7dea8cca3f9970e8c52813d7a0cfb6c8e481fd92e9186834e1e3b58db2068029::account_based {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0 == 0x2::bcs::to_bytes<address>(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

