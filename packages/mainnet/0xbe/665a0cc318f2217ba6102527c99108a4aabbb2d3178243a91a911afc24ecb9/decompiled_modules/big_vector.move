module 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::big_vector {
    struct BigVector<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        depth: u8,
        length: u64,
        max_slice_size: u64,
        max_fan_out: u64,
        root_id: u64,
        last_id: u64,
    }

    struct Slice<T0: store> has drop, store {
        prev: u64,
        next: u64,
        keys: vector<u128>,
        vals: vector<T0>,
        size: u64,
    }

    struct SliceRef has copy, drop, store {
        ix: u64,
    }

    public(friend) fun empty<T0: store>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
        assert!(2 <= arg0, 0);
        assert!(arg0 <= 262144, 1);
        assert!(4 <= arg1, 2);
        assert!(arg1 <= 4096, 3);
        BigVector<T0>{
            id             : 0x2::object::new(arg2),
            depth          : 0,
            length         : 0,
            max_slice_size : arg0,
            max_fan_out    : arg1,
            root_id        : 0,
            last_id        : 0,
        }
    }

    public(friend) fun length<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.length
    }

    public(friend) fun borrow<T0: store>(arg0: &BigVector<T0>, arg1: u128) : &T0 {
        let (v0, v1) = slice_around<T0>(arg0, arg1);
        slice_borrow<T0>(borrow_slice<T0>(arg0, v0), v1)
    }

    public(friend) fun borrow_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u128) : &mut T0 {
        let (v0, v1) = slice_around<T0>(arg0, arg1);
        let v2 = borrow_slice_mut<T0>(arg0, v0);
        slice_borrow_mut<T0>(v2, v1)
    }

    public(friend) fun destroy_empty<T0: store>(arg0: BigVector<T0>) {
        let BigVector {
            id             : v0,
            depth          : _,
            length         : v2,
            max_slice_size : _,
            max_fan_out    : _,
            root_id        : _,
            last_id        : _,
        } = arg0;
        assert!(v2 == 0, 4);
        0x2::object::delete(v0);
    }

    public(friend) fun insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u128, arg2: T0) {
        arg0.length = arg0.length + 1;
        if (arg0.root_id == 0) {
            let v0 = alloc<T0, T0>(arg0, singleton<T0>(arg1, arg2));
            arg0.root_id = v0;
            return
        };
        let v1 = arg0.root_id;
        let v2 = arg0.depth;
        let (v3, v4) = slice_insert<T0>(arg0, v1, v2, arg1, arg2);
        if (v4 != 0) {
            let v5 = branch<T0>(arg0, v3, v1, v4);
            let v6 = alloc<T0, u64>(arg0, v5);
            arg0.root_id = v6;
            arg0.depth = arg0.depth + 1;
        };
    }

    public(friend) fun is_empty<T0: store>(arg0: &BigVector<T0>) : bool {
        arg0.length == 0
    }

    public(friend) fun remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u128) : T0 {
        if (arg0.root_id == 0) {
            abort 5
        };
        arg0.length = arg0.length - 1;
        let v0 = arg0.root_id;
        let v1 = arg0.depth;
        let (v2, v3, _) = slice_remove<T0>(arg0, 0, 0, v0, 0, 0, v1, arg1);
        if (v3 == 1) {
            if (arg0.depth == 0) {
                let Slice {
                    prev : _,
                    next : _,
                    keys : _,
                    vals : v8,
                    size : _,
                } = 0x2::dynamic_field::remove<u64, Slice<T0>>(&mut arg0.id, v0);
                0x1::vector::destroy_empty<T0>(v8);
                arg0.root_id = 0;
            } else {
                let v10 = 0x2::dynamic_field::remove<u64, Slice<u64>>(&mut arg0.id, v0);
                arg0.root_id = 0x1::vector::pop_back<u64>(&mut v10.vals);
                arg0.depth = arg0.depth - 1;
            };
        };
        v2
    }

    fun alloc<T0: store, T1: store>(arg0: &mut BigVector<T0>, arg1: Slice<T1>) : u64 {
        let v0 = arg1.prev;
        let v1 = arg1.next;
        arg0.last_id = arg0.last_id + 1;
        0x2::dynamic_field::add<u64, Slice<T1>>(&mut arg0.id, arg0.last_id, arg1);
        let v2 = arg0.last_id;
        if (v0 != 0) {
            0x2::dynamic_field::borrow_mut<u64, Slice<T1>>(&mut arg0.id, v0).next = v2;
        };
        if (v1 != 0) {
            0x2::dynamic_field::borrow_mut<u64, Slice<T1>>(&mut arg0.id, v1).prev = v2;
        };
        v2
    }

    public(friend) fun borrow_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef) : &Slice<T0> {
        0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg1.ix)
    }

    public(friend) fun borrow_slice_internal<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef) : &Slice<u64> {
        0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1.ix)
    }

    public(friend) fun borrow_slice_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: SliceRef) : &mut Slice<T0> {
        0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg1.ix)
    }

    fun branch<T0: store>(arg0: &BigVector<T0>, arg1: u128, arg2: u64, arg3: u64) : Slice<u64> {
        let v0 = 0;
        let v1 = v0;
        if (arg2 != 0) {
            if (0x2::dynamic_field::exists_with_type<u64, Slice<u64>>(&arg0.id, arg2)) {
                v1 = v0 + 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg2).size;
            } else {
                assert!(0x2::dynamic_field::exists_with_type<u64, Slice<T0>>(&arg0.id, arg2), 6969);
                v1 = v0 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg2).size;
            };
        };
        if (arg3 != 0) {
            if (0x2::dynamic_field::exists_with_type<u64, Slice<u64>>(&arg0.id, arg3)) {
                v1 = v1 + 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg3).size;
            } else {
                assert!(0x2::dynamic_field::exists_with_type<u64, Slice<T0>>(&arg0.id, arg3), 696969);
                v1 = v1 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg3).size;
            };
        };
        let v2 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v2, arg1);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, arg3);
        Slice<u64>{
            prev : 0,
            next : 0,
            keys : v2,
            vals : v3,
            size : v1,
        }
    }

    public fun create_slice_ref(arg0: u64) : SliceRef {
        SliceRef{ix: arg0}
    }

    public(friend) fun depth<T0: store>(arg0: &BigVector<T0>) : u8 {
        arg0.depth
    }

    fun drop_slice<T0: drop + store>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (arg1 == 0) {
            0x2::dynamic_field::remove<u64, Slice<T0>>(arg0, arg2);
        } else {
            let v0 = 0x2::dynamic_field::remove<u64, Slice<u64>>(arg0, arg2);
            while (!0x1::vector::is_empty<u64>(&v0.vals)) {
                drop_slice<T0>(arg0, arg1 - 1, 0x1::vector::pop_back<u64>(&mut v0.vals));
            };
        };
    }

    public fun find_key_at_rank<T0: store>(arg0: &BigVector<T0>, arg1: u64) : (u128, &T0) {
        if (arg0.root_id == 0) {
            abort 5
        };
        let v0 = 0;
        let v1 = arg0.root_id;
        let v2 = arg0.depth;
        while (v2 > 0) {
            let v3 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v1);
            let v4 = 0;
            let v5 = false;
            while (v4 < 0x1::vector::length<u128>(&v3.keys)) {
                let v6 = *0x1::vector::borrow<u64>(&v3.vals, v4);
                let v7 = safe_borrow_size<T0>(arg0, v6);
                if (v0 + v7 > arg1) {
                    v1 = v6;
                    v5 = true;
                    break
                };
                v0 = v0 + v7;
                v4 = v4 + 1;
            };
            if (!v5) {
                v1 = *0x1::vector::borrow<u64>(&v3.vals, 0x1::vector::length<u128>(&v3.keys));
            };
            v2 = v2 - 1;
        };
        let v8 = 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(&v8.keys)) {
            if (v0 == arg1) {
                return (*0x1::vector::borrow<u128>(&v8.keys, v9), 0x1::vector::borrow<T0>(&v8.vals, v9))
            };
            v0 = v0 + 1;
            v9 = v9 + 1;
        };
        if (0x1::vector::length<u128>(&v8.keys) > 0) {
            (*0x1::vector::borrow<u128>(&v8.keys, 0x1::vector::length<u128>(&v8.keys) - 1), 0x1::vector::borrow<T0>(&v8.vals, 0x1::vector::length<u128>(&v8.keys) - 1))
        } else {
            (0, 0x1::vector::borrow<T0>(&v8.vals, 0x1::vector::length<u128>(&v8.keys) - 1))
        }
    }

    fun find_leaf<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (u64, &Slice<T0>, u64) {
        let v0 = arg0.depth;
        let v1 = arg0.root_id;
        while (v0 > 0) {
            let v2 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v1);
            v1 = *0x1::vector::borrow<u64>(&v2.vals, slice_bisect_right<u64>(v2, arg1));
            v0 = v0 - 1;
        };
        let v3 = 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v1);
        (v1, v3, slice_bisect_left<T0>(v3, arg1))
    }

    fun find_max_leaf<T0: store>(arg0: &BigVector<T0>) : (u64, &Slice<T0>, u64) {
        let v0 = arg0.depth;
        let v1 = arg0.root_id;
        while (v0 > 0) {
            let v2 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v1);
            v1 = *0x1::vector::borrow<u64>(&v2.vals, 0x1::vector::length<u128>(&v2.keys));
            v0 = v0 - 1;
        };
        let v3 = 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v1);
        (v1, v3, 0x1::vector::length<u128>(&v3.keys) - 1)
    }

    fun find_min_leaf<T0: store>(arg0: &BigVector<T0>) : (u64, &Slice<T0>, u64) {
        let v0 = arg0.depth;
        let v1 = arg0.root_id;
        while (v0 > 0) {
            let v2 = 0x1::vector::borrow<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v1).vals, 0);
            v1 = *v2;
            v0 = v0 - 1;
        };
        (v1, 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v1), 0)
    }

    public fun find_rank<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (u64, &T0) {
        if (arg0.root_id == 0) {
            abort 5
        };
        let v0 = arg0.depth;
        let v1 = arg0.root_id;
        let v2 = 0;
        while (v0 > 0) {
            let v3 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v1);
            let v4 = slice_bisect_right<u64>(v3, arg1);
            let v5 = 0;
            while (v5 < v4) {
                v2 = v2 + safe_borrow_size<T0>(arg0, *0x1::vector::borrow<u64>(&v3.vals, v5));
                v5 = v5 + 1;
            };
            v1 = *0x1::vector::borrow<u64>(&v3.vals, v4);
            v0 = v0 - 1;
        };
        let v6 = 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v1);
        let v7 = slice_bisect_left<T0>(v6, arg1);
        (v2 + v7, 0x1::vector::borrow<T0>(&v6.vals, v7))
    }

    public(friend) fun inorder_values<T0: copy + store>(arg0: &BigVector<T0>) : vector<vector<T0>> {
        let v0 = 0x1::vector::empty<vector<T0>>();
        if (arg0.root_id == 0) {
            return v0
        };
        let v1 = arg0.depth;
        let v2 = arg0.root_id;
        while (v1 > 0) {
            let v3 = 0x1::vector::borrow<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, v2).vals, 0);
            v2 = *v3;
            v1 = v1 - 1;
        };
        while (v2 != 0) {
            let v4 = 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, v2);
            0x1::vector::push_back<vector<T0>>(&mut v0, v4.vals);
            v2 = v4.next;
        };
        v0
    }

    fun leaf_insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: T0) : (u128, u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg1);
        let v1 = slice_bisect_left<T0>(v0, arg2);
        if (v1 < 0x1::vector::length<u128>(&v0.keys) && arg2 == *0x1::vector::borrow<u128>(&v0.keys, v1)) {
            abort 6
        };
        if (0x1::vector::length<u128>(&v0.keys) < arg0.max_slice_size) {
            0x1::vector::insert<u128>(&mut v0.keys, arg2, v1);
            0x1::vector::insert<T0>(&mut v0.vals, arg3, v1);
            v0.size = v0.size + 1;
            assert!(v0.size > 0, 111);
            return (0, 0)
        };
        let v2 = 0x1::vector::length<T0>(&v0.vals) / 2;
        let v3 = Slice<T0>{
            prev : arg1,
            next : v0.next,
            keys : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<u128>(&mut v0.keys, v2),
            vals : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<T0>(&mut v0.vals, v2),
            size : 0,
        };
        let v4 = *0x1::vector::borrow<u128>(&v3.keys, 0);
        if (arg2 < v4) {
            0x1::vector::insert<u128>(&mut v0.keys, arg2, v1);
            0x1::vector::insert<T0>(&mut v0.vals, arg3, v1);
        } else {
            0x1::vector::insert<u128>(&mut v3.keys, arg2, v1 - v2);
            0x1::vector::insert<T0>(&mut v3.vals, arg3, v1 - v2);
        };
        v0.size = 0x1::vector::length<T0>(&v0.vals);
        v3.size = 0x1::vector::length<T0>(&v3.vals);
        assert!(v0.size > 0, 111);
        assert!(v3.size > 0, 111);
        (v4, alloc<T0, T0>(arg0, v3))
    }

    fun leaf_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u128) : (T0, u8, u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg3);
        let v1 = slice_bisect_left<T0>(v0, arg6);
        if (v1 >= 0x1::vector::length<u128>(&v0.keys)) {
            abort 5
        };
        if (arg6 != *0x1::vector::borrow<u128>(&v0.keys, v1)) {
            abort 5
        };
        0x1::vector::remove<u128>(&mut v0.keys, v1);
        v0.size = v0.size - 1;
        let (v2, v3, v4) = try_redistribute_leaf<T0>(arg0, arg1, arg3, arg5, arg4, arg2, 0x1::vector::length<T0>(&v0.vals), 0x1::vector::remove<T0>(&mut v0.vals, v1));
        let v5 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg3);
        if (v3 == 2) {
            v5.size = 0x1::vector::length<T0>(&v5.vals);
        } else if (v3 == 3) {
            v5.size = 0x1::vector::length<T0>(&v5.vals);
        };
        (v2, v3, v4)
    }

    public(friend) fun max_slice<T0: store>(arg0: &BigVector<T0>) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, _, v3) = find_max_leaf<T0>(arg0);
        let v4 = SliceRef{ix: v1};
        (v4, v3)
    }

    public(friend) fun max_slice_size<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.max_slice_size
    }

    public(friend) fun min_slice<T0: store>(arg0: &BigVector<T0>) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, _, v3) = find_min_leaf<T0>(arg0);
        let v4 = SliceRef{ix: v1};
        (v4, v3)
    }

    public(friend) fun next_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef, arg2: u64) : (SliceRef, u64) {
        let v0 = borrow_slice<T0>(arg0, arg1);
        if (arg2 + 1 < 0x1::vector::length<T0>(&v0.vals)) {
            (arg1, arg2 + 1)
        } else {
            (slice_next<T0>(v0), 0)
        }
    }

    fun node_insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u8, arg3: u128, arg4: T0) : (u128, u64) {
        let v0 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1);
        let v1 = slice_bisect_right<u64>(v0, arg3);
        let (v2, v3) = slice_insert<T0>(arg0, *0x1::vector::borrow<u64>(&v0.vals, v1), arg2, arg3, arg4);
        if (v3 == 0) {
            let v4 = 0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1);
            v4.size = v4.size + 1;
            assert!(v4.size > 0, 111);
            return (0, 0)
        };
        let v5 = 0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1);
        if (0x1::vector::length<u64>(&v5.vals) < arg0.max_fan_out) {
            0x1::vector::insert<u128>(&mut v5.keys, v2, v1);
            0x1::vector::insert<u64>(&mut v5.vals, v3, v1 + 1);
            v5.size = v5.size + 1;
            assert!(v5.size > 0, 111);
            return (0, 0)
        };
        let v6 = 0x1::vector::length<u64>(&v5.vals) / 2;
        let v7 = Slice<u64>{
            prev : arg1,
            next : v5.next,
            keys : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<u128>(&mut v5.keys, v6),
            vals : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<u64>(&mut v5.vals, v6),
            size : 0,
        };
        let v8 = 0x1::vector::pop_back<u128>(&mut v5.keys);
        if (v2 < v8) {
            0x1::vector::insert<u128>(&mut v5.keys, v2, v1);
            0x1::vector::insert<u64>(&mut v5.vals, v3, v1 + 1);
        } else {
            0x1::vector::insert<u128>(&mut v7.keys, v2, v1 - v6);
            0x1::vector::insert<u64>(&mut v7.vals, v3, v1 - v6 + 1);
        };
        v5.size = 0;
        v7.size = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1);
        while (v9 < 0x1::vector::length<u64>(&v11.vals)) {
            v10 = v10 + safe_borrow_size<T0>(arg0, *0x1::vector::borrow<u64>(&v11.vals, v9));
            v9 = v9 + 1;
        };
        v9 = 0;
        let v12 = 0;
        while (v9 < 0x1::vector::length<u64>(&v7.vals)) {
            v12 = v12 + safe_borrow_size<T0>(arg0, *0x1::vector::borrow<u64>(&v7.vals, v9));
            v9 = v9 + 1;
        };
        0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1).size = v10;
        v7.size = v12;
        assert!(v12 > 0, 111);
        assert!(v10 > 0, 111);
        (v8, alloc<T0, u64>(arg0, v7))
    }

    fun node_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u8, arg7: u128) : (T0, u8, u128) {
        let v0 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg3);
        let v1 = slice_bisect_right<u64>(v0, arg7);
        let (v2, v3) = if (v1 == 0) {
            (0, 0)
        } else {
            (*0x1::vector::borrow<u64>(&v0.vals, v1 - 1), *0x1::vector::borrow<u128>(&v0.keys, v1 - 1))
        };
        let (v4, v5) = if (v1 == 0x1::vector::length<u128>(&v0.keys)) {
            (0, 0)
        } else {
            (*0x1::vector::borrow<u64>(&v0.vals, v1 + 1), *0x1::vector::borrow<u128>(&v0.keys, v1))
        };
        let (v6, v7, v8) = slice_remove<T0>(arg0, v2, v3, *0x1::vector::borrow<u64>(&v0.vals, v1), v5, v4, arg6, arg7);
        let v9 = 0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg3);
        if (v9.size > 0) {
            v9.size = v9.size - 1;
        };
        if (v7 == 0) {
            return (v6, 0, 0)
        };
        if (v7 == 2) {
            *0x1::vector::borrow_mut<u128>(&mut v9.keys, v1 - 1) = v8;
            return (v6, 0, 0)
        };
        if (v7 == 3) {
            *0x1::vector::borrow_mut<u128>(&mut v9.keys, v1) = v8;
            return (v6, 0, 0)
        };
        if (v7 == 4) {
            0x1::vector::remove<u128>(&mut v9.keys, v1 - 1);
            0x1::vector::remove<u64>(&mut v9.vals, v1);
        } else {
            assert!(v7 == 5, 7);
            0x1::vector::remove<u128>(&mut v9.keys, v1);
            0x1::vector::remove<u64>(&mut v9.vals, v1 + 1);
        };
        let v10 = 0x1::vector::length<u64>(&v9.vals);
        if (v10 >= arg0.max_fan_out / 2) {
            return (v6, 0, 0)
        };
        let (v11, v12, v13) = try_redistribute_node<T0>(arg0, arg1, arg3, arg5, arg4, arg2, v10, v6);
        update_size<T0>(arg0, arg1, arg3, arg5, v12);
        (v11, v12, v13)
    }

    public(friend) fun prev_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef, arg2: u64) : (SliceRef, u64) {
        let v0 = borrow_slice<T0>(arg0, arg1);
        if (arg2 > 0) {
            (arg1, arg2 - 1)
        } else {
            let v3 = 0;
            let v4 = slice_prev<T0>(v0);
            if (!slice_is_null(&v4)) {
                v3 = 0x1::vector::length<T0>(&borrow_slice<T0>(arg0, v4).vals) - 1;
            };
            (v4, v3)
        }
    }

    public(friend) fun remove_batch<T0: store>(arg0: &mut BigVector<T0>, arg1: vector<u128>) : vector<T0> {
        abort 0
    }

    public(friend) fun root_id<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.root_id
    }

    public fun safe_borrow_size<T0: store>(arg0: &BigVector<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = v0;
        if (arg1 != 0) {
            if (0x2::dynamic_field::exists_with_type<u64, Slice<u64>>(&arg0.id, arg1)) {
                v1 = v0 + 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1).size;
            } else {
                assert!(0x2::dynamic_field::exists_with_type<u64, Slice<T0>>(&arg0.id, arg1), 69);
                v1 = v0 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg1).size;
            };
        };
        v1
    }

    fun singleton<T0: store>(arg0: u128, arg1: T0) : Slice<T0> {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, arg0);
        let v1 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v1, arg1);
        Slice<T0>{
            prev : 0,
            next : 0,
            keys : v0,
            vals : v1,
            size : 1,
        }
    }

    public(friend) fun size<T0: store>(arg0: &Slice<T0>) : u64 {
        arg0.size
    }

    public(friend) fun slice_around<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            abort 5
        };
        let (v0, v1, v2) = find_leaf<T0>(arg0, arg1);
        if (v2 >= 0x1::vector::length<u128>(&v1.keys)) {
            abort 5
        };
        if (arg1 != *0x1::vector::borrow<u128>(&v1.keys, v2)) {
            abort 5
        };
        let v3 = SliceRef{ix: v0};
        (v3, v2)
    }

    public(friend) fun slice_before<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, v2, v3) = find_leaf<T0>(arg0, arg1);
        if (v3 == 0) {
            let v6 = slice_prev<T0>(v2);
            if (slice_is_null(&v6)) {
                let v7 = SliceRef{ix: 0};
                (v7, 0)
            } else {
                (v6, 0x1::vector::length<u128>(&borrow_slice<T0>(arg0, v6).keys) - 1)
            }
        } else {
            let v8 = SliceRef{ix: v1};
            (v8, v3 - 1)
        }
    }

    fun slice_bisect_left<T0: store>(arg0: &Slice<T0>, arg1: u128) : u64 {
        let v0 = 0x1::vector::length<u128>(&arg0.keys);
        let v1 = 0;
        while (v1 < v0) {
            v0 = (v0 - v1) / 2 + v1;
            if (arg1 <= *0x1::vector::borrow<u128>(&arg0.keys, v0)) {
                continue
            };
            v1 = v0 + 1;
        };
        v1
    }

    public fun slice_bisect_right<T0: store>(arg0: &Slice<T0>, arg1: u128) : u64 {
        let v0 = 0x1::vector::length<u128>(&arg0.keys);
        let v1 = 0;
        while (v1 < v0) {
            v0 = (v0 - v1) / 2 + v1;
            if (arg1 < *0x1::vector::borrow<u128>(&arg0.keys, v0)) {
                continue
            };
            v1 = v0 + 1;
        };
        v1
    }

    public(friend) fun slice_borrow<T0: store>(arg0: &Slice<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(&arg0.vals, arg1)
    }

    public(friend) fun slice_borrow_mut<T0: store>(arg0: &mut Slice<T0>, arg1: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(&mut arg0.vals, arg1)
    }

    public(friend) fun slice_following<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, v2, v3) = find_leaf<T0>(arg0, arg1);
        if (v3 >= 0x1::vector::length<u128>(&v2.keys)) {
            (slice_next<T0>(v2), 0)
        } else {
            let v6 = SliceRef{ix: v1};
            (v6, v3)
        }
    }

    fun slice_insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u8, arg3: u128, arg4: T0) : (u128, u64) {
        if (arg2 == 0) {
            leaf_insert<T0>(arg0, arg1, arg3, arg4)
        } else {
            node_insert<T0>(arg0, arg1, arg2 - 1, arg3, arg4)
        }
    }

    public(friend) fun slice_is_leaf<T0: store>(arg0: &Slice<T0>) : bool {
        0x1::vector::length<T0>(&arg0.vals) == 0x1::vector::length<u128>(&arg0.keys)
    }

    public(friend) fun slice_is_null(arg0: &SliceRef) : bool {
        arg0.ix == 0
    }

    public(friend) fun slice_key<T0: store>(arg0: &Slice<T0>, arg1: u64) : u128 {
        *0x1::vector::borrow<u128>(&arg0.keys, arg1)
    }

    public(friend) fun slice_length<T0: store>(arg0: &Slice<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.vals)
    }

    fun slice_merge<T0: store, T1: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64) {
        let v0 = 0x2::dynamic_field::remove<u64, Slice<T1>>(&mut arg0.id, arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<u64, Slice<T1>>(&mut arg0.id, arg1);
        assert!(v1.next == arg3, 8);
        assert!(v0.prev == arg1, 8);
        if (!slice_is_leaf<T1>(v1)) {
            0x1::vector::push_back<u128>(&mut v1.keys, arg2);
        };
        let Slice {
            prev : _,
            next : v3,
            keys : v4,
            vals : v5,
            size : v6,
        } = v0;
        0x1::vector::append<u128>(&mut v1.keys, v4);
        0x1::vector::append<T1>(&mut v1.vals, v5);
        v1.size = v1.size + v6;
        assert!(v1.size > 0, 111);
        v1.next = v3;
        if (v3 != 0) {
            0x2::dynamic_field::borrow_mut<u64, Slice<T1>>(&mut arg0.id, v3).prev = arg1;
        };
    }

    public(friend) fun slice_next<T0: store>(arg0: &Slice<T0>) : SliceRef {
        SliceRef{ix: arg0.next}
    }

    public(friend) fun slice_prev<T0: store>(arg0: &Slice<T0>) : SliceRef {
        SliceRef{ix: arg0.prev}
    }

    fun slice_redistribute<T0: store, T1: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64) : u128 {
        let v0 = 0x2::dynamic_field::remove<u64, Slice<T1>>(&mut arg0.id, arg1);
        let v1 = 0x2::dynamic_field::remove<u64, Slice<T1>>(&mut arg0.id, arg3);
        assert!(v0.next == arg3, 8);
        assert!(v1.prev == arg1, 8);
        let v2 = slice_is_leaf<T1>(&v0);
        let Slice {
            prev : v3,
            next : v4,
            keys : v5,
            vals : v6,
            size : _,
        } = v0;
        let v8 = v6;
        let v9 = v5;
        let Slice {
            prev : v10,
            next : v11,
            keys : v12,
            vals : v13,
            size : _,
        } = v1;
        let v15 = v13;
        let v16 = 0x1::vector::length<T1>(&v8);
        let v17 = 0x1::vector::length<T1>(&v15);
        let v18 = v16 + v17;
        let v19 = v18 / 2;
        let v20 = v18 - v19;
        let v21 = if (v19 < v16) {
            true
        } else {
            assert!(v20 < v17, 9);
            false
        };
        let (v8, v22) = if (v21) {
            let v23 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<T1>(&mut v8, v19);
            0x1::vector::append<T1>(&mut v23, v15);
            (v8, v23)
        } else {
            0x1::vector::append<T1>(&mut v8, v15);
            (v8, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_n<T1>(&mut v15, v20))
        };
        let v24 = v22;
        let (v9, v25, v26) = if (v2 && v21) {
            let v27 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<u128>(&mut v9, v19);
            0x1::vector::append<u128>(&mut v27, v12);
            (v9, *0x1::vector::borrow<u128>(&v27, 0), v27)
        } else if (v2 && !v21) {
            let v28 = v12;
            let v29 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_n<u128>(&mut v28, v20);
            0x1::vector::append<u128>(&mut v9, v28);
            (v9, *0x1::vector::borrow<u128>(&v29, 0), v29)
        } else {
            let (v30, v9, v31) = if (!v2 && v21) {
                let v32 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_until<u128>(&mut v9, v19);
                0x1::vector::push_back<u128>(&mut v32, arg2);
                0x1::vector::append<u128>(&mut v32, v12);
                (v32, v9, 0x1::vector::pop_back<u128>(&mut v9))
            } else {
                0x1::vector::push_back<u128>(&mut v9, arg2);
                let v33 = v12;
                0x1::vector::append<u128>(&mut v9, v33);
                (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::utils::pop_n<u128>(&mut v33, v20 - 1), v9, 0x1::vector::pop_back<u128>(&mut v33))
            };
            (v9, v31, v30)
        };
        let v34 = Slice<T1>{
            prev : v3,
            next : v4,
            keys : v9,
            vals : v8,
            size : 0,
        };
        0x2::dynamic_field::add<u64, Slice<T1>>(&mut arg0.id, arg1, v34);
        let v35 = Slice<T1>{
            prev : v10,
            next : v11,
            keys : v26,
            vals : v24,
            size : 0,
        };
        0x2::dynamic_field::add<u64, Slice<T1>>(&mut arg0.id, arg3, v35);
        if (v2) {
            let v36 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg1);
            v36.size = 0x1::vector::length<T0>(&v36.vals);
            let v37 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg3);
            v37.size = 0x1::vector::length<T0>(&v37.vals);
        } else {
            let v38 = &arg0.id;
            let v39 = 0;
            let v40 = 0;
            let v41 = 0;
            let v42 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1);
            while (v39 < 0x1::vector::length<T1>(&v8)) {
                v40 = v40 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(v38, *0x1::vector::borrow<u64>(&v42.vals, v39)).size;
            };
            let v43 = 0;
            let v44 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg3);
            while (v43 < 0x1::vector::length<T1>(&v24)) {
                v41 = v41 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(v38, *0x1::vector::borrow<u64>(&v44.vals, v43)).size;
            };
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg3).size = v41;
            assert!(v41 > 0, 111);
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1).size = v40;
            assert!(v40 > 0, 111);
        };
        v25
    }

    fun slice_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u8, arg7: u128) : (T0, u8, u128) {
        if (arg6 == 0) {
            leaf_remove<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
        } else {
            node_remove<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6 - 1, arg7)
        }
    }

    fun try_redistribute_leaf<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: T0) : (T0, u8, u128) {
        let v0 = arg0.max_slice_size / 2;
        if (arg6 >= v0) {
            return (arg7, 0, 0)
        };
        if (arg1 != 0) {
            if (0x1::vector::length<T0>(&0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg1).vals) > v0) {
                return (arg7, 2, slice_redistribute<T0, T0>(arg0, arg1, arg5, arg2))
            };
        };
        if (arg3 != 0) {
            if (0x1::vector::length<T0>(&0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg3).vals) > v0) {
                return (arg7, 3, slice_redistribute<T0, T0>(arg0, arg2, arg4, arg3))
            };
        };
        if (arg1 != 0) {
            slice_merge<T0, T0>(arg0, arg1, arg5, arg2);
            return (arg7, 4, 0)
        };
        if (arg3 != 0) {
            slice_merge<T0, T0>(arg0, arg2, arg4, arg3);
            return (arg7, 5, 0)
        };
        let (v1, v2) = if (arg6 == 0) {
            (1, 0)
        } else {
            (0, 0)
        };
        (arg7, v1, v2)
    }

    fun try_redistribute_node<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: T0) : (T0, u8, u128) {
        let v0 = arg0.max_fan_out / 2;
        if (arg1 != 0) {
            if (0x1::vector::length<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1).vals) > v0) {
                return (arg7, 2, slice_redistribute<T0, u64>(arg0, arg1, arg5, arg2))
            };
        };
        if (arg3 != 0) {
            if (0x1::vector::length<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg3).vals) > v0) {
                return (arg7, 3, slice_redistribute<T0, u64>(arg0, arg2, arg4, arg3))
            };
        };
        if (arg1 != 0) {
            slice_merge<T0, u64>(arg0, arg1, arg5, arg2);
            return (arg7, 4, 0)
        };
        if (arg3 != 0) {
            slice_merge<T0, u64>(arg0, arg2, arg4, arg3);
            return (arg7, 5, 0)
        };
        if (arg6 == 0) {
            abort 7
        };
        let (v1, v2) = if (arg6 == 1) {
            (1, 0)
        } else {
            (0, 0)
        };
        (arg7, v1, v2)
    }

    fun update_size<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8) {
        let v0 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg2);
        let v1 = 0;
        if (arg4 == 2) {
            let v2 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u64>(&v0.vals)) {
                v1 = v1 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, *0x1::vector::borrow<u64>(&v0.vals, v3)).size;
                v3 = v3 + 1;
            };
            v3 = 0;
            let v4 = 0;
            while (v3 < 0x1::vector::length<u64>(&v2.vals)) {
                v4 = v4 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, *0x1::vector::borrow<u64>(&v2.vals, v3)).size;
                v3 = v3 + 1;
            };
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1).size = v4;
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg2).size = v1;
        } else if (arg4 == 3) {
            let v5 = 0;
            let v6 = 0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg3);
            while (v5 < 0x1::vector::length<u64>(&v0.vals)) {
                v1 = v1 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, *0x1::vector::borrow<u64>(&v0.vals, v5)).size;
                v5 = v5 + 1;
            };
            v5 = 0;
            let v7 = 0;
            while (v5 < 0x1::vector::length<u64>(&v6.vals)) {
                v7 = v7 + 0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, *0x1::vector::borrow<u64>(&v6.vals, v5)).size;
                v5 = v5 + 1;
            };
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg3).size = v7;
            0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg2).size = v1;
        };
    }

    // decompiled from Move bytecode v6
}

