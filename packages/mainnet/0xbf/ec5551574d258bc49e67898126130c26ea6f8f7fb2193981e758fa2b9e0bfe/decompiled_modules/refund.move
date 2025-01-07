module 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::refund {
    struct OrderRefunded has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun refund<T0>(arg0: &mut 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::State, arg1: 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::LockedFunds<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, _, _) = 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::cancel_message::unpack(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::cancel_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::has_source_order(arg0, v3), 1);
        assert!(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_source_order_status(arg0, v3) == 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::source_order_status_created(), 2);
        assert!(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_source_order_trader(arg0, v3) == v6, 3);
        assert!(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_source_order_token_in(arg0, v3) == v5, 4);
        assert!(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::LockedFunds<T0>>(&arg1), 5);
        let v10 = OrderRefunded{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
        };
        0x2::event::emit<OrderRefunded>(v10);
        0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::refund_source_order<T0>(arg0, arg1, v3, v7, 0x2::coin::get_decimals<T0>(arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

