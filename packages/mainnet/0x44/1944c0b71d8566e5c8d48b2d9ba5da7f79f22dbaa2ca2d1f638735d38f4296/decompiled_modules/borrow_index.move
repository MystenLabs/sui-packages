module 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg2: u64) {
        assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

