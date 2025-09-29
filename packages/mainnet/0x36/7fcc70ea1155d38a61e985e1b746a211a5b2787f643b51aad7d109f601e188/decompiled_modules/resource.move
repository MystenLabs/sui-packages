module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::resource {
    public fun MARK_COUNT(arg0: u64) {
        assert!(arg0 < 600, 2103);
    }

    public fun MARK_LEN(arg0: u64) {
        assert!(arg0 < 200, 2102);
    }

    public fun QUERY_MARK_COUNT(arg0: u64) {
        assert!(arg0 <= 16, 2104);
    }

    public fun RESOURCE_Favor() : vector<u8> {
        b"favor"
    }

    public fun RESOURCE_Launch() : vector<u8> {
        b"launch"
    }

    public fun TAG_COUNT(arg0: u64) {
        assert!(arg0 < 64, 2101);
    }

    public fun TAG_LEN(arg0: u64) {
        assert!(arg0 < 1000, 2100);
    }

    // decompiled from Move bytecode v6
}

