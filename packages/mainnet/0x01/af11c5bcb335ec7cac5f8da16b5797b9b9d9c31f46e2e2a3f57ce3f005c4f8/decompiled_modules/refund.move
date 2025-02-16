module 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::refund {
    struct OrderRefunded has copy, drop {
        hash: address,
        vaa_sequence: u64,
        amount_refunded: u64,
    }

    public fun refund<T0>(arg0: &mut 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::State, arg1: 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::SourceLockedFunds<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, _, _) = 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel_message::unpack(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::has_source_order(arg0, v3), 1);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::get_source_order_status(arg0, v3) == 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::source_order_status_created(), 2);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::get_source_order_trader(arg0, v3) == v6, 3);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::get_source_order_chain_dest(arg0, v3) == v0, 0);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::get_source_order_token_in(arg0, v3) == v5, 4);
        assert!(0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::SourceLockedFunds<T0>>(&arg1), 5);
        let (v10, v11) = 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::state::refund_source_order<T0>(arg0, arg1, v3, v7, 0x2::coin::get_decimals<T0>(arg2), arg4);
        let v12 = OrderRefunded{
            hash            : v3,
            vaa_sequence    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
            amount_refunded : v11,
        };
        0x2::event::emit<OrderRefunded>(v12);
        v10
    }

    // decompiled from Move bytecode v6
}

