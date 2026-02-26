module 0x2::ristretto255 {
    struct Scalar has store {
        dummy_field: bool,
    }

    struct G has store {
        dummy_field: bool,
    }

    public fun g_add(arg0: &0x2::group_ops::Element<G>, arg1: &0x2::group_ops::Element<G>) : 0x2::group_ops::Element<G> {
        0x2::group_ops::add<G>(6, arg0, arg1)
    }

    public fun g_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G>) : 0x2::group_ops::Element<G> {
        0x2::group_ops::div<Scalar, G>(6, arg0, arg1)
    }

    public fun g_from_bytes(arg0: &vector<u8>) : 0x2::group_ops::Element<G> {
        0x2::group_ops::from_bytes<G>(6, *arg0, false)
    }

    public fun g_generator() : 0x2::group_ops::Element<G> {
        0x2::group_ops::from_bytes<G>(6, x"e2f2ae0a6abc4e71a884a961c500515f58e30b6aa582dd8db6a65945e08d2d76", true)
    }

    public fun g_identity() : 0x2::group_ops::Element<G> {
        0x2::group_ops::from_bytes<G>(6, x"0000000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun g_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G>) : 0x2::group_ops::Element<G> {
        0x2::group_ops::mul<Scalar, G>(6, arg0, arg1)
    }

    public fun g_neg(arg0: &0x2::group_ops::Element<G>) : 0x2::group_ops::Element<G> {
        let v0 = g_identity();
        g_sub(&v0, arg0)
    }

    public fun g_sub(arg0: &0x2::group_ops::Element<G>, arg1: &0x2::group_ops::Element<G>) : 0x2::group_ops::Element<G> {
        0x2::group_ops::sub<G>(6, arg0, arg1)
    }

    public fun scalar_add(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::add<Scalar>(5, arg0, arg1)
    }

    public fun scalar_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::div<Scalar, Scalar>(5, arg0, arg1)
    }

    public fun scalar_from_bytes(arg0: &vector<u8>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(5, *arg0, false)
    }

    public fun scalar_from_u64(arg0: u64) : 0x2::group_ops::Element<Scalar> {
        let v0 = (arg0 as u256);
        0x2::group_ops::from_bytes<Scalar>(5, 0x2::bcs::to_bytes<u256>(&v0), true)
    }

    public fun scalar_inv(arg0: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        let v0 = scalar_one();
        scalar_div(arg0, &v0)
    }

    public fun scalar_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::mul<Scalar, Scalar>(5, arg0, arg1)
    }

    public fun scalar_neg(arg0: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        let v0 = scalar_zero();
        scalar_sub(&v0, arg0)
    }

    public fun scalar_one() : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(5, x"0100000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun scalar_sub(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::sub<Scalar>(5, arg0, arg1)
    }

    public fun scalar_zero() : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(5, x"0000000000000000000000000000000000000000000000000000000000000000", true)
    }

    // decompiled from Move bytecode v6
}

