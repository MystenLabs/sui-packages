module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::payment {
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

