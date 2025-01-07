module 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::controller {
    struct NewPlayerEvent has copy, drop {
        player_id: 0x2::object::ID,
        player_name: 0x1::string::String,
    }

    entry fun daily_checkin(arg0: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::last_checkin_epoch(arg0) < v0, 1);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::set_last_checkin_epoch(arg0, v0);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::new(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::weighted_random_letter(&mut v1), arg2);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::emit_created_event(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0), 0x2::object::id<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v2), 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::letter(&v2));
        0x2::transfer::public_transfer<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v2, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(arg0));
    }

    entry fun new_player(arg0: 0x1::string::String, arg1: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::config::Config, arg2: &mut 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::PointManager, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::config::players(arg1), &v0), 0);
        0x2::vec_set::insert<address>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::config::players_mut(arg1), v0);
        let v1 = 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::new(arg0, arg3);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::set_last_mint_epoch(&mut v1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::create_alphabets(b"SUI", arg3);
        while (!0x1::vector::is_empty<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&mut v2);
            0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::emit_created_event(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(&v1), 0x2::object::id<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(&v3), 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::letter(&v3));
            0x2::transfer::public_transfer<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v3, 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::to_address(&v1));
        };
        0x1::vector::destroy_empty<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::alphabet::Alphabet>(v2);
        0x2::balance::join<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::point_balance_mut(&mut v1), 0x2::coin::into_balance<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::mint_points(arg2, 100, arg3)));
        let v4 = NewPlayerEvent{
            player_id   : 0x2::object::id<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::Player>(&v1),
            player_name : arg0,
        };
        0x2::event::emit<NewPlayerEvent>(v4);
        0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player::transfer(v1, v0);
    }

    // decompiled from Move bytecode v6
}

