module 0x82a22b4bd1dda7f424bcac66d299803b8e5b6914140eb6846897d756d1b68c22::random_name_picker {
    struct ResultEvent has copy, drop {
        name: 0x1::string::String,
    }

    entry fun do(arg0: vector<0x1::string::String>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = ResultEvent{name: *0x1::vector::borrow<0x1::string::String>(&arg0, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<0x1::string::String>(&arg0) - 1))};
        0x2::event::emit<ResultEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

