module 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types {
    struct Tranche has copy, drop, store {
        timestamp: u64,
        amount: u64,
    }

    struct Segment has copy, drop, store {
        amount: u64,
        exponent: u64,
        timestamp: u64,
    }

    public fun new_segment(arg0: u64, arg1: u64, arg2: u64) : Segment {
        Segment{
            amount    : arg0,
            exponent  : arg1,
            timestamp : arg2,
        }
    }

    public fun new_tranche(arg0: u64, arg1: u64) : Tranche {
        Tranche{
            timestamp : arg1,
            amount    : arg0,
        }
    }

    public fun segment_amount(arg0: &Segment) : u64 {
        arg0.amount
    }

    public fun segment_exponent(arg0: &Segment) : u64 {
        arg0.exponent
    }

    public fun segment_timestamp(arg0: &Segment) : u64 {
        arg0.timestamp
    }

    public fun tranche_amount(arg0: &Tranche) : u64 {
        arg0.amount
    }

    public fun tranche_timestamp(arg0: &Tranche) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

