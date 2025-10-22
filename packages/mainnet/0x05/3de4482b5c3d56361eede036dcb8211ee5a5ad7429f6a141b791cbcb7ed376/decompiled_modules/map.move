module 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map {
    struct BuildingStatic has copy, drop, store {
        x: u8,
        y: u8,
        size: u8,
        price: u64,
        chain_prev_id: u16,
        chain_next_id: u16,
    }

    struct TileStatic has copy, drop, store {
        x: u8,
        y: u8,
        kind: u8,
        building_id: u16,
        special: u64,
        w: u16,
        n: u16,
        e: u16,
        s: u16,
    }

    struct MapTemplate has store, key {
        id: 0x2::object::UID,
        schema_version: u8,
        tiles_static: vector<TileStatic>,
        buildings_static: vector<BuildingStatic>,
        hospital_ids: vector<u16>,
    }

    struct MapRegistry has store, key {
        id: 0x2::object::UID,
        templates: vector<0x2::object::ID>,
    }

    public(friend) fun building_chain_next_id(arg0: &BuildingStatic) : u16 {
        arg0.chain_next_id
    }

    public(friend) fun building_chain_prev_id(arg0: &BuildingStatic) : u16 {
        arg0.chain_prev_id
    }

    public(friend) fun building_price(arg0: &BuildingStatic) : u64 {
        arg0.price
    }

    public(friend) fun building_size(arg0: &BuildingStatic) : u8 {
        arg0.size
    }

    public(friend) fun can_place_npc_on_tile(arg0: u8) : bool {
        arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_EMPTY()
    }

    public(friend) fun create_registry_internal(arg0: &mut 0x2::tx_context::TxContext) : MapRegistry {
        MapRegistry{
            id        : 0x2::object::new(arg0),
            templates : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public(friend) fun get_building(arg0: &MapTemplate, arg1: u16) : &BuildingStatic {
        assert!((arg1 as u64) < 0x1::vector::length<BuildingStatic>(&arg0.buildings_static), 0);
        0x1::vector::borrow<BuildingStatic>(&arg0.buildings_static, (arg1 as u64))
    }

    public(friend) fun get_building_count(arg0: &MapTemplate) : u64 {
        0x1::vector::length<BuildingStatic>(&arg0.buildings_static)
    }

    public(friend) fun get_hospital_ids(arg0: &MapTemplate) : vector<u16> {
        arg0.hospital_ids
    }

    public(friend) fun get_map_id(arg0: &MapTemplate) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_tile(arg0: &MapTemplate, arg1: u16) : &TileStatic {
        assert!((arg1 as u64) < 0x1::vector::length<TileStatic>(&arg0.tiles_static), 2002);
        0x1::vector::borrow<TileStatic>(&arg0.tiles_static, (arg1 as u64))
    }

    public(friend) fun get_tile_count(arg0: &MapTemplate) : u64 {
        0x1::vector::length<TileStatic>(&arg0.tiles_static)
    }

    public(friend) fun get_valid_neighbors(arg0: &MapTemplate, arg1: u16) : vector<u16> {
        assert!((arg1 as u64) < 0x1::vector::length<TileStatic>(&arg0.tiles_static), 2002);
        let v0 = 0x1::vector::borrow<TileStatic>(&arg0.tiles_static, (arg1 as u64));
        let v1 = vector[];
        if (v0.w != 65535) {
            0x1::vector::push_back<u16>(&mut v1, v0.w);
        };
        if (v0.n != 65535) {
            0x1::vector::push_back<u16>(&mut v1, v0.n);
        };
        if (v0.e != 65535) {
            0x1::vector::push_back<u16>(&mut v1, v0.e);
        };
        if (v0.s != 65535) {
            0x1::vector::push_back<u16>(&mut v1, v0.s);
        };
        v1
    }

    fun new_building_static(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: u16, arg5: u16) : BuildingStatic {
        BuildingStatic{
            x             : arg0,
            y             : arg1,
            size          : arg2,
            price         : arg3,
            chain_prev_id : arg4,
            chain_next_id : arg5,
        }
    }

    fun new_tile_static_with_nav(arg0: u8, arg1: u8, arg2: u8, arg3: u16, arg4: u64, arg5: u16, arg6: u16, arg7: u16, arg8: u16) : TileStatic {
        if (arg5 != 65535) {
            assert!(arg5 <= 65534, 3010);
        };
        if (arg6 != 65535) {
            assert!(arg6 <= 65534, 3010);
        };
        if (arg7 != 65535) {
            assert!(arg7 <= 65534, 3010);
        };
        if (arg8 != 65535) {
            assert!(arg8 <= 65534, 3010);
        };
        TileStatic{
            x           : arg0,
            y           : arg1,
            kind        : arg2,
            building_id : arg3,
            special     : arg4,
            w           : arg5,
            n           : arg6,
            e           : arg7,
            s           : arg8,
        }
    }

    public(friend) fun no_building() : u16 {
        65535
    }

    public(friend) fun publish_map_from_bcs(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_vec_length(&mut v0);
        let v2 = 0x1::vector::empty<BuildingStatic>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<BuildingStatic>(&mut v2, new_building_static(0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u16(&mut v0), 0x2::bcs::peel_u16(&mut v0)));
            v3 = v3 + 1;
        };
        v0 = 0x2::bcs::new(arg1);
        let v4 = 0x2::bcs::peel_vec_length(&mut v0);
        let v5 = 0x1::vector::empty<TileStatic>();
        let v6 = vector[];
        v3 = 0;
        while (v3 < v4) {
            let v7 = 0x2::bcs::peel_u8(&mut v0);
            0x1::vector::push_back<TileStatic>(&mut v5, new_tile_static_with_nav(0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), v7, 0x2::bcs::peel_u16(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u16(&mut v0), 0x2::bcs::peel_u16(&mut v0), 0x2::bcs::peel_u16(&mut v0), 0x2::bcs::peel_u16(&mut v0)));
            if (v7 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_HOSPITAL()) {
                0x1::vector::push_back<u16>(&mut v6, (v3 as u16));
            };
            v3 = v3 + 1;
        };
        let v8 = MapTemplate{
            id               : 0x2::object::new(arg3),
            schema_version   : arg0,
            tiles_static     : v5,
            buildings_static : v2,
            hospital_ids     : v6,
        };
        0x2::transfer::share_object<MapTemplate>(v8);
        (0x2::object::uid_to_inner(&v8.id), v4, v1)
    }

    public(friend) fun tile_building_id(arg0: &TileStatic) : u16 {
        arg0.building_id
    }

    public(friend) fun tile_e(arg0: &TileStatic) : u16 {
        arg0.e
    }

    public(friend) fun tile_kind(arg0: &TileStatic) : u8 {
        arg0.kind
    }

    public(friend) fun tile_n(arg0: &TileStatic) : u16 {
        arg0.n
    }

    public(friend) fun tile_s(arg0: &TileStatic) : u16 {
        arg0.s
    }

    public(friend) fun tile_special(arg0: &TileStatic) : u64 {
        arg0.special
    }

    public(friend) fun tile_w(arg0: &TileStatic) : u16 {
        arg0.w
    }

    // decompiled from Move bytecode v6
}

