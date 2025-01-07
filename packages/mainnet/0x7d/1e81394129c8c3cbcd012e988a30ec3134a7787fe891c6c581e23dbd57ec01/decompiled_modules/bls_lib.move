module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib {
    public fun verify_bls_sig(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x2::bls12381::bls12381_min_pk_verify(arg0, arg1, arg2), 0);
    }

    public fun verify_bls_sig_and_get_outcome(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : u64 {
        verify_bls_sig(arg0, arg1, arg2);
        let v0 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::derive_randomness(arg0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::safe_selection(arg3, &v0)
    }

    // decompiled from Move bytecode v6
}

