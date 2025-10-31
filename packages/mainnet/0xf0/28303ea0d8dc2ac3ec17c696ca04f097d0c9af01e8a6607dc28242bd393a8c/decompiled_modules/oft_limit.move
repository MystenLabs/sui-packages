module 0xf028303ea0d8dc2ac3ec17c696ca04f097d0c9af01e8a6607dc28242bd393a8c::oft_limit {
    struct OFTLimit has copy, drop, store {
        min_amount_ld: u64,
        max_amount_ld: u64,
    }

    public(friend) fun create(arg0: u64, arg1: u64) : OFTLimit {
        OFTLimit{
            min_amount_ld : arg0,
            max_amount_ld : arg1,
        }
    }

    public fun max_amount_ld(arg0: &OFTLimit) : u64 {
        arg0.max_amount_ld
    }

    public fun min_amount_ld(arg0: &OFTLimit) : u64 {
        arg0.min_amount_ld
    }

    public(friend) fun new_unbounded_oft_limit() : OFTLimit {
        OFTLimit{
            min_amount_ld : 0,
            max_amount_ld : 18446744073709551615,
        }
    }

    // decompiled from Move bytecode v6
}

