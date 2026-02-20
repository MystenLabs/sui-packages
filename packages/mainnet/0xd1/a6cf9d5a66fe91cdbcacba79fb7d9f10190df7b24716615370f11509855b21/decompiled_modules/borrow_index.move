module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: u64) {
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

