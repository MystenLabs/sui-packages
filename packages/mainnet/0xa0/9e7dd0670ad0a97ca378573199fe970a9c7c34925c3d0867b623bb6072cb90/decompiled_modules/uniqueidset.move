module 0xa09e7dd0670ad0a97ca378573199fe970a9c7c34925c3d0867b623bb6072cb90::uniqueidset {
    struct UniqueIdSet has store, key {
        id: 0x2::object::UID,
        id_map: 0x2::vec_map::VecMap<u16, 0x2::vec_set::VecSet<u16>>,
    }

    public fun contains(arg0: &UniqueIdSet, arg1: u32) : bool {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v1;
        let v3 = v0;
        if (!0x2::vec_map::contains<u16, 0x2::vec_set::VecSet<u16>>(&arg0.id_map, &v3)) {
            return false
        };
        0x2::vec_set::contains<u16>(0x2::vec_map::get<u16, 0x2::vec_set::VecSet<u16>>(&arg0.id_map, &v3), &v2)
    }

    public fun insert(arg0: &mut UniqueIdSet, arg1: u32) {
        insert_impl(arg0, arg1);
    }

    public fun remove(arg0: &mut UniqueIdSet, arg1: u32) {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::vec_map::contains<u16, 0x2::vec_set::VecSet<u16>>(&arg0.id_map, &v3), 512);
        0x2::vec_set::remove<u16>(0x2::vec_map::get_mut<u16, 0x2::vec_set::VecSet<u16>>(&mut arg0.id_map, &v3), &v2);
    }

    public fun burn(arg0: UniqueIdSet) {
        let UniqueIdSet {
            id     : v0,
            id_map : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun insert_all(arg0: &mut UniqueIdSet, arg1: vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            insert_impl(arg0, *0x1::vector::borrow<u32>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun insert_impl(arg0: &mut UniqueIdSet, arg1: u32) {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v0;
        if (!0x2::vec_map::contains<u16, 0x2::vec_set::VecSet<u16>>(&arg0.id_map, &v2)) {
            let v3 = 0x2::vec_set::empty<u16>();
            0x2::vec_set::insert<u16>(&mut v3, v1);
            0x2::vec_map::insert<u16, 0x2::vec_set::VecSet<u16>>(&mut arg0.id_map, v2, v3);
        } else {
            0x2::vec_set::insert<u16>(0x2::vec_map::get_mut<u16, 0x2::vec_set::VecSet<u16>>(&mut arg0.id_map, &v2), v1);
        };
    }

    public fun new_set(arg0: &mut 0x2::tx_context::TxContext) : UniqueIdSet {
        UniqueIdSet{
            id     : 0x2::object::new(arg0),
            id_map : 0x2::vec_map::empty<u16, 0x2::vec_set::VecSet<u16>>(),
        }
    }

    public fun purge(arg0: &mut UniqueIdSet) {
        arg0.id_map = 0x2::vec_map::empty<u16, 0x2::vec_set::VecSet<u16>>();
    }

    fun split_unique_id(arg0: u32) : (u16, u16) {
        ((((arg0 & 4294901760) >> 16) as u16), ((arg0 & 65535) as u16))
    }

    // decompiled from Move bytecode v6
}

