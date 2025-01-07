module 0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_basis {
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

