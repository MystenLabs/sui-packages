module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
        last_updated: u64,
    }

    public fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal, arg2: u64) {
        assert!(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::le(arg0.value, arg1), 13906834324667236351);
        assert!(arg0.last_updated <= arg2, 13906834328962203647);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public fun value(arg0: &BorrowIndex) : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

