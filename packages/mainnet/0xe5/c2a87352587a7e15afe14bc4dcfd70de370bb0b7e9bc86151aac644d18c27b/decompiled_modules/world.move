module 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::world {
    struct TravelStarted has copy, drop {
        player_id: 0x2::object::ID,
        destination: u16,
        arrive_at_ms: u64,
    }

    struct Teleported has copy, drop {
        player_id: 0x2::object::ID,
        destination: u16,
        cost: u64,
    }

    fun diff(arg0: u16, arg1: u16) : u16 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun start_travel(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg3, arg4);
        assert!(arg2 != 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::location(arg0), 13906834423451484161);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location(arg1, arg2);
        assert!(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::total_level(arg0) >= 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_level_req(&v0), 13906834432041549827);
        let v1 = 0x2::clock::timestamp_ms(arg3) + travel_ms(arg1, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::location(arg0), arg2, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::skill_level(arg0, 10));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, (arg2 as u64));
        0x1::vector::push_back<u64>(v3, v1);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::start_action(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_travel(), v2, arg3);
        let v4 = TravelStarted{
            player_id    : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            destination  : arg2,
            arrive_at_ms : v1,
        };
        0x2::event::emit<TravelStarted>(v4);
    }

    public fun teleport(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg3, arg4);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_idle(arg0);
        assert!(arg2 != 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::location(arg0), 13906834552300503041);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location(arg1, arg2);
        assert!(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::total_level(arg0) >= 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_level_req(&v0), 13906834560890568707);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_teleport_cost(&v0);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_coins(arg0, v1);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::set_location(arg0, arg2);
        let v2 = Teleported{
            player_id   : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            destination : arg2,
            cost        : v1,
        };
        0x2::event::emit<Teleported>(v2);
    }

    public fun travel_ms(arg0: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg1: u16, arg2: u16, arg3: u8) : u64 {
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location(arg0, arg1);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location(arg0, arg2);
        0x1::u64::max((diff(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_x(&v0), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_x(&v1)) as u64), (diff(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_y(&v0), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::location_y(&v1)) as u64)) * 60000 * 100 / (100 + (arg3 as u64))
    }

    // decompiled from Move bytecode v7
}

