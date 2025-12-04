module 0x2::bls12381 {
    struct Scalar {
        dummy_field: bool,
    }

    struct G1 {
        dummy_field: bool,
    }

    struct G2 {
        dummy_field: bool,
    }

    struct GT {
        dummy_field: bool,
    }

    struct UncompressedG1 {
        dummy_field: bool,
    }

    native public fun bls12381_min_pk_verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool;
    native public fun bls12381_min_sig_verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool;
    public fun g1_add(arg0: &0x2::group_ops::Element<G1>, arg1: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::add<G1>(1, arg0, arg1)
    }

    public fun g1_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::div<Scalar, G1>(1, arg0, arg1)
    }

    public fun g1_from_bytes(arg0: &vector<u8>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::from_bytes<G1>(1, *arg0, false)
    }

    public fun g1_generator() : 0x2::group_ops::Element<G1> {
        0x2::group_ops::from_bytes<G1>(1, x"97f1d3a73197d7942695638c4fa9ac0fc3688c4f9774b905a14e3a3f171bac586c55e83ff97a1aeffb3af00adb22c6bb", true)
    }

    public fun g1_identity() : 0x2::group_ops::Element<G1> {
        0x2::group_ops::from_bytes<G1>(1, x"c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun g1_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::mul<Scalar, G1>(1, arg0, arg1)
    }

    public fun g1_multi_scalar_multiplication(arg0: &vector<0x2::group_ops::Element<Scalar>>, arg1: &vector<0x2::group_ops::Element<G1>>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::multi_scalar_multiplication<Scalar, G1>(1, arg0, arg1)
    }

    public fun g1_neg(arg0: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<G1> {
        let v0 = g1_identity();
        g1_sub(&v0, arg0)
    }

    public fun g1_sub(arg0: &0x2::group_ops::Element<G1>, arg1: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::sub<G1>(1, arg0, arg1)
    }

    public fun g1_to_uncompressed_g1(arg0: &0x2::group_ops::Element<G1>) : 0x2::group_ops::Element<UncompressedG1> {
        0x2::group_ops::convert<G1, UncompressedG1>(1, 4, arg0)
    }

    public fun g2_add(arg0: &0x2::group_ops::Element<G2>, arg1: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::add<G2>(2, arg0, arg1)
    }

    public fun g2_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::div<Scalar, G2>(2, arg0, arg1)
    }

    public fun g2_from_bytes(arg0: &vector<u8>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::from_bytes<G2>(2, *arg0, false)
    }

    public fun g2_generator() : 0x2::group_ops::Element<G2> {
        0x2::group_ops::from_bytes<G2>(2, x"93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8", true)
    }

    public fun g2_identity() : 0x2::group_ops::Element<G2> {
        0x2::group_ops::from_bytes<G2>(2, x"c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun g2_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::mul<Scalar, G2>(2, arg0, arg1)
    }

    public fun g2_multi_scalar_multiplication(arg0: &vector<0x2::group_ops::Element<Scalar>>, arg1: &vector<0x2::group_ops::Element<G2>>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::multi_scalar_multiplication<Scalar, G2>(2, arg0, arg1)
    }

    public fun g2_neg(arg0: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<G2> {
        let v0 = g2_identity();
        g2_sub(&v0, arg0)
    }

    public fun g2_sub(arg0: &0x2::group_ops::Element<G2>, arg1: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::sub<G2>(2, arg0, arg1)
    }

    public fun gt_add(arg0: &0x2::group_ops::Element<GT>, arg1: &0x2::group_ops::Element<GT>) : 0x2::group_ops::Element<GT> {
        0x2::group_ops::add<GT>(3, arg0, arg1)
    }

    public fun gt_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<GT>) : 0x2::group_ops::Element<GT> {
        0x2::group_ops::div<Scalar, GT>(3, arg0, arg1)
    }

    public fun gt_generator() : 0x2::group_ops::Element<GT> {
        0x2::group_ops::from_bytes<GT>(3, x"1250ebd871fc0a92a7b2d83168d0d727272d441befa15c503dd8e90ce98db3e7b6d194f60839c508a84305aaca1789b6089a1c5b46e5110b86750ec6a532348868a84045483c92b7af5af689452eafabf1a8943e50439f1d59882a98eaa0170f19f26337d205fb469cd6bd15c3d5a04dc88784fbb3d0b2dbdea54d43b2b73f2cbb12d58386a8703e0f948226e47ee89d06fba23eb7c5af0d9f80940ca771b6ffd5857baaf222eb95a7d2809d61bfe02e1bfd1b68ff02f0b8102ae1c2d5d5ab1a1368bb445c7c2d209703f239689ce34c0378a68e72a6b3b216da0e22a5031b54ddff57309396b38c881c4c849ec23e87193502b86edb8857c273fa075a50512937e0794e1e65a7617c90d8bd66065b1fffe51d7a579973b1315021ec3c19934f11b8b424cd48bf38fcef68083b0b0ec5c81a93b330ee1a677d0d15ff7b984e8978ef48881e32fac91b93b47333e2ba5703350f55a7aefcd3c31b4fcb6ce5771cc6a0e9786ab5973320c806ad360829107ba810c5a09ffdd9be2291a0c25a99a201b2f522473d171391125ba84dc4007cfbf2f8da752f7c74185203fcca589ac719c34dffbbaad8431dad1c1fb597aaa5018107154f25a764bd3c79937a45b84546da634b8f6be14a8061e55cceba478b23f7dacaa35c8ca78beae9624045b4b604c581234d086a9902249b64728ffd21a189e87935a954051c7cdba7b3872629a4fafc05066245cb9108f0242d0fe3ef0f41e58663bf08cf068672cbd01a7ec73baca4d72ca93544deff686bfd6df543d48eaa24afe47e1efde449383b676631", true)
    }

    public fun gt_identity() : 0x2::group_ops::Element<GT> {
        0x2::group_ops::from_bytes<GT>(3, x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun gt_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<GT>) : 0x2::group_ops::Element<GT> {
        0x2::group_ops::mul<Scalar, GT>(3, arg0, arg1)
    }

    public fun gt_neg(arg0: &0x2::group_ops::Element<GT>) : 0x2::group_ops::Element<GT> {
        let v0 = gt_identity();
        gt_sub(&v0, arg0)
    }

    public fun gt_sub(arg0: &0x2::group_ops::Element<GT>, arg1: &0x2::group_ops::Element<GT>) : 0x2::group_ops::Element<GT> {
        0x2::group_ops::sub<GT>(3, arg0, arg1)
    }

    public fun hash_to_g1(arg0: &vector<u8>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::hash_to<G1>(1, arg0)
    }

    public fun hash_to_g2(arg0: &vector<u8>) : 0x2::group_ops::Element<G2> {
        0x2::group_ops::hash_to<G2>(2, arg0)
    }

    public fun pairing(arg0: &0x2::group_ops::Element<G1>, arg1: &0x2::group_ops::Element<G2>) : 0x2::group_ops::Element<GT> {
        0x2::group_ops::pairing<G1, G2, GT>(1, arg0, arg1)
    }

    public fun scalar_add(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::add<Scalar>(0, arg0, arg1)
    }

    public fun scalar_div(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::div<Scalar, Scalar>(0, arg0, arg1)
    }

    public fun scalar_from_bytes(arg0: &vector<u8>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(0, *arg0, false)
    }

    public fun scalar_from_u64(arg0: u64) : 0x2::group_ops::Element<Scalar> {
        let v0 = x"0000000000000000000000000000000000000000000000000000000000000000";
        0x2::group_ops::set_as_prefix(arg0, true, &mut v0);
        0x2::group_ops::from_bytes<Scalar>(0, v0, true)
    }

    public fun scalar_inv(arg0: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        let v0 = scalar_one();
        scalar_div(arg0, &v0)
    }

    public fun scalar_mul(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::mul<Scalar, Scalar>(0, arg0, arg1)
    }

    public fun scalar_neg(arg0: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        let v0 = scalar_zero();
        scalar_sub(&v0, arg0)
    }

    public fun scalar_one() : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(0, x"0000000000000000000000000000000000000000000000000000000000000001", true)
    }

    public fun scalar_sub(arg0: &0x2::group_ops::Element<Scalar>, arg1: &0x2::group_ops::Element<Scalar>) : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::sub<Scalar>(0, arg0, arg1)
    }

    public fun scalar_zero() : 0x2::group_ops::Element<Scalar> {
        0x2::group_ops::from_bytes<Scalar>(0, x"0000000000000000000000000000000000000000000000000000000000000000", true)
    }

    public fun uncompressed_g1_sum(arg0: &vector<0x2::group_ops::Element<UncompressedG1>>) : 0x2::group_ops::Element<UncompressedG1> {
        0x2::group_ops::sum<UncompressedG1>(4, arg0)
    }

    public fun uncompressed_g1_to_g1(arg0: &0x2::group_ops::Element<UncompressedG1>) : 0x2::group_ops::Element<G1> {
        0x2::group_ops::convert<UncompressedG1, G1>(4, 1, arg0)
    }

    // decompiled from Move bytecode v6
}

