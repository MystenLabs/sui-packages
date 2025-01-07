module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib {
    public fun verify_bls_sig(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x2::bls12381::bls12381_min_pk_verify(arg0, arg1, arg2), 0);
    }

    public fun verify_bls_sig_and_get_outcome(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : u64 {
        verify_bls_sig(arg0, arg1, arg2);
        let v0 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::derive_randomness(arg0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::safe_selection(arg3, &v0)
    }

    public fun verify_bls_sig_and_get_outcome_entropy(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        verify_bls_sig(arg0, arg1, arg2);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x1::vector::append<u8>(arg0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x2::object::delete(v0);
        let v2 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::derive_randomness(arg0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::safe_selection(arg3, &v2)
    }

    // decompiled from Move bytecode v6
}

