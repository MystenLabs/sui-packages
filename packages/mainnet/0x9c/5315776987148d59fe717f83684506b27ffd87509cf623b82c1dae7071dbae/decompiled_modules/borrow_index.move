module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal, arg2: u64) {
        assert!(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::le(arg0.value, arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::borrow_index_value_going_backwards());
        assert!(arg0.last_updated <= arg2, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::borrow_index_time_going_backwards());
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

