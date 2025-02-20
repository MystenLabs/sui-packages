module 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock {
    struct OrderUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun unlock<T0>(arg0: &mut 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::State, arg1: &0x52646a9931b961c292e202dd8cd36351a9ac74912e71cdd6694e3515546b63c5::state::FeeManagerState, arg2: 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::SourceLockedFunds<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: &mut 0x2::tx_context::TxContext) {
        0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, v8, v9, _, _) = 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_message::unpack(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::has_source_order(arg0, v3), 1);
        assert!(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_source_order_status(arg0, v3) == 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::source_order_status_created(), 2);
        assert!(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_source_order_token_in(arg0, v3) == v5, 3);
        assert!(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_source_order_chain_dest(arg0, v3) == v0, 0);
        let v12 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3);
        assert!(v5 == 0x2::object::id_to_address(&v12), 5);
        assert!(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::SourceLockedFunds<T0>>(&arg2), 4);
        0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::unlock_source_order<T0>(arg0, arg1, arg2, v3, v6, v7, v8, v9, arg5);
        let v13 = OrderUnlocked{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<OrderUnlocked>(v13);
    }

    // decompiled from Move bytecode v6
}

