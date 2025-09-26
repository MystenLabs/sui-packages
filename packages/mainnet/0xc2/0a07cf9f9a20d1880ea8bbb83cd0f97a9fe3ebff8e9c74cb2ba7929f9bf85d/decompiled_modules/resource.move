module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::resource {
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

