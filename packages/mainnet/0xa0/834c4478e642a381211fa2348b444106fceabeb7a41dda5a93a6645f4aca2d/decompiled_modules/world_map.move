module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map {
    struct BiomeMap has copy, drop, store {
        zone_x0: u32,
        zone_z0: u32,
        side: u16,
        cells: vector<u8>,
    }

    struct MobRow has copy, drop, store {
        mob_type: 0x1::string::String,
        weight_bp: u16,
        biomes: vector<u8>,
        cities: vector<u8>,
    }

    struct ArchiRow has copy, drop, store {
        ordinary_type: 0x1::string::String,
        archi_type: 0x1::string::String,
    }

    struct ResourceRow has copy, drop, store {
        item_type: 0x1::string::String,
        job: 0x1::string::String,
        tier: u8,
        protector: 0x1::string::String,
        rare_item_type: 0x1::string::String,
        biomes: vector<u8>,
        cities: vector<u8>,
    }

    struct WorldContent has copy, drop, store {
        mobs: vector<MobRow>,
        resources: vector<ResourceRow>,
        cities: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>,
        biome_map: BiomeMap,
    }

    fun abs_diff(arg0: u32, arg1: u32) : u64 {
        if (arg0 > arg1) {
            ((arg0 - arg1) as u64)
        } else {
            ((arg1 - arg0) as u64)
        }
    }

    public fun append_biome_cells(arg0: &BiomeMap, arg1: vector<u8>) : BiomeMap {
        let v0 = arg0.cells;
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = (arg0.side as u64);
        assert!(0x1::vector::length<u8>(&v0) <= v1 * v1, 311);
        BiomeMap{
            zone_x0 : arg0.zone_x0,
            zone_z0 : arg0.zone_z0,
            side    : arg0.side,
            cells   : v0,
        }
    }

    public fun append_biome_map_cells(arg0: &mut WorldContent, arg1: vector<u8>) {
        arg0.biome_map = append_biome_cells(&arg0.biome_map, arg1);
    }

    public fun archi_row_ordinary(arg0: &ArchiRow) : 0x1::string::String {
        arg0.ordinary_type
    }

    public fun archi_row_replacement(arg0: &ArchiRow) : 0x1::string::String {
        arg0.archi_type
    }

    public fun biome_map(arg0: &WorldContent) : &BiomeMap {
        &arg0.biome_map
    }

    public fun biome_map_window(arg0: u32, arg1: u32, arg2: u16) : BiomeMap {
        BiomeMap{
            zone_x0 : arg0,
            zone_z0 : arg1,
            side    : arg2,
            cells   : b"",
        }
    }

    public fun biome_of_zone(arg0: &BiomeMap, arg1: u32, arg2: u32) : u8 {
        if (arg0.side == 0) {
            return 0
        };
        let v0 = (arg0.side as u64);
        assert!(0x1::vector::length<u8>(&arg0.cells) == v0 * v0, 311);
        let v1 = (arg0.side as u32) - 1;
        *0x1::vector::borrow<u8>(&arg0.cells, (clamp_to_window(arg2, arg0.zone_z0, v1) as u64) * v0 + (clamp_to_window(arg1, arg0.zone_x0, v1) as u64))
    }

    public fun cities(arg0: &WorldContent) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City> {
        arg0.cities
    }

    fun clamp_to_window(arg0: u32, arg1: u32, arg2: u32) : u32 {
        if (arg0 <= arg1) {
            0
        } else if (arg0 - arg1 >= arg2) {
            arg2
        } else {
            arg0 - arg1
        }
    }

    public fun clear_biome_map(arg0: &mut WorldContent) {
        arg0.biome_map = empty_biome_map();
    }

    public fun empty_biome_map() : BiomeMap {
        BiomeMap{
            zone_x0 : 0,
            zone_z0 : 0,
            side    : 0,
            cells   : b"",
        }
    }

    public fun empty_world_content() : WorldContent {
        WorldContent{
            mobs      : 0x1::vector::empty<MobRow>(),
            resources : 0x1::vector::empty<ResourceRow>(),
            cities    : 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(),
            biome_map : empty_biome_map(),
        }
    }

    public fun mob_row_biomes(arg0: &MobRow) : vector<u8> {
        arg0.biomes
    }

    public fun mob_row_cities(arg0: &MobRow) : vector<u8> {
        arg0.cities
    }

    public fun mob_row_type(arg0: &MobRow) : 0x1::string::String {
        arg0.mob_type
    }

    public fun mob_row_weight_bp(arg0: &MobRow) : u16 {
        arg0.weight_bp
    }

    public fun mobs(arg0: &WorldContent) : vector<MobRow> {
        arg0.mobs
    }

    public fun new_archi_row(arg0: 0x1::string::String, arg1: 0x1::string::String) : ArchiRow {
        ArchiRow{
            ordinary_type : arg0,
            archi_type    : arg1,
        }
    }

    public fun new_mob_row(arg0: 0x1::string::String, arg1: u16, arg2: vector<u8>, arg3: vector<u8>) : MobRow {
        assert!(arg1 > 0 && arg1 <= 10000, 306);
        assert!(!0x1::vector::is_empty<u8>(&arg2) || !0x1::vector::is_empty<u8>(&arg3), 306);
        MobRow{
            mob_type  : arg0,
            weight_bp : arg1,
            biomes    : arg2,
            cities    : arg3,
        }
    }

    public fun new_resource_row(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>) : ResourceRow {
        let v0 = if (arg1 == 0x1::string::utf8(b"FARMER")) {
            true
        } else if (arg1 == 0x1::string::utf8(b"HERBALIST")) {
            true
        } else {
            arg1 == 0x1::string::utf8(b"MINER")
        };
        assert!(v0, 308);
        ResourceRow{
            item_type      : arg0,
            job            : arg1,
            tier           : arg2,
            protector      : arg3,
            rare_item_type : arg4,
            biomes         : arg5,
            cities         : arg6,
        }
    }

    public fun resource_row_biomes(arg0: &ResourceRow) : vector<u8> {
        arg0.biomes
    }

    public fun resource_row_cities(arg0: &ResourceRow) : vector<u8> {
        arg0.cities
    }

    public fun resource_row_job(arg0: &ResourceRow) : 0x1::string::String {
        arg0.job
    }

    public fun resource_row_of(arg0: &WorldContent, arg1: 0x1::string::String) : ResourceRow {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ResourceRow>(&arg0.resources)) {
            if (resource_row_type(0x1::vector::borrow<ResourceRow>(&arg0.resources, v0)) == arg1) {
                return *0x1::vector::borrow<ResourceRow>(&arg0.resources, v0)
            };
            v0 = v0 + 1;
        };
        abort 309
    }

    public fun resource_row_protector(arg0: &ResourceRow) : 0x1::string::String {
        arg0.protector
    }

    public fun resource_row_rare(arg0: &ResourceRow) : 0x1::string::String {
        arg0.rare_item_type
    }

    public fun resource_row_tier(arg0: &ResourceRow) : u8 {
        arg0.tier
    }

    public fun resource_row_type(arg0: &ResourceRow) : 0x1::string::String {
        arg0.item_type
    }

    public fun resources(arg0: &WorldContent) : vector<ResourceRow> {
        arg0.resources
    }

    public fun set_biome_map_window(arg0: &mut WorldContent, arg1: u32, arg2: u32, arg3: u16) {
        arg0.biome_map = biome_map_window(arg1, arg2, arg3);
    }

    public fun set_cities(arg0: &mut WorldContent, arg1: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::assert_valid(&arg1);
        arg0.cities = arg1;
    }

    public fun set_mobs(arg0: &mut WorldContent, arg1: vector<MobRow>) {
        arg0.mobs = arg1;
    }

    public fun set_resources(arg0: &mut WorldContent, arg1: vector<ResourceRow>) {
        arg0.resources = arg1;
    }

    public fun travel_ok(arg0: u32, arg1: u32, arg2: u64, arg3: bool, arg4: u32, arg5: u32, arg6: u64, arg7: bool) : bool {
        if (arg6 < arg2) {
            return false
        };
        let v0 = if (arg3 && arg7) {
            1150 * 3 / 2
        } else {
            1150
        };
        let v1 = (arg6 - arg2) * v0 / 100000;
        if (v1 >= 1000000) {
            return true
        };
        let v2 = abs_diff(arg4, arg0);
        let v3 = abs_diff(arg5, arg1);
        v1 * v1 >= v2 * v2 + v3 * v3
    }

    public fun world_center() : u32 {
        50000
    }

    public fun world_size() : u32 {
        100000
    }

    // decompiled from Move bytecode v7
}

