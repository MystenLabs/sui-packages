module 0xf4e9b0f400bd372ac905eb3cfde7dedfbba59ce297d0c48bc5ad41cf0da5c56a::oft_limit {
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

