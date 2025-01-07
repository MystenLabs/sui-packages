module 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector {
    struct DynamicVec<T0> has store {
        id: 0x2::object::UID,
        static: vector<T0>,
        size: u64,
        limit: u64,
    }

    public fun empty<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : DynamicVec<T0> {
        DynamicVec<T0>{
            id     : 0x2::object::new(arg1),
            static : 0x1::vector::empty<T0>(),
            size   : 0,
            limit  : arg0,
        }
    }

    public fun destroy_empty<T0: store>(arg0: DynamicVec<T0>) {
        assert!(is_empty<T0>(&arg0), 2);
        let DynamicVec {
            id     : v0,
            static : v1,
            size   : _,
            limit  : _,
        } = arg0;
        0x1::vector::destroy_empty<T0>(v1);
        0x2::object::delete(v0);
    }

    public fun remove<T0: store>(arg0: &mut DynamicVec<T0>, arg1: u64) : T0 {
        assert!(arg0.size > 0, 1);
        assert!(arg1 < arg0.size, 3);
        let (v0, v1) = chunk_index<T0>(arg0, arg1);
        let (v2, v3) = chunk_index<T0>(arg0, arg0.size - 1);
        let v4 = borrow_chunk_mut<T0>(arg0, v2);
        let v5 = if (v0 == v2) {
            if (v3 > 0) {
                0x1::vector::swap_remove<T0>(v4, v1)
            } else {
                pop_last<T0>(arg0, v2)
            }
        } else {
            let v6 = if (v3 > 0) {
                0x1::vector::pop_back<T0>(v4)
            } else {
                pop_last<T0>(arg0, v2)
            };
            let v7 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::push_back<T0>(v7, v6);
            0x1::vector::swap_remove<T0>(v7, v1)
        };
        arg0.size = arg0.size - 1;
        v5
    }

    public fun borrow_chunk<T0: store>(arg0: &DynamicVec<T0>, arg1: u64) : &vector<T0> {
        if (arg1 == 0) {
            &arg0.static
        } else {
            0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, arg1)
        }
    }

    fun borrow_chunk_mut<T0: store>(arg0: &mut DynamicVec<T0>, arg1: u64) : &mut vector<T0> {
        if (arg1 == 0) {
            &mut arg0.static
        } else {
            0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1)
        }
    }

    fun chunk_index<T0: store>(arg0: &DynamicVec<T0>, arg1: u64) : (u64, u64) {
        (arg1 / arg0.limit, arg1 % arg0.limit)
    }

    public fun clear<T0: drop + store>(arg0: &mut DynamicVec<T0>) {
        let v0 = size<T0>(arg0);
        if (v0 == 0) {
            return
        };
        let (v1, _) = chunk_index<T0>(arg0, v0 - 1);
        let v3 = v1;
        while (v3 > 0) {
            remove_chunk<T0>(arg0, v3);
            v3 = v3 - 1;
        };
        remove_chunk<T0>(arg0, 0);
        arg0.size = 0;
    }

    public fun destroy<T0: drop + store>(arg0: DynamicVec<T0>) {
        let v0 = &mut arg0;
        clear<T0>(v0);
        destroy_empty<T0>(arg0);
    }

    public fun find<T0: copy + drop + store>(arg0: &DynamicVec<T0>, arg1: T0) : u64 {
        let v0 = 0;
        while (v0 < size<T0>(arg0)) {
            let (v1, _) = chunk_index<T0>(arg0, v0);
            let v3 = borrow_chunk<T0>(arg0, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<T0>(v3)) {
                if (*0x1::vector::borrow<T0>(v3, v4) == arg1) {
                    return v0
                };
                v0 = v0 + 1;
                v4 = v4 + 1;
            };
        };
        abort 4
    }

    public fun has_chunk<T0: store>(arg0: &DynamicVec<T0>, arg1: u64) : bool {
        arg1 == 0 || 0x2::dynamic_field::exists_<u64>(&arg0.id, arg1)
    }

    fun insert_chunk<T0: store>(arg0: &mut DynamicVec<T0>, arg1: u64, arg2: T0) {
        0x2::dynamic_field::add<u64, vector<T0>>(&mut arg0.id, arg1, 0x1::vector::singleton<T0>(arg2));
    }

    public fun is_empty<T0: store>(arg0: &DynamicVec<T0>) : bool {
        arg0.size == 0
    }

    public fun limit<T0: store>(arg0: &DynamicVec<T0>) : u64 {
        arg0.limit
    }

    public fun pop<T0: store>(arg0: &mut DynamicVec<T0>) : T0 {
        let (v0, v1) = chunk_index<T0>(arg0, arg0.size - 1);
        let v2 = if (v1 > 0) {
            let v3 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::pop_back<T0>(v3)
        } else {
            pop_last<T0>(arg0, v0)
        };
        arg0.size = arg0.size - 1;
        v2
    }

    fun pop_last<T0: store>(arg0: &mut DynamicVec<T0>, arg1: u64) : T0 {
        if (arg1 == 0) {
            assert!(0x1::vector::length<T0>(&arg0.static) == 1, 5);
            0x1::vector::pop_back<T0>(&mut arg0.static)
        } else {
            let v1 = 0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.id, arg1);
            0x1::vector::destroy_empty<T0>(v1);
            0x1::vector::pop_back<T0>(&mut v1)
        }
    }

    public fun push<T0: store>(arg0: &mut DynamicVec<T0>, arg1: T0) {
        let (v0, _) = chunk_index<T0>(arg0, arg0.size);
        if (has_chunk<T0>(arg0, v0)) {
            let v2 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::push_back<T0>(v2, arg1);
        } else {
            insert_chunk<T0>(arg0, v0, arg1);
        };
        arg0.size = arg0.size + 1;
    }

    fun remove_chunk<T0: drop + store>(arg0: &mut DynamicVec<T0>, arg1: u64) {
        if (arg1 == 0) {
            arg0.static = 0x1::vector::empty<T0>();
        } else {
            0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.id, arg1);
        };
    }

    public fun remove_value<T0: copy + drop + store>(arg0: &mut DynamicVec<T0>, arg1: T0) : T0 {
        let v0 = find<T0>(arg0, arg1);
        remove<T0>(arg0, v0)
    }

    public fun size<T0: store>(arg0: &DynamicVec<T0>) : u64 {
        arg0.size
    }

    // decompiled from Move bytecode v6
}

