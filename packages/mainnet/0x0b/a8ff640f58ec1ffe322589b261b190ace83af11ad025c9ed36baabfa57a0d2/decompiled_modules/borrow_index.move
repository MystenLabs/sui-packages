module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        last_updated: u64,
    }

    public fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg2: u64) {
        assert!(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::le(arg0.value, arg1), 13906834324667236351);
        assert!(arg0.last_updated <= arg2, 13906834328962203647);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public fun value(arg0: &BorrowIndex) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

