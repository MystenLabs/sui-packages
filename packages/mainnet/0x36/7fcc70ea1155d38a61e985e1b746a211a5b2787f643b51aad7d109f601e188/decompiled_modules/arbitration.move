module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arbitration {
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

