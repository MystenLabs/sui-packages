module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index {
    struct Config has copy, drop, store {
        max_vertices: u64,
        max_parts_per_polygon: u64,
        scaling_factor: u64,
        max_broadphase_span: u64,
        max_cell_occupancy: u64,
        max_probes_per_call: u64,
    }

    struct Index has store, key {
        id: 0x2::object::UID,
        cells: 0x2::table::Table<u64, vector<0x2::object::ID>>,
        polygons: 0x2::table::Table<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>,
        cell_size: u64,
        max_depth: u8,
        count: u64,
        occupied_depths: u32,
        config: Config,
        authorized_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        authorization_sealed: bool,
    }

    struct TransferCap has store, key {
        id: 0x2::object::UID,
        index_id: 0x2::object::ID,
    }

    struct LifecycleCap has store, key {
        id: 0x2::object::UID,
        index_id: 0x2::object::ID,
    }

    struct Registered has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        part_count: u64,
        cell_count: u64,
        depth: u8,
    }

    struct Removed has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
    }

    struct Transferred has copy, drop {
        polygon_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct ConfigUpdated has copy, drop {
        max_vertices: u64,
        max_parts_per_polygon: u64,
        scaling_factor: u64,
        max_broadphase_span: u64,
        max_cell_occupancy: u64,
        max_probes_per_call: u64,
    }

    public(friend) fun destroy_empty(arg0: Index) {
        let Index {
            id                   : v0,
            cells                : v1,
            polygons             : v2,
            cell_size            : _,
            max_depth            : _,
            count                : v5,
            occupied_depths      : _,
            config               : _,
            authorized_caps      : _,
            authorization_sealed : _,
        } = arg0;
        assert!(v5 == 0, 4013);
        0x2::table::destroy_empty<u64, vector<0x2::object::ID>>(v1);
        0x2::table::destroy_empty<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(v2);
        0x2::object::delete(v0);
    }

    public fun remove(arg0: &LifecycleCap, arg1: &mut Index, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<LifecycleCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.authorized_caps, &v0), 4020);
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2), 4005);
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2)) == 0x2::tx_context::sender(arg3), 4006);
        remove_unchecked(arg1, arg2);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Index {
        with_config(1000000, 20, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::max_vertices_per_part(), 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::max_parts(), 1024, 64, 2000000, arg0)
    }

    public(friend) fun assert_cap_authorized(arg0: &Index, arg1: &LifecycleCap) {
        let v0 = 0x2::object::id<LifecycleCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.authorized_caps, &v0), 4020);
    }

    public(friend) fun assert_vertex_limit(arg0: &Index, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg0.config.max_vertices * arg2, 4001);
    }

    public(friend) fun authorize_cap(arg0: &mut Index, arg1: 0x2::object::ID) {
        assert!(!arg0.authorization_sealed, 4025);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.authorized_caps, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.authorized_caps, arg1);
        };
    }

    public(friend) fun broadphase_from_aabb(arg0: &Index, arg1: u32, arg2: u32, arg3: u32, arg4: u32) : vector<0x2::object::ID> {
        let v0 = arg0.occupied_depths;
        let v1 = (popcount_u32(v0) as u64);
        if (v1 > 0) {
            assert!(((arg3 as u64) - (arg1 as u64) + 1) * ((arg4 as u64) - (arg2 as u64) + 1) * v1 <= arg0.config.max_probes_per_call, 4023);
        };
        let v2 = 0x2::vec_set::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 <= arg0.max_depth) {
            if (v0 & 1 << v3 == 0) {
                v3 = v3 + 1;
                continue
            };
            let v4 = arg0.max_depth - v3;
            let v5 = arg2 >> v4;
            while (v5 <= arg4 >> v4) {
                let v6 = arg1 >> v4;
                while (v6 <= arg3 >> v4) {
                    let v7 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton::depth_prefix(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton::interleave_n(v6, v5, v3), v3);
                    if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.cells, v7)) {
                        let v8 = 0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.cells, v7);
                        let v9 = 0;
                        while (v9 < 0x1::vector::length<0x2::object::ID>(v8)) {
                            let v10 = *0x1::vector::borrow<0x2::object::ID>(v8, v9);
                            if (!0x2::vec_set::contains<0x2::object::ID>(&v2, &v10)) {
                                0x2::vec_set::insert<0x2::object::ID>(&mut v2, v10);
                            };
                            v9 = v9 + 1;
                        };
                    };
                    v6 = v6 + 1;
                };
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        0x2::vec_set::into_keys<0x2::object::ID>(v2)
    }

    public fun candidates(arg0: &Index, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 4005);
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::bounds(0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1));
        let (v1, v2, v3, v4) = grid_bounds_for_aabb(arg0, &v0);
        let v5 = broadphase_from_aabb(arg0, v1, v2, v3, v4);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(&v5)) {
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&v5, v7);
            if (v8 != arg1) {
                0x1::vector::push_back<0x2::object::ID>(&mut v6, v8);
            };
            v7 = v7 + 1;
        };
        v6
    }

    public fun cell_size(arg0: &Index) : u64 {
        arg0.cell_size
    }

    fun check_no_overlaps(arg0: &Index, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon, arg2: u32, arg3: u32, arg4: u32, arg5: u32) {
        let v0 = broadphase_from_aabb(arg0, arg2, arg3, arg4, arg5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::intersects(arg1, 0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, *0x1::vector::borrow<0x2::object::ID>(&v0, v1)))) {
                abort 4012
            };
            v1 = v1 + 1;
        };
    }

    public fun count(arg0: &Index) : u64 {
        arg0.count
    }

    public(friend) fun decrement_count(arg0: &mut Index) {
        assert!(arg0.count > 0, 4022);
        arg0.count = arg0.count - 1;
    }

    public fun force_transfer(arg0: &TransferCap, arg1: &mut Index, arg2: 0x2::object::ID, arg3: address) {
        let v0 = 0x2::object::id<TransferCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.authorized_caps, &v0), 4020);
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2), 4005);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::set_owner(0x2::table::borrow_mut<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg1.polygons, arg2), arg3);
        let v1 = Transferred{
            polygon_id : arg2,
            from       : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2)),
            to         : arg3,
        };
        0x2::event::emit<Transferred>(v1);
    }

    public fun get(arg0: &Index, arg1: 0x2::object::ID) : &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon {
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 4005);
        0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1)
    }

    public(friend) fun grid_bounds_for_aabb(arg0: &Index, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB) : (u32, u32, u32, u32) {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(arg1) / arg0.cell_size;
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(arg1) / arg0.cell_size;
        let v2 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(arg1) / arg0.cell_size;
        let v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(arg1) / arg0.cell_size;
        assert!(v0 < 4294967295, 4016);
        assert!(v1 < 4294967295, 4016);
        assert!(v2 < 4294967295, 4016);
        assert!(v3 < 4294967295, 4016);
        assert!(v2 - v0 <= arg0.config.max_broadphase_span, 4021);
        assert!(v3 - v1 <= arg0.config.max_broadphase_span, 4021);
        ((v0 as u32), (v1 as u32), (v2 as u32), (v3 as u32))
    }

    public(friend) fun increment_count(arg0: &mut Index) {
        arg0.count = arg0.count + 1;
    }

    public fun is_sealed(arg0: &Index) : bool {
        arg0.authorization_sealed
    }

    public fun max_broadphase_span(arg0: &Index) : u64 {
        arg0.config.max_broadphase_span
    }

    public fun max_cell_occupancy(arg0: &Index) : u64 {
        arg0.config.max_cell_occupancy
    }

    public fun max_depth(arg0: &Index) : u8 {
        arg0.max_depth
    }

    public fun max_parts_per_polygon(arg0: &Index) : u64 {
        arg0.config.max_parts_per_polygon
    }

    public fun max_probes_per_call(arg0: &Index) : u64 {
        arg0.config.max_probes_per_call
    }

    public fun max_vertices_per_part(arg0: &Index) : u64 {
        arg0.config.max_vertices
    }

    public(friend) fun mint_lifecycle_cap(arg0: &mut Index, arg1: &mut 0x2::tx_context::TxContext) : LifecycleCap {
        assert!(!arg0.authorization_sealed, 4025);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.authorized_caps, 0x2::object::uid_to_inner(&v0));
        LifecycleCap{
            id       : v0,
            index_id : 0x2::object::id<Index>(arg0),
        }
    }

    public(friend) fun mint_transfer_cap(arg0: &mut Index, arg1: &mut 0x2::tx_context::TxContext) : TransferCap {
        assert!(!arg0.authorization_sealed, 4025);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.authorized_caps, 0x2::object::uid_to_inner(&v0));
        TransferCap{
            id       : v0,
            index_id : 0x2::object::id<Index>(arg0),
        }
    }

    public(friend) fun natural_depth(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u8) : u8 {
        while (arg4 > 0) {
            let v0 = arg4 - arg4;
            if (arg0 >> v0 == arg2 >> v0 && arg1 >> v0 == arg3 >> v0) {
                return arg4
            };
            arg4 = arg4 - 1;
        };
        0
    }

    public fun new_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Config {
        assert!(arg0 > 0, 4018);
        assert!(arg1 > 0, 4018);
        assert!(arg2 > 0, 4018);
        assert!(arg3 >= 2, 4018);
        assert!(arg4 >= 1, 4018);
        assert!(arg5 >= arg3 * arg3, 4018);
        Config{
            max_vertices          : arg0,
            max_parts_per_polygon : arg1,
            scaling_factor        : arg2,
            max_broadphase_span   : arg3,
            max_cell_occupancy    : arg4,
            max_probes_per_call   : arg5,
        }
    }

    public fun outer_contains_inner(arg0: &Index, arg1: 0x2::object::ID, arg2: &Index, arg3: 0x2::object::ID) : bool {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::contains_polygon(get(arg0, arg1), get(arg2, arg3))
    }

    public fun overlapping(arg0: &Index, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = candidates(arg0, arg1);
        let v1 = 0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1);
        let v2 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::bounds(v1);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&v0, v4);
            let v6 = 0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, v5);
            let v7 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::bounds(v6);
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v2, &v7)) {
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::intersects(v1, v6)) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v3, v5);
                };
            };
            v4 = v4 + 1;
        };
        v3
    }

    public fun overlaps(arg0: &Index, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 4005);
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg2), 4005);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::intersects(0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg2))
    }

    fun popcount_u32(arg0: u32) : u8 {
        let v0 = 0;
        while (arg0 != 0) {
            let v1 = arg0 - 1;
            arg0 = arg0 & v1;
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun put_polygon(arg0: &mut Index, arg1: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon) : 0x2::object::ID {
        let v0 = 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1);
        0x2::table::add<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg0.polygons, v0, arg1);
        v0
    }

    public fun query_viewport(arg0: &Index, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : vector<0x2::object::ID> {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::new(arg1, arg2, arg3, arg4);
        let (v1, v2, v3, v4) = grid_bounds_for_aabb(arg0, &v0);
        broadphase_from_aabb(arg0, v1, v2, v3, v4)
    }

    public fun register(arg0: &LifecycleCap, arg1: &mut Index, arg2: vector<vector<u64>>, arg3: vector<vector<u64>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<LifecycleCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.authorized_caps, &v0), 4020);
        let v1 = 0x1::vector::length<vector<u64>>(&arg2);
        assert!(v1 >= 1, 4010);
        assert!(v1 == 0x1::vector::length<vector<u64>>(&arg3), 4002);
        assert!(v1 <= arg1.config.max_parts_per_polygon, 4010);
        let v2 = 0x1::vector::empty<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Part>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::remove<vector<u64>>(&mut arg2, 0);
            let v6 = 0x1::vector::length<u64>(&v5);
            assert!(v6 >= 3, 4001);
            v3 = v3 + v6;
            0x1::vector::push_back<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Part>(&mut v2, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::part(v5, 0x1::vector::remove<vector<u64>>(&mut arg3, 0)));
            v4 = v4 + 1;
        };
        assert!(v3 <= arg1.config.max_vertices * v1, 4001);
        let v7 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::new(v2, arg4);
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::area(&v7) > 0, 4017);
        let v8 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::bounds(&v7);
        let (v9, v10, v11, v12) = grid_bounds_for_aabb(arg1, &v8);
        let v13 = natural_depth(v9, v10, v11, v12, arg1.max_depth);
        let v14 = arg1.max_depth - v13;
        let v15 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton::depth_prefix(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton::interleave_n(v9 >> v14, v10 >> v14, v13), v13);
        check_no_overlaps(arg1, &v7, v9, v10, v11, v12);
        let v16 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v16, v15);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::set_cells(&mut v7, v16);
        let v17 = 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&v7);
        register_in_cell(arg1, v17, v15, v13);
        0x2::table::add<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg1.polygons, v17, v7);
        arg1.count = arg1.count + 1;
        let v18 = Registered{
            polygon_id : v17,
            owner      : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(&v7),
            part_count : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::parts(&v7),
            cell_count : 1,
            depth      : v13,
        };
        0x2::event::emit<Registered>(v18);
        v17
    }

    public(friend) fun register_in_cell(arg0: &mut Index, arg1: 0x2::object::ID, arg2: u64, arg3: u8) {
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.cells, arg2)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.cells, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.cells, arg2);
        let (v1, _) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg1);
        if (!v1) {
            assert!(0x1::vector::length<0x2::object::ID>(v0) < arg0.config.max_cell_occupancy, 4024);
            0x1::vector::push_back<0x2::object::ID>(v0, arg1);
            arg0.occupied_depths = arg0.occupied_depths | 1 << arg3;
        };
    }

    public(friend) fun remove_unchecked(arg0: &mut Index, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 4005);
        let v0 = 0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1);
        let v1 = *0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::cells(v0);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::force_remove_metadata(&mut arg0.id, arg1);
        unregister_from_cells(arg0, arg1, &v1);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::destroy(0x2::table::remove<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg0.polygons, arg1));
        arg0.count = arg0.count - 1;
        let v2 = Removed{
            polygon_id : arg1,
            owner      : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(v0),
        };
        0x2::event::emit<Removed>(v2);
    }

    public(friend) fun revoke_cap(arg0: &mut Index, arg1: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.authorized_caps, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.authorized_caps, &arg1);
        };
    }

    public fun scaling_factor(arg0: &Index) : u64 {
        arg0.config.scaling_factor
    }

    public(friend) fun seal(arg0: &mut Index) {
        arg0.authorization_sealed = true;
    }

    public(friend) fun set_config(arg0: &mut Index, arg1: Config) {
        assert!(arg1.max_broadphase_span <= 1 << arg0.max_depth, 4018);
        let v0 = ConfigUpdated{
            max_vertices          : arg1.max_vertices,
            max_parts_per_polygon : arg1.max_parts_per_polygon,
            scaling_factor        : arg1.scaling_factor,
            max_broadphase_span   : arg1.max_broadphase_span,
            max_cell_occupancy    : arg1.max_cell_occupancy,
            max_probes_per_call   : arg1.max_probes_per_call,
        };
        0x2::event::emit<ConfigUpdated>(v0);
        arg0.config = arg1;
    }

    public(friend) fun set_polygon_geometry(arg0: &mut Index, arg1: 0x2::object::ID, arg2: vector<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Part>, arg3: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg0.polygons, arg1);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::set_parts(v0, arg2);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg3);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::set_cells(v0, v1);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::area(v0)
    }

    public(friend) fun share(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Index>(new(arg0));
    }

    public(friend) fun share_existing(arg0: Index) {
        0x2::transfer::share_object<Index>(arg0);
    }

    public(friend) fun share_with_config(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Index>(with_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public(friend) fun take_polygon(arg0: &mut Index, arg1: 0x2::object::ID) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon {
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg0.polygons, arg1), 4005);
        0x2::table::remove<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg0.polygons, arg1)
    }

    public fun transfer_ownership(arg0: &LifecycleCap, arg1: &mut Index, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<LifecycleCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.authorized_caps, &v0), 4020);
        assert!(0x2::table::contains<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2), 4005);
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0x2::table::borrow<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&arg1.polygons, arg2));
        assert!(v1 == 0x2::tx_context::sender(arg4), 4006);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::set_owner(0x2::table::borrow_mut<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(&mut arg1.polygons, arg2), arg3);
        let v2 = Transferred{
            polygon_id : arg2,
            from       : v1,
            to         : arg3,
        };
        0x2::event::emit<Transferred>(v2);
    }

    public(friend) fun uid(arg0: &Index) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Index) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unregister_from_cells(arg0: &mut Index, arg1: 0x2::object::ID, arg2: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg2)) {
            let v1 = *0x1::vector::borrow<u64>(arg2, v0);
            if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.cells, v1)) {
                let v2 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.cells, v1);
                let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(v2, &arg1);
                if (v3) {
                    0x1::vector::remove<0x2::object::ID>(v2, v4);
                    if (0x1::vector::length<0x2::object::ID>(v2) == 0) {
                        0x1::vector::destroy_empty<0x2::object::ID>(0x2::table::remove<u64, vector<0x2::object::ID>>(&mut arg0.cells, v1));
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun unseal(arg0: &mut Index) {
        arg0.authorization_sealed = false;
    }

    public(friend) fun with_config(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Index {
        assert!(arg0 > 0, 4014);
        assert!(arg1 > 0 && arg1 <= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton::max_depth(), 4009);
        Index{
            id                   : 0x2::object::new(arg7),
            cells                : 0x2::table::new<u64, vector<0x2::object::ID>>(arg7),
            polygons             : 0x2::table::new<0x2::object::ID, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::Polygon>(arg7),
            cell_size            : arg0,
            max_depth            : arg1,
            count                : 0,
            occupied_depths      : 0,
            config               : new_config(arg2, arg3, 1000000, arg4, arg5, arg6),
            authorized_caps      : 0x2::vec_set::empty<0x2::object::ID>(),
            authorization_sealed : false,
        }
    }

    // decompiled from Move bytecode v7
}

