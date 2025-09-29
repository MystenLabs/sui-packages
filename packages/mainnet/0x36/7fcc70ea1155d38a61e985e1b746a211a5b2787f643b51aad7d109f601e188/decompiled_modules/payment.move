module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::payment {
    public fun COUNTS_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1700);
    }

    public fun FOR_OBJECT_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1703);
    }

    public fun FROM_OBEJCT_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1704);
    }

    public fun NOT_MATCH(arg0: bool) {
        assert!(arg0, 1702);
    }

    public fun REC_COUNT(arg0: u64) {
        assert!(arg0 <= 200, 1701);
    }

    // decompiled from Move bytecode v6
}

