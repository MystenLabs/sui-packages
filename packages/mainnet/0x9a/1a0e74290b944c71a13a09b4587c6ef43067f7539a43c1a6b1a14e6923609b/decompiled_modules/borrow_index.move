module 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg2: u64) {
        assert!(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::le(arg0.value, arg1), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::borrow_index_value_going_backwards());
        assert!(arg0.last_updated <= arg2, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::borrow_index_time_going_backwards());
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

