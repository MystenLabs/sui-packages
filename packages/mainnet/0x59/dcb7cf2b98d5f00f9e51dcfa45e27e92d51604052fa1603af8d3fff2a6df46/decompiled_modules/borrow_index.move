module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::borrow_index {
    struct BorrowIndex has copy, drop, store {
        value: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        last_updated: u64,
    }

    public(friend) fun last_updated(arg0: &BorrowIndex) : u64 {
        arg0.last_updated
    }

    public(friend) fun new(arg0: u64) : BorrowIndex {
        BorrowIndex{
            value        : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::one(),
            last_updated : arg0,
        }
    }

    public(friend) fun set_value(arg0: &mut BorrowIndex, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg2: u64) {
        assert!(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::le(arg0.value, arg1), 13906834286012530687);
        assert!(arg0.last_updated <= arg2, 13906834290307497983);
        arg0.last_updated = arg2;
        arg0.value = arg1;
    }

    public(friend) fun value(arg0: &BorrowIndex) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

