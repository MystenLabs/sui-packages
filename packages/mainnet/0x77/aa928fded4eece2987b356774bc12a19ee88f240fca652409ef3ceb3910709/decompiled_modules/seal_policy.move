module 0x77aa928fded4eece2987b356774bc12a19ee88f240fca652409ef3ceb3910709::seal_policy {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0 == 0x2::bcs::to_bytes<address>(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v7
}

