module 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::unlock {
    struct OrderUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun unlock<T0>(arg0: &mut 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::State, arg1: 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::LockedFunds<T0>, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg2);
        0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6) = 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::unlock_message::unpack(0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::unlock_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::has_source_order(arg0, v3), 1);
        assert!(0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::get_source_order_status(arg0, v3) == 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::source_order_status_created(), 2);
        assert!(0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::get_source_order_token_in(arg0, v3) == v5, 3);
        assert!(0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::LockedFunds<T0>>(&arg1), 4);
        0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::state::unlock_source_order<T0>(arg0, arg1, v3, v6, arg3);
        let v7 = OrderUnlocked{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg2),
        };
        0x2::event::emit<OrderUnlocked>(v7);
    }

    // decompiled from Move bytecode v6
}

