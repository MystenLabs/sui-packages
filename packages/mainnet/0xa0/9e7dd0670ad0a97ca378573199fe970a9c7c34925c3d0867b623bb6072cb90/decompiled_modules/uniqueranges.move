module 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::uniqueranges {
    struct IdRange has copy, drop, store {
        lower: u16,
        upper: u16,
    }

    struct UniqueIdRanges has store, key {
        id: 0x2::object::UID,
        range_map: 0x2::vec_map::VecMap<u64, vector<IdRange>>,
    }

    public fun insert(arg0: &mut UniqueIdRanges, arg1: u64) {
        insert_impl(arg0, arg1);
    }

    public fun contains(arg0: &UniqueIdRanges, arg1: u64) : bool {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v0;
        if (!0x2::vec_map::contains<u64, vector<IdRange>>(&arg0.range_map, &v2)) {
            return false
        };
        let v3 = 0x2::vec_map::get<u64, vector<IdRange>>(&arg0.range_map, &v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<IdRange>(v3)) {
            let v5 = *0x1::vector::borrow<IdRange>(v3, v4);
            if (v1 >= v5.lower && v1 <= v5.upper) {
                return true
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun burn(arg0: UniqueIdRanges) {
        let UniqueIdRanges {
            id        : v0,
            range_map : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun insert_all(arg0: &mut UniqueIdRanges, arg1: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            insert_impl(arg0, *0x1::vector::borrow<u64>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun insert_impl(arg0: &mut UniqueIdRanges, arg1: u64) {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v0;
        if (!0x2::vec_map::contains<u64, vector<IdRange>>(&arg0.range_map, &v2)) {
            0x2::vec_map::insert<u64, vector<IdRange>>(&mut arg0.range_map, v2, 0x1::vector::empty<IdRange>());
        };
        let v3 = 0x2::vec_map::get_mut<u64, vector<IdRange>>(&mut arg0.range_map, &v2);
        let v4 = false;
        let v5 = 0;
        let v6 = 0x1::vector::length<IdRange>(v3);
        while (v5 < v6 && !v4) {
            let v7 = *0x1::vector::borrow<IdRange>(v3, v5);
            assert!(v1 < v7.lower || v1 > v7.upper, 1537);
            if (v7.lower > 0 && v1 == v7.lower - 1) {
                0x1::vector::borrow_mut<IdRange>(v3, v5).lower = v1;
                v4 = true;
            } else if (v7.lower > 0 && v1 < v7.lower - 1) {
                let v8 = IdRange{
                    lower : v1,
                    upper : v1,
                };
                0x1::vector::insert<IdRange>(v3, v8, v5);
                v4 = true;
            } else if (v1 == v7.upper + 1) {
                if (v5 == v6 - 1) {
                    0x1::vector::borrow_mut<IdRange>(v3, v5).upper = v1;
                    v4 = true;
                } else {
                    let v9 = *0x1::vector::borrow<IdRange>(v3, v5 + 1);
                    if (v1 == v9.lower - 1) {
                        0x1::vector::borrow_mut<IdRange>(v3, v5).upper = v9.upper;
                        0x1::vector::remove<IdRange>(v3, v5 + 1);
                        v4 = true;
                    } else {
                        0x1::vector::borrow_mut<IdRange>(v3, v5).upper = v1;
                        v4 = true;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (!v4) {
            let v10 = IdRange{
                lower : v1,
                upper : v1,
            };
            0x1::vector::push_back<IdRange>(v3, v10);
        };
    }

    public fun new_set(arg0: &mut 0x2::tx_context::TxContext) : UniqueIdRanges {
        UniqueIdRanges{
            id        : 0x2::object::new(arg0),
            range_map : 0x2::vec_map::empty<u64, vector<IdRange>>(),
        }
    }

    public fun purge(arg0: &mut UniqueIdRanges) {
        arg0.range_map = 0x2::vec_map::empty<u64, vector<IdRange>>();
    }

    public fun size(arg0: &UniqueIdRanges) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<u64, vector<IdRange>>(&arg0.range_map);
        while (v1 < 0x1::vector::length<u64>(&v2)) {
            v0 = v0 + 0x1::vector::length<IdRange>(0x2::vec_map::get<u64, vector<IdRange>>(&arg0.range_map, 0x1::vector::borrow<u64>(&v2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun split_unique_id(arg0: u64) : (u64, u16) {
        (arg0 & 18446744073709486080, ((arg0 & 65535) as u16))
    }

    // decompiled from Move bytecode v6
}

