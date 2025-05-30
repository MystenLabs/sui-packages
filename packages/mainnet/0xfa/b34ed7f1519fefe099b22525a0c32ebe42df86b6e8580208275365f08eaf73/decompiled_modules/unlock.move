module 0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::unlock {
    struct OrderUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun unlock<T0>(arg0: &mut 0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::State, arg1: 0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::LockedFunds<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg3);
        0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6) = 0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::unlock_message::unpack(0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::unlock_message::deserialize(v2));
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::has_source_order(arg0, v3), 1);
        assert!(0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::get_source_order_status(arg0, v3) == 0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::source_order_status_created(), 2);
        assert!(0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::get_source_order_token_in(arg0, v3) == v5, 3);
        let v7 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        assert!(v5 == 0x2::object::id_to_address(&v7), 5);
        assert!(0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::get_source_order_locked_funds_id(arg0, v3) == 0x2::object::id<0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::LockedFunds<T0>>(&arg1), 4);
        0xfab34ed7f1519fefe099b22525a0c32ebe42df86b6e8580208275365f08eaf73::state::unlock_source_order<T0>(arg0, arg1, v3, v6, arg4);
        let v8 = OrderUnlocked{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg3),
        };
        0x2::event::emit<OrderUnlocked>(v8);
    }

    // decompiled from Move bytecode v6
}

