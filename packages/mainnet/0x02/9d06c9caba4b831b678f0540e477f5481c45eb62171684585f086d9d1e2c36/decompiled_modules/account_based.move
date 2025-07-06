module 0x29d06c9caba4b831b678f0540e477f5481c45eb62171684585f086d9d1e2c36::account_based {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0 == 0x2::bcs::to_bytes<address>(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

