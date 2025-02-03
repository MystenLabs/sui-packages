module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::unlock_fee {
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

    public fun unlock_fee<T0>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::LockedFunds<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg3));
        let (v3, v4, v5, v6) = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::unlock_fee_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::unlock_fee_message::deserialize(v2));
        let v7 = 0x2::object::id<0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::LockedFunds<T0>>(&arg2);
        let v8 = 0x2::object::id_to_address(&v7);
        assert!(v4 == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 1);
        assert!(v6 >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_gas_drop(arg0, v3), 2);
        assert!(v8 == 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_funds_id(arg0, v3), 0);
        assert!(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_locked_fee_status_created(arg0, v3), 3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::release_locked_fee<T0>(arg0, v3, v5, arg2, arg4);
        let v9 = LockedFeeUnlocked{
            cctp_nonce      : v3,
            locked_funds_id : v8,
            unlock_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
        };
        0x2::event::emit<LockedFeeUnlocked>(v9);
    }

    public fun unlock_fee_with_refine<T0>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::LockedFunds<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg3));
        let (v3, v4, v5) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v4), v3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let (v6, v7, _, v9) = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::unlock_fee_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::unlock_fee_message::deserialize(v2));
        let (v10, v11, v12, v13, v14) = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::refine_gas_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::refine_gas_message::deserialize(v5));
        assert!(v0 == v3, 4);
        assert!(v1 == v4, 4);
        assert!(v6 == v10, 4);
        assert!(v7 == v11, 4);
        let v15 = 0x2::object::id<0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::LockedFunds<T0>>(&arg2);
        let v16 = 0x2::object::id_to_address(&v15);
        assert!(v7 == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 1);
        assert!(v9 < 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_gas_drop(arg0, v6), 6);
        assert!(v13 >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_gas_drop(arg0, v6), 2);
        assert!(v16 == 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_funds_id(arg0, v6), 0);
        assert!(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_locked_fee_addr_dest(arg0, v6) == v14, 5);
        assert!(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_locked_fee_status_created(arg0, v6), 3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::release_locked_fee<T0>(arg0, v6, v12, arg2, arg5);
        let v17 = LockedFeeUnlockedWithRefine{
            cctp_nonce      : v6,
            locked_funds_id : v16,
            unlock_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
            refine_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<LockedFeeUnlockedWithRefine>(v17);
    }

    // decompiled from Move bytecode v6
}

