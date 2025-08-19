module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        last_updated: u64,
    }

    public fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg2: u64) {
        assert!(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::le(arg0.value, arg1), 13906834324667236351);
        assert!(arg0.last_updated <= arg2, 13906834328962203647);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public fun value(arg0: &BorrowIndex) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

