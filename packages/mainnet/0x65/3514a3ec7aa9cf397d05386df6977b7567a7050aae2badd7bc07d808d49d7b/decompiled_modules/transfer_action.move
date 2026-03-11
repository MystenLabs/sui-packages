module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::transfer_action {
    public fun execute_transfer<T0>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<T0>(arg0), 0);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(v0) == 2, 220);
        let v1 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_params(v0);
        assert!(0x1::vector::length<u8>(&v1) == 33, 221);
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_u8(&mut v2);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        assert!(v3 != @0x0, 222);
        let (v4, v5, v6) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_intent<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

