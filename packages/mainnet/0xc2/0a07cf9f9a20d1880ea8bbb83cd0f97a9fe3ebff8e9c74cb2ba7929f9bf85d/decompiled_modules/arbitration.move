module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration {
    public fun FEE(arg0: bool) {
        assert!(arg0, 1103);
    }

    public fun GUARD(arg0: bool) {
        assert!(arg0, 1105);
    }

    public fun GUARD_COUNT(arg0: u64) {
        assert!(arg0 < 16, 1101);
    }

    public fun NOT_MATCH(arg0: bool) {
        assert!(arg0, 1104);
    }

    public fun PAUSED(arg0: bool) {
        assert!(!arg0, 1102);
    }

    public fun TREASURY(arg0: bool) {
        assert!(arg0, 1100);
    }

    // decompiled from Move bytecode v6
}

