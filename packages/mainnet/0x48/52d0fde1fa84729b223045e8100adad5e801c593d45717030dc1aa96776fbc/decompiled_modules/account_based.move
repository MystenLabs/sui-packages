module 0x4852d0fde1fa84729b223045e8100adad5e801c593d45717030dc1aa96776fbc::account_based {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0 == 0x2::bcs::to_bytes<address>(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v7
}

