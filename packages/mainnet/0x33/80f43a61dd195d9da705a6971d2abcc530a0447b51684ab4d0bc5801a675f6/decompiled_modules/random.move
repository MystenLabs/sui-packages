module 0x3380f43a61dd195d9da705a6971d2abcc530a0447b51684ab4d0bc5801a675f6::random {
    struct RandomEvent has copy, drop, store {
        random_number: u64,
        idempotency_id: 0x1::string::String,
        from: u64,
        to: u64,
    }

    entry fun random_number_in_range(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, arg1, arg2);
        let v2 = RandomEvent{
            random_number  : v1,
            idempotency_id : arg3,
            from           : arg1,
            to             : arg2,
        };
        0x2::event::emit<RandomEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

