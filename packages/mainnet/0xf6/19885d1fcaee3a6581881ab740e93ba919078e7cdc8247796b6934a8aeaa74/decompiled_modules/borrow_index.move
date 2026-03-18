module 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal, arg2: u64) {
        assert!(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::le(arg0.value, arg1), 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::borrow_index_value_going_backwards());
        assert!(arg0.last_updated <= arg2, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::error::borrow_index_time_going_backwards());
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

