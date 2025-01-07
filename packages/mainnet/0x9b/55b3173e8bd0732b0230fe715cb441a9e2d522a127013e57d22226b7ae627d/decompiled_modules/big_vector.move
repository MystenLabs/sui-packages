module 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::big_vector {
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
    }

    struct SliceRef has copy, drop, store {
        ix: u64,
    }

    public fun empty<T0: store>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
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

    public fun length<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.length
    }

    public fun borrow<T0: store>(arg0: &BigVector<T0>, arg1: u128) : &T0 {
        let (v0, v1) = slice_around<T0>(arg0, arg1);
        slice_borrow<T0>(borrow_slice<T0>(arg0, v0), v1)
    }

    public fun borrow_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u128) : &mut T0 {
        let (v0, v1) = slice_around<T0>(arg0, arg1);
        let v2 = borrow_slice_mut<T0>(arg0, v0);
        slice_borrow_mut<T0>(v2, v1)
    }

    public fun destroy_empty<T0: store>(arg0: BigVector<T0>) {
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

    public fun insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u128, arg2: T0) {
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
            let v5 = alloc<T0, u64>(arg0, branch(v3, v1, v4));
            arg0.root_id = v5;
            arg0.depth = arg0.depth + 1;
        };
    }

    public fun is_empty<T0: store>(arg0: &BigVector<T0>) : bool {
        arg0.length == 0
    }

    public fun remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u128) : T0 {
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
                } = 0x2::dynamic_field::remove<u64, Slice<T0>>(&mut arg0.id, v0);
                0x1::vector::destroy_empty<T0>(v8);
                arg0.root_id = 0;
            } else {
                let v9 = 0x2::dynamic_field::remove<u64, Slice<u64>>(&mut arg0.id, v0);
                arg0.root_id = 0x1::vector::pop_back<u64>(&mut v9.vals);
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

    public fun borrow_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef) : &Slice<T0> {
        0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg1.ix)
    }

    public fun borrow_slice_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: SliceRef) : &mut Slice<T0> {
        0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg1.ix)
    }

    fun branch(arg0: u128, arg1: u64, arg2: u64) : Slice<u64> {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg1);
        0x1::vector::push_back<u64>(v2, arg2);
        Slice<u64>{
            prev : 0,
            next : 0,
            keys : v0,
            vals : v1,
        }
    }

    public fun depth<T0: store>(arg0: &BigVector<T0>) : u8 {
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

    fun leaf_insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: T0) : (u128, u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(&mut arg0.id, arg1);
        let v1 = slice_bisect_left<T0>(v0, arg2);
        if (v1 < 0x1::vector::length<u128>(&v0.keys) && arg2 == *0x1::vector::borrow<u128>(&v0.keys, v1)) {
            abort 6
        };
        if (0x1::vector::length<u128>(&v0.keys) < arg0.max_slice_size) {
            0x1::vector::insert<u128>(&mut v0.keys, arg2, v1);
            0x1::vector::insert<T0>(&mut v0.vals, arg3, v1);
            return (0, 0)
        };
        let v2 = 0x1::vector::length<T0>(&v0.vals) / 2;
        let v3 = Slice<T0>{
            prev : arg1,
            next : v0.next,
            keys : 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<u128>(&mut v0.keys, v2),
            vals : 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<T0>(&mut v0.vals, v2),
        };
        let v4 = *0x1::vector::borrow<u128>(&v3.keys, 0);
        if (arg2 < v4) {
            0x1::vector::insert<u128>(&mut v0.keys, arg2, v1);
            0x1::vector::insert<T0>(&mut v0.vals, arg3, v1);
        } else {
            0x1::vector::insert<u128>(&mut v3.keys, arg2, v1 - v2);
            0x1::vector::insert<T0>(&mut v3.vals, arg3, v1 - v2);
        };
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
        let v2 = 0x1::vector::remove<T0>(&mut v0.vals, v1);
        let v3 = 0x1::vector::length<T0>(&v0.vals);
        let v4 = arg0.max_slice_size / 2;
        if (v3 >= v4) {
            return (v2, 0, 0)
        };
        if (arg1 != 0) {
            if (0x1::vector::length<T0>(&0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg1).vals) > v4) {
                return (v2, 2, slice_redistribute<T0, T0>(arg0, arg1, arg2, arg3))
            };
        };
        if (arg5 != 0) {
            if (0x1::vector::length<T0>(&0x2::dynamic_field::borrow<u64, Slice<T0>>(&arg0.id, arg5).vals) > v4) {
                return (v2, 3, slice_redistribute<T0, T0>(arg0, arg3, arg4, arg5))
            };
        };
        if (arg1 != 0) {
            slice_merge<T0, T0>(arg0, arg1, arg2, arg3);
            return (v2, 4, 0)
        };
        if (arg5 != 0) {
            slice_merge<T0, T0>(arg0, arg3, arg4, arg5);
            return (v2, 5, 0)
        };
        let (v5, v6) = if (v3 == 0) {
            (1, 0)
        } else {
            (0, 0)
        };
        (v2, v5, v6)
    }

    public fun max_slice<T0: store>(arg0: &BigVector<T0>) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, _, v3) = find_max_leaf<T0>(arg0);
        let v4 = SliceRef{ix: v1};
        (v4, v3)
    }

    public fun min_slice<T0: store>(arg0: &BigVector<T0>) : (SliceRef, u64) {
        if (arg0.root_id == 0) {
            let v0 = SliceRef{ix: 0};
            return (v0, 0)
        };
        let (v1, _, v3) = find_min_leaf<T0>(arg0);
        let v4 = SliceRef{ix: v1};
        (v4, v3)
    }

    public fun next_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef, arg2: u64) : (SliceRef, u64) {
        let v0 = borrow_slice<T0>(arg0, arg1);
        if (arg2 + 1 < 0x1::vector::length<T0>(&v0.vals)) {
            (arg1, arg2 + 1)
        } else {
            (slice_next<T0>(v0), 0)
        }
    }

    fun node_insert<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u8, arg3: u128, arg4: T0) : (u128, u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1);
        let v1 = slice_bisect_right<u64>(v0, arg3);
        let (v2, v3) = slice_insert<T0>(arg0, *0x1::vector::borrow<u64>(&v0.vals, v1), arg2, arg3, arg4);
        if (v3 == 0) {
            return (0, 0)
        };
        let v4 = 0x2::dynamic_field::borrow_mut<u64, Slice<u64>>(&mut arg0.id, arg1);
        if (0x1::vector::length<u64>(&v4.vals) < arg0.max_fan_out) {
            0x1::vector::insert<u128>(&mut v4.keys, v2, v1);
            0x1::vector::insert<u64>(&mut v4.vals, v3, v1 + 1);
            return (0, 0)
        };
        let v5 = 0x1::vector::length<u64>(&v4.vals) / 2;
        let v6 = Slice<u64>{
            prev : arg1,
            next : v4.next,
            keys : 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<u128>(&mut v4.keys, v5),
            vals : 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<u64>(&mut v4.vals, v5),
        };
        let v7 = 0x1::vector::pop_back<u128>(&mut v4.keys);
        if (v2 < v7) {
            0x1::vector::insert<u128>(&mut v4.keys, v2, v1);
            0x1::vector::insert<u64>(&mut v4.vals, v3, v1 + 1);
        } else {
            0x1::vector::insert<u128>(&mut v6.keys, v2, v1 - v5);
            0x1::vector::insert<u64>(&mut v6.vals, v3, v1 - v5 + 1);
        };
        (v7, alloc<T0, u64>(arg0, v6))
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
        let v11 = arg0.max_fan_out / 2;
        if (v10 >= v11) {
            return (v6, 0, 0)
        };
        if (arg1 != 0) {
            if (0x1::vector::length<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg1).vals) > v11) {
                return (v6, 2, slice_redistribute<T0, u64>(arg0, arg1, arg2, arg3))
            };
        };
        if (arg5 != 0) {
            if (0x1::vector::length<u64>(&0x2::dynamic_field::borrow<u64, Slice<u64>>(&arg0.id, arg5).vals) > v11) {
                return (v6, 3, slice_redistribute<T0, u64>(arg0, arg3, arg4, arg5))
            };
        };
        if (arg1 != 0) {
            slice_merge<T0, u64>(arg0, arg1, arg2, arg3);
            return (v6, 4, 0)
        };
        if (arg5 != 0) {
            slice_merge<T0, u64>(arg0, arg3, arg4, arg5);
            return (v6, 5, 0)
        };
        if (v10 == 0) {
            abort 7
        };
        let (v12, v13) = if (v10 == 1) {
            (1, 0)
        } else {
            (0, 0)
        };
        (v6, v12, v13)
    }

    public fun prev_slice<T0: store>(arg0: &BigVector<T0>, arg1: SliceRef, arg2: u64) : (SliceRef, u64) {
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
        }
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

    fun slice_bisect_right<T0: store>(arg0: &Slice<T0>, arg1: u128) : u64 {
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

    public fun slice_borrow_mut<T0: store>(arg0: &mut Slice<T0>, arg1: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(&mut arg0.vals, arg1)
    }

    public fun slice_following<T0: store>(arg0: &BigVector<T0>, arg1: u128) : (SliceRef, u64) {
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

    public fun slice_is_null(arg0: &SliceRef) : bool {
        arg0.ix == 0
    }

    public fun slice_key<T0: store>(arg0: &Slice<T0>, arg1: u64) : u128 {
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
        } = v0;
        0x1::vector::append<u128>(&mut v1.keys, v4);
        0x1::vector::append<T1>(&mut v1.vals, v5);
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
        } = v0;
        let v7 = v6;
        let v8 = v5;
        let Slice {
            prev : v9,
            next : v10,
            keys : v11,
            vals : v12,
        } = v1;
        let v13 = v12;
        let v14 = 0x1::vector::length<T1>(&v7);
        let v15 = 0x1::vector::length<T1>(&v13);
        let v16 = v14 + v15;
        let v17 = v16 / 2;
        let v18 = v16 - v17;
        let v19 = if (v17 < v14) {
            true
        } else {
            assert!(v18 < v15, 9);
            false
        };
        let (v7, v20) = if (v19) {
            let v21 = 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<T1>(&mut v7, v17);
            0x1::vector::append<T1>(&mut v21, v13);
            (v7, v21)
        } else {
            0x1::vector::append<T1>(&mut v7, v13);
            (v7, 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_n<T1>(&mut v13, v18))
        };
        let (v8, v22, v23) = if (v2 && v19) {
            let v24 = 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<u128>(&mut v8, v17);
            0x1::vector::append<u128>(&mut v24, v11);
            (v8, *0x1::vector::borrow<u128>(&v24, 0), v24)
        } else {
            let (v25, v26, v8) = if (v2 && !v19) {
                let v27 = v11;
                let v28 = 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_n<u128>(&mut v27, v18);
                0x1::vector::append<u128>(&mut v8, v27);
                (*0x1::vector::borrow<u128>(&v28, 0), v28, v8)
            } else {
                let (v8, v29, v30) = if (!v2 && v19) {
                    let v31 = 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_until<u128>(&mut v8, v17);
                    0x1::vector::push_back<u128>(&mut v31, arg2);
                    0x1::vector::append<u128>(&mut v31, v11);
                    (v8, 0x1::vector::pop_back<u128>(&mut v8), v31)
                } else {
                    0x1::vector::push_back<u128>(&mut v8, arg2);
                    let v32 = v11;
                    0x1::vector::append<u128>(&mut v8, v32);
                    (v8, 0x1::vector::pop_back<u128>(&mut v32), 0x9b55b3173e8bd0732b0230fe715cb441a9e2d522a127013e57d22226b7ae627d::utils::pop_n<u128>(&mut v32, v18 - 1))
                };
                (v29, v30, v8)
            };
            (v8, v25, v26)
        };
        let v33 = Slice<T1>{
            prev : v3,
            next : v4,
            keys : v8,
            vals : v7,
        };
        0x2::dynamic_field::add<u64, Slice<T1>>(&mut arg0.id, arg1, v33);
        let v34 = Slice<T1>{
            prev : v9,
            next : v10,
            keys : v23,
            vals : v20,
        };
        0x2::dynamic_field::add<u64, Slice<T1>>(&mut arg0.id, arg3, v34);
        v22
    }

    fun slice_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u8, arg7: u128) : (T0, u8, u128) {
        if (arg6 == 0) {
            leaf_remove<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
        } else {
            node_remove<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6 - 1, arg7)
        }
    }

    // decompiled from Move bytecode v6
}

