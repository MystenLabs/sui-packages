module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::permission {
    public fun ADMIN(arg0: bool) {
        assert!(arg0, 1805);
    }

    public fun ADMIN_COUNT(arg0: u64) {
        assert!(arg0 < 64, 1806);
    }

    public fun BUILDER(arg0: bool) {
        assert!(arg0, 1804);
    }

    public fun ENTITY_COUNT(arg0: u64) {
        assert!(arg0 < 2000, 1809);
    }

    public fun INDEX(arg0: u16) {
        assert!(arg0 >= OPEN_FUNC_INDEX_BEGINNING(), 1802);
    }

    public fun INDEX_COUNT(arg0: u64) {
        assert!(arg0 < 200, 1803);
    }

    public fun NOT_MATCH(arg0: bool) {
        assert!(arg0, 1808);
    }

    public fun OPEN_FUNC_INDEX_BEGINNING() : u16 {
        1000
    }

    public fun PERM_COUNT(arg0: u64) {
        assert!(arg0 < 200, 1807);
    }

    public fun P_FAIL(arg0: bool) {
        assert!(arg0, 1800);
    }

    // decompiled from Move bytecode v6
}

