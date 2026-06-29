module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::announcement_indexer {
    struct AnnouncementIndexer has key {
        id: 0x2::object::UID,
        high_water_mark: u64,
    }

    struct CursorAdvanced has copy, drop {
        old_mark: u64,
        new_mark: u64,
    }

    struct ScanPage has copy, drop {
        after_id: u64,
        limit: u64,
        returned: u64,
        last_id: u64,
    }

    public(friend) entry fun advance_cursor(arg0: &mut AnnouncementIndexer, arg1: u64) {
        assert!(arg1 >= arg0.high_water_mark, 1);
        if (arg1 == arg0.high_water_mark) {
            return
        };
        arg0.high_water_mark = arg1;
        let v0 = CursorAdvanced{
            old_mark : arg0.high_water_mark,
            new_mark : arg1,
        };
        0x2::event::emit<CursorAdvanced>(v0);
    }

    public fun high_water_mark(arg0: &AnnouncementIndexer) : u64 {
        arg0.high_water_mark
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnnouncementIndexer{
            id              : 0x2::object::new(arg0),
            high_water_mark : 0,
        };
        0x2::transfer::share_object<AnnouncementIndexer>(v0);
    }

    public fun scan(arg0: &AnnouncementIndexer, arg1: u64, arg2: u64) : vector<u64> {
        assert!(arg2 > 0, 2);
        let v0 = if (arg2 <= 256) {
            arg2
        } else {
            256
        };
        let v1 = arg0.high_water_mark;
        if (arg1 >= v1) {
            return 0x1::vector::empty<u64>()
        };
        let v2 = v1 - arg1;
        let v3 = if (v2 <= v0) {
            v2
        } else {
            v0
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < v3) {
            0x1::vector::push_back<u64>(&mut v4, arg1 + 1 + v5);
            v5 = v5 + 1;
        };
        let v6 = if (0x1::vector::length<u64>(&v4) > 0) {
            *0x1::vector::borrow<u64>(&v4, 0x1::vector::length<u64>(&v4) - 1)
        } else {
            arg1
        };
        let v7 = ScanPage{
            after_id : arg1,
            limit    : v0,
            returned : 0x1::vector::length<u64>(&v4),
            last_id  : v6,
        };
        0x2::event::emit<ScanPage>(v7);
        v4
    }

    // decompiled from Move bytecode v7
}

