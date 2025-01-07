module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::controller {
    struct NewPlayerEvent has copy, drop {
        player_id: 0x2::object::ID,
        player_name: 0x1::string::String,
    }

    entry fun daily_checkin(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::last_checkin_epoch(arg0) < v0, 1);
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::set_last_checkin_epoch(arg0, v0);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::new(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::weighted_random_letter(&mut v1), arg2);
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::emit_created_event(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0), 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v2), 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::letter(&v2));
        0x2::transfer::public_transfer<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v2, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0));
    }

    entry fun new_player(arg0: 0x1::string::String, arg1: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config::Config, arg2: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::PointManager, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config::players(arg1), v0), 0);
        0x2::table::add<address, bool>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::config::players_mut(arg1), v0, true);
        let v1 = 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::new(arg0, arg3);
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::set_last_mint_epoch(&mut v1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::create_alphabets(b"SUI", arg3);
        while (!0x1::vector::is_empty<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&mut v2);
            0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::emit_created_event(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(&v1), 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v3), 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::letter(&v3));
            0x2::transfer::public_transfer<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v3, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(&v1));
        };
        0x1::vector::destroy_empty<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v2);
        0x2::balance::join<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_balance_mut(&mut v1), 0x2::coin::into_balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::mint_points(arg2, 100, arg3)));
        let v4 = NewPlayerEvent{
            player_id   : 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player>(&v1),
            player_name : arg0,
        };
        0x2::event::emit<NewPlayerEvent>(v4);
        0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::transfer(v1, v0);
    }

    // decompiled from Move bytecode v6
}

