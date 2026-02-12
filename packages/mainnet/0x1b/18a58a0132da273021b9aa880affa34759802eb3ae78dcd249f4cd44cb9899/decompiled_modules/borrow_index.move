module 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal, arg2: u64) {
        assert!(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

