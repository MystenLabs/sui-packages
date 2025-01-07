module 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_basis {
    struct RoyaltyBasis<phantom T0: drop> has drop {
        basis: u64,
    }

    public fun basis<T0: drop>(arg0: &RoyaltyBasis<T0>) : u64 {
        arg0.basis
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64) : RoyaltyBasis<T0> {
        RoyaltyBasis<T0>{basis: arg1}
    }

    // decompiled from Move bytecode v6
}

