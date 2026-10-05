module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world {
    struct World has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct WorldKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct CurrentWorldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CheckpointKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct Checkpoint has copy, drop, store {
        x: u32,
        z: u32,
        at_ms: u64,
        pet: bool,
    }

    struct WorldJoined has copy, drop {
        character: 0x2::object::ID,
        world: 0x1::string::String,
        x: u32,
        z: u32,
        first_join: bool,
    }

    struct CharacterTeleported has copy, drop {
        character: 0x2::object::ID,
        world: 0x1::string::String,
        x: u32,
        z: u32,
    }

    struct WorldCreated has copy, drop {
        world: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public(friend) fun uid_mut(arg0: &mut World) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun assert_start_world(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent) {
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg0) == 0x1::string::utf8(b"nauvis"), 306);
    }

    public fun create(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg2);
        let v1 = WorldKey{pos0: v0};
        let v2 = World{
            id   : 0x2::derived_object::claim<WorldKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg3), v1),
            name : v0,
        };
        let v3 = WorldCreated{
            world : 0x2::object::id<World>(&v2),
            name  : v0,
        };
        0x2::event::emit<WorldCreated>(v3);
        0x2::transfer::share_object<World>(v2);
    }

    fun current_checkpoint_mut(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : (0x1::string::String, &mut Checkpoint) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = CurrentWorldKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CurrentWorldKey>(v0, v1), 303);
        let v2 = CurrentWorldKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<CurrentWorldKey, 0x1::string::String>(v0, v2);
        let v4 = CheckpointKey{pos0: v3};
        (v3, 0x2::dynamic_field::borrow_mut<CheckpointKey, Checkpoint>(v0, v4))
    }

    public(friend) fun current_world(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : 0x1::string::String {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = CurrentWorldKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CurrentWorldKey>(v0, v1), 303);
        let v2 = CurrentWorldKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CurrentWorldKey, 0x1::string::String>(v0, v2)
    }

    public(friend) fun delay_checkpoint(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u64, arg2: &0x2::clock::Clock) {
        let (_, v1) = current_checkpoint_mut(arg0);
        v1.at_ms = 0x2::clock::timestamp_ms(arg2) + arg1;
    }

    public(friend) fun is_rooted(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = CurrentWorldKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CurrentWorldKey>(v0, v1), 303);
        let v2 = CurrentWorldKey{dummy_field: false};
        let v3 = CheckpointKey{pos0: *0x2::dynamic_field::borrow<CurrentWorldKey, 0x1::string::String>(v0, v2)};
        0x2::dynamic_field::borrow<CheckpointKey, Checkpoint>(v0, v3).at_ms > 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun join_world(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0x2::clock::Clock) {
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) >= 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::entry_level(arg1), 302);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg1);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::touch(arg0, arg2);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::id(arg0);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_center();
        let v3 = CurrentWorldKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<CurrentWorldKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0), v3);
        if (v4) {
            let v5 = CurrentWorldKey{dummy_field: false};
            assert!(*0x2::dynamic_field::borrow<CurrentWorldKey, 0x1::string::String>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0), v5) != v0, 309);
            prove_move(arg0, v2, v2, arg2);
        };
        if (v4) {
            let v6 = CurrentWorldKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CurrentWorldKey, 0x1::string::String>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0), v6) = v0;
        } else {
            let v7 = CurrentWorldKey{dummy_field: false};
            0x2::dynamic_field::add<CurrentWorldKey, 0x1::string::String>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0), v7, v0);
        };
        let v8 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v9 = CheckpointKey{pos0: v0};
        let v10 = !0x2::dynamic_field::exists<CheckpointKey>(v8, v9);
        if (v10) {
            let v11 = CheckpointKey{pos0: v0};
            let v12 = Checkpoint{
                x     : v2,
                z     : v2,
                at_ms : 0x2::clock::timestamp_ms(arg2),
                pet   : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::pet_equipped(arg0),
            };
            0x2::dynamic_field::add<CheckpointKey, Checkpoint>(v8, v11, v12);
        } else {
            let v13 = CheckpointKey{pos0: v0};
            let v14 = 0x2::dynamic_field::borrow_mut<CheckpointKey, Checkpoint>(v8, v13);
            v14.x = v2;
            v14.z = v2;
            v14.at_ms = 0x2::clock::timestamp_ms(arg2);
            v14.pet = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::pet_equipped(arg0);
        };
        let v15 = WorldJoined{
            character  : v1,
            world      : v0,
            x          : v2,
            z          : v2,
            first_join : v10,
        };
        0x2::event::emit<WorldJoined>(v15);
    }

    public fun name(arg0: &World) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun prove_move(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u32, arg2: u32, arg3: &0x2::clock::Clock) : 0x1::string::String {
        assert!(arg1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_size() && arg2 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_size(), 304);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::touch(arg0, arg3);
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::pet_equipped(arg0);
        let (v1, v2) = current_checkpoint_mut(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::travel_ok(v2.x, v2.z, v2.at_ms, v2.pet, arg1, arg2, v3, v0), 305);
        v2.x = arg1;
        v2.z = arg2;
        v2.at_ms = v3;
        v2.pet = v0;
        v1
    }

    public(friend) fun teleport_center(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0x2::clock::Clock) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::id(arg0);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::pet_equipped(arg0);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_center();
        let (v3, v4) = current_checkpoint_mut(arg0);
        v4.x = v2;
        v4.z = v2;
        v4.at_ms = 0x2::clock::timestamp_ms(arg1);
        v4.pet = v1;
        let v5 = CharacterTeleported{
            character : v0,
            world     : v3,
            x         : v2,
            z         : v2,
        };
        0x2::event::emit<CharacterTeleported>(v5);
    }

    public(friend) fun teleport_city(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::id(arg0);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::pet_equipped(arg0);
        let (v2, v3) = current_checkpoint_mut(arg0);
        assert!(v2 == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg1), 307);
        let v4 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        let v5 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::city_by_name(&v4, arg2);
        assert!(0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v5), 308);
        let v6 = 0x1::option::destroy_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(v5);
        v3.x = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::x(&v6);
        v3.z = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::z(&v6);
        v3.at_ms = 0x2::clock::timestamp_ms(arg3);
        v3.pet = v1;
        let v7 = CharacterTeleported{
            character : v0,
            world     : v2,
            x         : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::x(&v6),
            z         : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::z(&v6),
        };
        0x2::event::emit<CharacterTeleported>(v7);
    }

    // decompiled from Move bytecode v7
}

