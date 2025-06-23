module 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::unlock {
    struct OrderUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun unlock<T0>(arg0: &mut 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::State, arg1: &0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::state::FeeManagerState, arg2: 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::SourceLockedFunds<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: &mut 0x2::tx_context::TxContext) {
        0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, v8, v9, _, _) = 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::unlock_message::unpack(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::unlock_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::has_source_order(arg0, v3), 1);
        assert!(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::get_source_order_status(arg0, v3) == 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::source_order_status_created(), 2);
        assert!(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::get_source_order_token_in(arg0, v3) == v5, 3);
        assert!(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::get_source_order_chain_dest(arg0, v3) == v0, 0);
        let v12 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3);
        assert!(v5 == 0x2::object::id_to_address(&v12), 5);
        assert!(0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::SourceLockedFunds<T0>>(&arg2), 4);
        0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::unlock_source_order<T0>(arg0, arg1, arg2, v3, v6, v7, v8, v9, arg5);
        let v13 = OrderUnlocked{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<OrderUnlocked>(v13);
    }

    // decompiled from Move bytecode v6
}

