module 0x15c207f8f4ae9ea65bbc3438d288f6cda3726c787fc2742b100f92935bafda11::sui_daos {
    public fun create_dao(arg0: &mut 0x15c207f8f4ae9ea65bbc3438d288f6cda3726c787fc2742b100f92935bafda11::governance::GovernanceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x15c207f8f4ae9ea65bbc3438d288f6cda3726c787fc2742b100f92935bafda11::governance::is_whitelisted(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    // decompiled from Move bytecode v6
}

