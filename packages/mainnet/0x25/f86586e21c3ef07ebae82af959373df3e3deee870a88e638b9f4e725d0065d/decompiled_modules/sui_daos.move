module 0x25f86586e21c3ef07ebae82af959373df3e3deee870a88e638b9f4e725d0065d::sui_daos {
    public fun create_dao(arg0: &mut 0x25f86586e21c3ef07ebae82af959373df3e3deee870a88e638b9f4e725d0065d::governance::GovernanceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x25f86586e21c3ef07ebae82af959373df3e3deee870a88e638b9f4e725d0065d::governance::is_whitelisted(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    // decompiled from Move bytecode v6
}

