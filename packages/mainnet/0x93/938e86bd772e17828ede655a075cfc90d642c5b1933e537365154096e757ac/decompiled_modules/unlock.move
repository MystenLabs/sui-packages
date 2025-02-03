module 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock {
    struct OrderUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun unlock<T0>(arg0: &mut 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x677adf24b59cdc1208799ff862414e530bebc58100b53528f8753ff3642a11bd::state::FeeManagerState, arg2: 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::SourceLockedFunds<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: &mut 0x2::tx_context::TxContext) {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, v8, v9, _, _) = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_message::unpack(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::has_source_order(arg0, v3), 1);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_status(arg0, v3) == 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::source_order_status_created(), 2);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_token_in(arg0, v3) == v5, 3);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_chain_dest(arg0, v3) == v0, 0);
        let v12 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3);
        assert!(v5 == 0x2::object::id_to_address(&v12), 5);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::SourceLockedFunds<T0>>(&arg2), 4);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::unlock_source_order<T0>(arg0, arg1, arg2, v3, v6, v7, v8, v9, arg5);
        let v13 = OrderUnlocked{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<OrderUnlocked>(v13);
    }

    // decompiled from Move bytecode v6
}

