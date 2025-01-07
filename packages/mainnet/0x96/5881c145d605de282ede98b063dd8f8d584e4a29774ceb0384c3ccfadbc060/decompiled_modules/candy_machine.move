module 0x965881c145d605de282ede98b063dd8f8d584e4a29774ceb0384c3ccfadbc060::candy_machine {
    struct CandyMachine has store, key {
        id: 0x2::object::UID,
        box_ids: vector<0x2::object::ID>,
    }

    public fun create_candy_machine(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CandyMachine{
            id      : 0x2::object::new(arg0),
            box_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CandyMachine>(v0);
    }

    public fun get_candy(arg0: &mut CandyMachine, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = &mut arg0.box_ids;
        let v2 = 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<0x2::object::ID>(v1));
        let v3 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v1, v2));
        if (0x1::vector::is_empty<u256>(v3)) {
            0x1::vector::destroy_empty<u256>(0x2::dynamic_field::remove<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v1, v2)));
            0x1::vector::swap_remove<0x2::object::ID>(v1, v2);
        };
        0x1::vector::swap_remove<u256>(v3, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u256>(v3)))
    }

    public fun has_candies(arg0: &CandyMachine) : bool {
        !0x1::vector::is_empty<0x2::object::ID>(&arg0.box_ids)
    }

    public fun load_candies(arg0: &mut CandyMachine, arg1: vector<u256>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.box_ids;
        let v1 = 0;
        while (!0x1::vector::is_empty<u256>(&arg1)) {
            if (0x1::vector::length<0x2::object::ID>(v0) >= v1) {
                let v2 = 0x2::object::new(arg2);
                let v3 = 0x2::object::uid_to_inner(&v2);
                0x2::object::delete(v2);
                0x1::vector::push_back<0x2::object::ID>(v0, v3);
                0x2::dynamic_field::add<0x2::object::ID, vector<u256>>(&mut arg0.id, v3, 0x1::vector::empty<u256>());
            };
            let v4 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, vector<u256>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(v0, v1));
            while (!0x1::vector::is_empty<u256>(&arg1) && 0x1::vector::length<u256>(v4) <= 5000) {
                0x1::vector::push_back<u256>(v4, 0x1::vector::pop_back<u256>(&mut arg1));
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

