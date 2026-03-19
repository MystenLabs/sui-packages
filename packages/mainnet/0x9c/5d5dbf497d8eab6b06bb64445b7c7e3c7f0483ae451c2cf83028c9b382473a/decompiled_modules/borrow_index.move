module 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::Decimal, arg2: u64) {
        assert!(0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::le(arg0.value, arg1), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::error::borrow_index_value_going_backwards());
        assert!(arg0.last_updated <= arg2, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::error::borrow_index_time_going_backwards());
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

