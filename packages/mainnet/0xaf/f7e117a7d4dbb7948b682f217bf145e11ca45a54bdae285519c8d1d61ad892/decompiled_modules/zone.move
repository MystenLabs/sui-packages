module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone {
    struct ZoneKey has copy, drop, store {
        zone_x: u32,
        zone_z: u32,
    }

    struct Zone has key {
        id: 0x2::object::UID,
        world: 0x1::string::String,
        zone_x: u32,
        zone_z: u32,
        seed: u64,
        searched_at_ms: u64,
        mob_taken: u128,
        res_taken: vector<u8>,
    }

    struct ZoneSearched has copy, drop {
        world: 0x1::string::String,
        zone_x: u32,
        zone_z: u32,
        seed: u64,
        fresh: bool,
    }

    fun assert_world_content(arg0: &Zone, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent) {
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg1) == arg0.world, 1301);
    }

    fun assert_zone(arg0: &Zone, arg1: u32, arg2: u32) {
        assert!(arg0.zone_x == arg1 && arg0.zone_z == arg2, 1303);
    }

    public(friend) fun consume_mob_group(arg0: &mut Zone, arg1: u64) {
        assert!(arg1 < 128, 1302);
        let v0 = 1 << (arg1 as u8);
        assert!(arg0.mob_taken & v0 == 0, 1302);
        arg0.mob_taken = arg0.mob_taken | v0;
    }

    public(friend) fun consume_resource_node(arg0: &mut Zone, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: u64) {
        assert_world_content(arg0, arg1);
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        while ((0x1::vector::length<u8>(&arg0.res_taken) as u64) <= arg2) {
            0x1::vector::push_back<u8>(&mut arg0.res_taken, 0);
        };
        let v1 = 0x1::vector::borrow_mut<u8>(&mut arg0.res_taken, arg2);
        assert!(*v1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::total_resource_nodes(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resources(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::biome_map(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), &v0, arg0.zone_x, arg0.zone_z, arg0.seed, arg2), 1302);
        *v1 = *v1 + 1;
    }

    public(friend) fun create(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u32, arg2: u32, arg3: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::World, arg4: &mut 0x2::random::RandomGenerator, arg5: &0x2::clock::Clock) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::name(arg3);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::prove_move(arg0, arg1, arg2, arg5) == v0, 1301);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::zone_size();
        let v2 = arg1 / v1;
        let v3 = arg2 / v1;
        let v4 = (0x2::random::generate_u32(arg4) as u64);
        let v5 = ZoneKey{
            zone_x : v2,
            zone_z : v3,
        };
        let v6 = Zone{
            id             : 0x2::derived_object::claim<ZoneKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::uid_mut(arg3), v5),
            world          : v0,
            zone_x         : v2,
            zone_z         : v3,
            seed           : v4,
            searched_at_ms : 0x2::clock::timestamp_ms(arg5),
            mob_taken      : 0,
            res_taken      : b"",
        };
        let v7 = ZoneSearched{
            world  : v0,
            zone_x : v2,
            zone_z : v3,
            seed   : v4,
            fresh  : true,
        };
        0x2::event::emit<ZoneSearched>(v7);
        0x2::transfer::share_object<Zone>(v6);
    }

    public fun level_bounds(arg0: &Zone) : (u64, u64) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::level_bounds(arg0.zone_x, arg0.zone_z)
    }

    public fun mob_groups(arg0: &Zone, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::MobGroup> {
        assert_world_content(arg0, arg1);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::archi_rows(arg1);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::mob_groups_with_archis(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mobs(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), &v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::biome_map(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), &v1, arg0.zone_x, arg0.zone_z, arg0.seed, arg0.mob_taken)
    }

    public(friend) fun refresh(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u32, arg2: u32, arg3: &mut Zone, arg4: &mut 0x2::random::RandomGenerator, arg5: &0x2::clock::Clock) {
        assert_zone(arg3, arg1 / 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::zone_size(), arg2 / 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::zone_size());
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::prove_move(arg0, arg1, arg2, arg5) == arg3.world, 1301);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 >= arg3.searched_at_ms + 7200000;
        if (v1) {
            arg3.seed = (0x2::random::generate_u32(arg4) as u64);
            arg3.searched_at_ms = v0;
            arg3.mob_taken = 0;
            arg3.res_taken = b"";
        };
        let v2 = ZoneSearched{
            world  : arg3.world,
            zone_x : arg3.zone_x,
            zone_z : arg3.zone_z,
            seed   : arg3.seed,
            fresh  : v1,
        };
        0x2::event::emit<ZoneSearched>(v2);
    }

    public fun resource_pack_at(arg0: &Zone, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: u64) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::ResourcePack {
        assert_world_content(arg0, arg1);
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::resource_pack_at(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resources(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::biome_map(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1)), &v0, arg0.zone_x, arg0.zone_z, arg0.seed, &arg0.res_taken, arg2)
    }

    public fun seed_of(arg0: &Zone) : u64 {
        arg0.seed
    }

    public(friend) fun world_name(arg0: &Zone) : 0x1::string::String {
        arg0.world
    }

    // decompiled from Move bytecode v7
}

