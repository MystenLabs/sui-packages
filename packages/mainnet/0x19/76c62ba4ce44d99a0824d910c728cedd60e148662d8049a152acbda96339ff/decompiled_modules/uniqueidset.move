module 0x1976c62ba4ce44d99a0824d910c728cedd60e148662d8049a152acbda96339ff::uniqueidset {
    struct UniqueIdSet has store, key {
        id: 0x2::object::UID,
        id1_values: vector<u16>,
        id2_sets: vector<0x2::vec_set::VecSet<u16>>,
    }

    public fun contains(arg0: &UniqueIdSet, arg1: u32) : bool {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1::vector::index_of<u16>(&arg0.id1_values, &v3);
        if (!v4) {
            return false
        };
        0x2::vec_set::contains<u16>(0x1::vector::borrow<0x2::vec_set::VecSet<u16>>(&arg0.id2_sets, v5), &v2)
    }

    public fun insert(arg0: &mut UniqueIdSet, arg1: u32) {
        insert_impl(arg0, arg1);
    }

    public fun remove(arg0: &mut UniqueIdSet, arg1: u32) {
        let (v0, v1) = split_unique_id(arg1);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1::vector::index_of<u16>(&arg0.id1_values, &v3);
        assert!(v4, 512);
        0x2::vec_set::remove<u16>(0x1::vector::borrow_mut<0x2::vec_set::VecSet<u16>>(&mut arg0.id2_sets, v5), &v2);
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
        let (v3, v4) = 0x1::vector::index_of<u16>(&arg0.id1_values, &v2);
        if (v3) {
            0x2::vec_set::insert<u16>(0x1::vector::borrow_mut<0x2::vec_set::VecSet<u16>>(&mut arg0.id2_sets, v4), v1);
        } else {
            let v5 = 0x2::vec_set::empty<u16>();
            0x2::vec_set::insert<u16>(&mut v5, v1);
            0x1::vector::push_back<u16>(&mut arg0.id1_values, v2);
            0x1::vector::push_back<0x2::vec_set::VecSet<u16>>(&mut arg0.id2_sets, v5);
        };
    }

    public fun new_set(arg0: &mut 0x2::tx_context::TxContext) : UniqueIdSet {
        UniqueIdSet{
            id         : 0x2::object::new(arg0),
            id1_values : 0x1::vector::empty<u16>(),
            id2_sets   : 0x1::vector::empty<0x2::vec_set::VecSet<u16>>(),
        }
    }

    fun split_unique_id(arg0: u32) : (u16, u16) {
        ((((arg0 & 4294901760) >> 16) as u16), ((arg0 & 65535) as u16))
    }

    // decompiled from Move bytecode v6
}

