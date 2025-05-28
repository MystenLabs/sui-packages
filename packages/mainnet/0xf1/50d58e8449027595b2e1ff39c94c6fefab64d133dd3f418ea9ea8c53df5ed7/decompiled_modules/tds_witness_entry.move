module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_witness_entry {
    public fun otc<T0: drop, T1, T2>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T2>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, 0x1::option::Option<0x2::balance::Balance<T2>>, vector<u64>) {
        safety_check<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::balance::Balance<T2>>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        let v1 = b"";
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v1, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7 + 20000, 1);
        let (_, _, _, _, v6, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg2);
        let (v14, v15, v16) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::witness_otc_<T1, T2>(arg2, arg3, arg4, arg5, arg6, 0x2::balance::split<T2>(&mut arg6, 0x2::balance::value<T2>(&arg6) - (((0x2::balance::value<T2>(&arg6) as u128) * (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_fee_bp(v6, arg3) as u128) / 10000) as u64)), arg8, arg9);
        let v17 = v16;
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_witness_otc_event(0x1::type_name::get<T0>(), arg2, arg3, *0x1::vector::borrow<u64>(&v17, 0), *0x1::vector::borrow<u64>(&v17, 1), *0x1::vector::borrow<u64>(&v17, 2), *0x1::vector::borrow<u64>(&v17, 3), arg9);
        (v14, v15, v17)
    }

    fun safety_check<T0: drop, T1, T2>(arg0: T0, arg1: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_witness<T0>(arg1, arg0, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

