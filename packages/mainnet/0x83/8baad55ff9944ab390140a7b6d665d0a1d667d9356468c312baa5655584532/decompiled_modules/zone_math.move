module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math {
    struct MobGroup has copy, drop {
        index: u64,
        x: u32,
        z: u32,
        members: vector<MobMember>,
    }

    struct MobMember has copy, drop {
        mob_type: 0x1::string::String,
        level_scalar: u8,
    }

    struct ResourcePack has copy, drop {
        index: u64,
        x: u32,
        z: u32,
        item_type: 0x1::string::String,
        nodes: u8,
    }

    fun all_resource_packs(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32, arg5: u64) : vector<ResourcePack> {
        let (v0, v1) = zone_axis(arg3);
        let (v2, v3) = zone_axis(arg4);
        let v4 = resource_families(arg0, arg1, arg2, arg3, arg4);
        if (0x1::vector::is_empty<0x1::string::String>(&v4)) {
            return 0x1::vector::empty<ResourcePack>()
        };
        let v5 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::city_index_at(arg2, arg3, arg4);
        let v6 = distance_blocks(arg3, arg4);
        let v7 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::rng_seed(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg5, 3));
        let v8 = ramp(v6, 20000, 2, 16);
        let v9 = 0x1::vector::empty<ResourcePack>();
        let v10 = 0;
        while (v10 < 24 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % (42 - 24 + 1)) {
            let v11 = if (0x1::option::is_some<u8>(&v5)) {
                (v8 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % (ramp(v6, 20000, 4, 22) - v8 + 1)) * 3 / 2
            } else {
                v8 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % (ramp(v6, 20000, 4, 22) - v8 + 1)
            };
            let v12 = ResourcePack{
                index     : v10,
                x         : v0 + ((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % v1) as u32),
                z         : v2 + ((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % v3) as u32),
                item_type : *0x1::vector::borrow<0x1::string::String>(&v4, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v7) % 0x1::vector::length<0x1::string::String>(&v4)),
                nodes     : (v11 as u8),
            };
            0x1::vector::push_back<ResourcePack>(&mut v9, v12);
            v10 = v10 + 1;
        };
        v9
    }

    fun archi_type(arg0: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>(arg0)) {
            let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::archi_row_ordinary(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>(arg0, v0));
            if (&v1 == arg1) {
                return 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::archi_row_replacement(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>(arg0, v0))
            };
            v0 = v0 + 1;
        };
        0x1::string::utf8(b"")
    }

    fun distance_blocks(arg0: u32, arg1: u32) : u64 {
        let v0 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_center() as u64);
        let v1 = (arg0 as u64) * (512 as u64) + (512 as u64) / 2;
        let v2 = (arg1 as u64) * (512 as u64) + (512 as u64) / 2;
        let v3 = if (v1 >= v0) {
            v1 - v0
        } else {
            v0 - v1
        };
        let v4 = if (v2 >= v0) {
            v2 - v0
        } else {
            v0 - v2
        };
        if (v3 >= v4) {
            v3
        } else {
            v4
        }
    }

    public fun families(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = population_mob_rows(arg0, arg1, arg2, arg3, arg4);
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&v1)) {
            let v3 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v1);
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_type(&v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(v1);
        v0
    }

    public fun group_index(arg0: &MobGroup) : u64 {
        arg0.index
    }

    public fun group_members(arg0: &MobGroup) : vector<MobMember> {
        arg0.members
    }

    fun group_size_bounds(arg0: u64) : (u64, u64) {
        let v0 = ramp(arg0, 10000, 1, 6);
        let v1 = ramp(arg0, 2000 * 5 / 3, 1, 6);
        let v2 = if (v1 < v0) {
            v0
        } else {
            v1
        };
        (v0, v2)
    }

    public fun group_x(arg0: &MobGroup) : u32 {
        arg0.x
    }

    public fun group_z(arg0: &MobGroup) : u32 {
        arg0.z
    }

    public fun level_bounds(arg0: u32, arg1: u32) : (u64, u64) {
        level_bounds_at_distance(distance_blocks(arg0, arg1))
    }

    fun level_bounds_at_distance(arg0: u64) : (u64, u64) {
        (ramp(arg0, 20000, 0, 75), ramp(arg0, 20000, 0, 100))
    }

    public fun member_level_scalar(arg0: &MobMember) : u8 {
        arg0.level_scalar
    }

    public fun member_type(arg0: &MobMember) : 0x1::string::String {
        arg0.mob_type
    }

    public fun mob_groups(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32, arg5: u64, arg6: u128) : vector<MobGroup> {
        let v0 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>();
        mob_groups_inner(arg0, &v0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun mob_groups_inner(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>, arg2: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg3: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg4: u32, arg5: u32, arg6: u64, arg7: u128) : vector<MobGroup> {
        let (v0, v1) = zone_axis(arg4);
        let (v2, v3) = zone_axis(arg5);
        let v4 = population_mob_rows(arg0, arg2, arg3, arg4, arg5);
        if (0x1::vector::is_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&v4)) {
            return 0x1::vector::empty<MobGroup>()
        };
        let v5 = 0;
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&v4)) {
            let v7 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v4);
            v5 = v5 + (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_weight_bp(&v7) as u64);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(v4);
        let v8 = distance_blocks(arg4, arg5);
        let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::rng_seed(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg6, 2));
        let v10 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::rng_seed(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg6, 4));
        let (v11, v12) = group_size_bounds(v8);
        let (v13, v14) = level_bounds_at_distance(v8);
        let v15 = 0x1::vector::empty<MobGroup>();
        let v16 = 0;
        while (v16 < 48 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % (64 - 48 + 1)) {
            let v17 = &mut v9;
            let v18 = 0x1::vector::empty<MobMember>();
            let v19 = 0;
            while (v19 < v11 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % (v12 - v11 + 1)) {
                let v20 = if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % 10000 < 5000) {
                    weighted_family(&v4, v5, v17)
                } else {
                    let v21 = &mut v9;
                    weighted_family(&v4, v5, v21)
                };
                let v22 = MobMember{
                    mob_type     : replacement_for_roll(arg1, v20, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v10) % 10000),
                    level_scalar : ((v13 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % (v14 - v13 + 1)) as u8),
                };
                0x1::vector::push_back<MobMember>(&mut v18, v22);
                v19 = v19 + 1;
            };
            if (arg7 & 1 << (v16 as u8) == 0) {
                let v23 = MobGroup{
                    index   : v16,
                    x       : v0 + ((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % v1) as u32),
                    z       : v2 + ((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut v9) % v3) as u32),
                    members : v18,
                };
                0x1::vector::push_back<MobGroup>(&mut v15, v23);
            };
            v16 = v16 + 1;
        };
        v15
    }

    public fun mob_groups_with_archis(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>, arg2: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg3: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg4: u32, arg5: u32, arg6: u64, arg7: u128) : vector<MobGroup> {
        mob_groups_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun new_member(arg0: 0x1::string::String, arg1: u8) : MobMember {
        MobMember{
            mob_type     : arg0,
            level_scalar : arg1,
        }
    }

    public fun pack_index(arg0: &ResourcePack) : u64 {
        arg0.index
    }

    public fun pack_item_type(arg0: &ResourcePack) : 0x1::string::String {
        arg0.item_type
    }

    public fun pack_nodes(arg0: &ResourcePack) : u8 {
        arg0.nodes
    }

    public fun pack_x(arg0: &ResourcePack) : u32 {
        arg0.x
    }

    public fun pack_z(arg0: &ResourcePack) : u32 {
        arg0.z
    }

    fun population_mob_rows(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow> {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::city_index_at(arg2, arg3, arg4);
        if (0x1::option::is_some<u8>(&v0)) {
            let v1 = *0x1::option::borrow<u8>(&v0);
            let v2 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>();
            0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut arg0);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&arg0)) {
                let v4 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut arg0);
                let v5 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_cities(&v4);
                if (0x1::vector::contains<u8>(&v5, &v1)) {
                    0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v2, v4);
                };
                v3 = v3 + 1;
            };
            0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(arg0);
            return v2
        };
        let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::biome_of_zone(arg1, arg3, arg4);
        let v7 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>();
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut arg0);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&arg0)) {
            let v9 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut arg0);
            let v10 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_biomes(&v9);
            if (0x1::vector::contains<u8>(&v10, &v6)) {
                0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(&mut v7, v9);
            };
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(arg0);
        v7
    }

    fun ramp(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        arg2 + (arg3 - arg2) * v0 / arg1
    }

    fun replacement_for_roll(arg0: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>, arg1: 0x1::string::String, arg2: u64) : 0x1::string::String {
        if (arg2 >= 100) {
            return arg1
        };
        let v0 = archi_type(arg0, &arg1);
        if (!0x1::string::is_empty(&v0)) {
            v0
        } else {
            arg1
        }
    }

    public fun resource_families(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32) : vector<0x1::string::String> {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::city_index_at(arg2, arg3, arg4);
        if (0x1::option::is_some<u8>(&v0)) {
            let v1 = *0x1::option::borrow<u8>(&v0);
            let v2 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>();
            0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut arg0);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&arg0)) {
                let v4 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut arg0);
                let v5 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_cities(&v4);
                if (0x1::vector::contains<u8>(&v5, &v1)) {
                    0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v2, v4);
                };
                v3 = v3 + 1;
            };
            0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(arg0);
            let v6 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v2);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&v2)) {
                let v8 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v2);
                0x1::vector::push_back<0x1::string::String>(&mut v6, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_type(&v8));
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(v2);
            return v6
        };
        let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::biome_of_zone(arg1, arg3, arg4);
        let v10 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>();
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut arg0);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&arg0)) {
            let v12 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut arg0);
            let v13 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_biomes(&v12);
            if (0x1::vector::contains<u8>(&v13, &v9)) {
                0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v10, v12);
            };
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(arg0);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v10);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&v10)) {
            let v16 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(&mut v10);
            0x1::vector::push_back<0x1::string::String>(&mut v14, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_type(&v16));
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>(v10);
        v14
    }

    public fun resource_pack_at(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32, arg5: u64, arg6: &vector<u8>, arg7: u64) : ResourcePack {
        let v0 = all_resource_packs(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(arg7 < 0x1::vector::length<ResourcePack>(&v0), 1302);
        let ResourcePack {
            index     : v1,
            x         : v2,
            z         : v3,
            item_type : v4,
            nodes     : v5,
        } = *0x1::vector::borrow<ResourcePack>(&v0, arg7);
        let v6 = taken_of(arg6, arg7);
        assert!(v6 < v5, 1302);
        ResourcePack{
            index     : v1,
            x         : v2,
            z         : v3,
            item_type : v4,
            nodes     : v5 - v6,
        }
    }

    public fun resource_packs(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32, arg5: u64, arg6: &vector<u8>) : vector<ResourcePack> {
        let v0 = all_resource_packs(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x1::vector::empty<ResourcePack>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<ResourcePack>(&v0)) {
            let ResourcePack {
                index     : v3,
                x         : v4,
                z         : v5,
                item_type : v6,
                nodes     : v7,
            } = *0x1::vector::borrow<ResourcePack>(&v0, v2);
            let v8 = taken_of(arg6, v3);
            if (v8 < v7) {
                let v9 = ResourcePack{
                    index     : v3,
                    x         : v4,
                    z         : v5,
                    item_type : v6,
                    nodes     : v7 - v8,
                };
                0x1::vector::push_back<ResourcePack>(&mut v1, v9);
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun taken_of(arg0: &vector<u8>, arg1: u64) : u8 {
        if (arg1 < 0x1::vector::length<u8>(arg0)) {
            *0x1::vector::borrow<u8>(arg0, arg1)
        } else {
            0
        }
    }

    public fun total_resource_nodes(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::BiomeMap, arg2: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg3: u32, arg4: u32, arg5: u64, arg6: u64) : u8 {
        let v0 = all_resource_packs(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(arg6 < 0x1::vector::length<ResourcePack>(&v0), 1302);
        0x1::vector::borrow<ResourcePack>(&v0, arg6).nodes
    }

    fun weighted_family(arg0: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg1: u64, arg2: &mut u64) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0;
        loop {
            v0 = v0 + (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_weight_bp(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(arg0, v1)) as u64);
            if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg2) % arg1 < v0) {
                break
            };
            v1 = v1 + 1;
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::mob_row_type(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>(arg0, v1))
    }

    fun zone_axis(arg0: u32) : (u32, u64) {
        let v0 = (arg0 as u64) * (512 as u64);
        let v1 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::world_size() as u64);
        assert!(v0 < v1, 1303);
        let v2 = v1 - v0;
        let v3 = if (v2 < (512 as u64)) {
            v2
        } else {
            (512 as u64)
        };
        ((v0 as u32), v3)
    }

    public fun zone_size() : u32 {
        512
    }

    // decompiled from Move bytecode v7
}

