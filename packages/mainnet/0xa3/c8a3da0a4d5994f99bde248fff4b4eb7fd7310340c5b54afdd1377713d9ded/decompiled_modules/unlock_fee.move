module 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee {
    struct LockedFeeUnlocked has copy, drop {
        cctp_nonce: u64,
        locked_funds_id: address,
        unlock_sequence: u64,
    }

    struct LockedFeeUnlockedWithRefine has copy, drop {
        cctp_nonce: u64,
        locked_funds_id: address,
        unlock_sequence: u64,
        refine_sequence: u64,
    }

    public fun unlock_fee<T0>(arg0: &mut 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::LockedFunds<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg3));
        let v3 = 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee_message::new(arg4, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), arg5, arg6);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::unpack(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::deserialize(v2)) == 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee_message::to_hash(&v3), 0);
        let v4 = 0x2::object::id<0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::LockedFunds<T0>>(&arg2);
        let v5 = 0x2::object::id_to_address(&v4);
        assert!(arg6 >= 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_gas_drop(arg0, arg4), 1);
        assert!(v5 == 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_funds_id(arg0, arg4), 0);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::is_locked_fee_status_created(arg0, arg4), 2);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::release_locked_fee<T0>(arg0, arg4, arg5, arg2, arg7);
        let v6 = LockedFeeUnlocked{
            cctp_nonce      : arg4,
            locked_funds_id : v5,
            unlock_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
        };
        0x2::event::emit<LockedFeeUnlocked>(v6);
    }

    public fun unlock_fee_with_refine<T0>(arg0: &mut 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::LockedFunds<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: u64, arg6: address, arg7: u64, arg8: address, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg3));
        let (v3, v4, v5) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v4), v3);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let v6 = 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee_message::new(arg5, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), arg6, arg7);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::unpack(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::deserialize(v2)) == 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::unlock_fee_message::to_hash(&v6), 0);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::unpack(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::vaa_message::deserialize(v5)) == 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::refine_gas_message::to_hash(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::refine_gas_message::new(arg5, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), arg8, arg9, arg10)), 0);
        assert!(v0 == v3, 3);
        assert!(v1 == v4, 3);
        let v7 = 0x2::object::id<0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::LockedFunds<T0>>(&arg2);
        let v8 = 0x2::object::id_to_address(&v7);
        assert!(arg7 < 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_gas_drop(arg0, arg5), 5);
        assert!(arg9 >= 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_gas_drop(arg0, arg5), 1);
        assert!(v8 == 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_funds_id(arg0, arg5), 0);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::get_locked_fee_addr_dest(arg0, arg5) == arg10, 4);
        assert!(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::is_locked_fee_status_created(arg0, arg5), 2);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::release_locked_fee<T0>(arg0, arg5, arg8, arg2, arg11);
        let v9 = LockedFeeUnlockedWithRefine{
            cctp_nonce      : arg5,
            locked_funds_id : v8,
            unlock_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
            refine_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<LockedFeeUnlockedWithRefine>(v9);
    }

    // decompiled from Move bytecode v6
}

