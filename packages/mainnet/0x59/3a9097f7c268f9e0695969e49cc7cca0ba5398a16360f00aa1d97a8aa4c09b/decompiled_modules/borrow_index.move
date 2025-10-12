module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        last_updated: u64,
    }

    public fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg2: u64) {
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(arg0.value, arg1), 13906834324667236351);
        assert!(arg0.last_updated <= arg2, 13906834328962203647);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public fun value(arg0: &BorrowIndex) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

