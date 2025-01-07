module 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::purchase_alphabet {
    fun get_alphabet_acquisition_cost(arg0: u8) : u64 {
        if (arg0 == 0) {
            5
        } else if (arg0 == 1) {
            30
        } else {
            0
        }
    }

    fun purchase(arg0: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player, arg1: u64, arg2: u8, arg3: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::PointManager, arg4: &mut 0x2::tx_context::TxContext) : 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet {
        let v0 = 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::new(arg2, arg4);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::burn_points(arg3, 0x2::coin::from_balance<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x2::balance::split<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::point_balance_mut(arg0), arg1), arg4));
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::emit_created_event(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0), 0x2::object::id<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v0), 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::letter(&v0));
        v0
    }

    entry fun purchase_all_alphabets(arg0: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player, arg1: &0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::last_purchase_all_alphabets_epoch(arg0) < v0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000000, 1);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::set_last_purchase_all_alphabets_epoch(arg0, v0);
        let v1 = 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::create_all_alphabets(arg3);
        while (!0x1::vector::is_empty<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&mut v1);
            0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::emit_created_event(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0), 0x2::object::id<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v2), 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::letter(&v2));
            0x2::transfer::public_transfer<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v2, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0));
        };
        0x1::vector::destroy_empty<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::config::treasury(arg1));
    }

    entry fun purchase_random_alphabet(arg0: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player, arg1: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::PointManager, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_alphabet_acquisition_cost(0);
        assert!(0x2::balance::value<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::point_balance(arg0)) >= v0, 0);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = purchase(arg0, v0, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::weighted_random_letter(&mut v1), arg1, arg3);
        0x2::transfer::public_transfer<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v2, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0));
    }

    entry fun purchase_specified_alphabet(arg0: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player, arg1: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::PointManager, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_alphabet_acquisition_cost(1);
        assert!(0x2::balance::value<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::point_balance(arg0)) >= v0, 0);
        let v1 = purchase(arg0, v0, arg2, arg1, arg3);
        0x2::transfer::public_transfer<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v1, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0));
    }

    // decompiled from Move bytecode v6
}

