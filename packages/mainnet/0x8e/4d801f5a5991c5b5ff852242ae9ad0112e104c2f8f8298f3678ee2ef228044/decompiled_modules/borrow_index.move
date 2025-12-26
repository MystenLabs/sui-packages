module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg2: u64) {
        assert!(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

