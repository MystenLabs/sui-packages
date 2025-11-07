module 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg2: u64) {
        assert!(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

