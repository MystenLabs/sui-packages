module 0x61f98b95eadd6fb30f0ccd33e27b32eebfc4f7cae056df59f3a4d74c62e26a84::sui_daos {
    public fun create_dao(arg0: &mut 0x61f98b95eadd6fb30f0ccd33e27b32eebfc4f7cae056df59f3a4d74c62e26a84::governance::GovernanceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x61f98b95eadd6fb30f0ccd33e27b32eebfc4f7cae056df59f3a4d74c62e26a84::governance::is_whitelisted(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    // decompiled from Move bytecode v6
}

