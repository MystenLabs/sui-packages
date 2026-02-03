module 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::ordered_map {
    struct Map<phantom T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        size: u64,
        counter: u64,
        root: u64,
        first: u64,
        branch_min: u64,
        branches_merge_max: u64,
        branch_max: u64,
        leaf_min: u64,
        leaves_merge_max: u64,
        leaf_max: u64,
    }

    struct Branch has drop, store {
        keys: vector<u128>,
        kids: vector<u64>,
    }

    struct Pair<T0: copy + drop + store> has copy, drop, store {
        key: u128,
        val: T0,
    }

    struct Leaf<T0: copy + drop + store> has drop, store {
        keys_vals: vector<Pair<T0>>,
        next: u64,
    }

    public(friend) fun empty<T0: copy + drop + store>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Map<T0> {
        check_map_params(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = 0;
        let v1 = &mut v0;
        let v2 = 9223372036854775808 | increase_counter(v1);
        let v3 = Map<T0>{
            id                 : 0x2::object::new(arg6),
            size               : 0,
            counter            : v0,
            root               : v2,
            first              : v2,
            branch_min         : arg0,
            branches_merge_max : arg1,
            branch_max         : arg2,
            leaf_min           : arg3,
            leaves_merge_max   : arg4,
            leaf_max           : arg5,
        };
        let v4 = Leaf<T0>{
            keys_vals : 0x1::vector::empty<Pair<T0>>(),
            next      : 0,
        };
        0x2::dynamic_field::add<u64, Leaf<T0>>(&mut v3.id, v2, v4);
        v3
    }

    public(friend) fun borrow<T0: copy + drop + store>(arg0: &Map<T0>, arg1: u128) : &T0 {
        let v0 = &0x2::dynamic_field::borrow<u64, Leaf<T0>>(&arg0.id, find_leaf<T0>(arg0, arg1)).keys_vals;
        let v1 = 0x1::vector::borrow<Pair<T0>>(v0, binary_search_p<T0>(v0, 0x1::vector::length<Pair<T0>>(v0), arg1));
        assert!(arg1 == v1.key, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::key_not_exist());
        &v1.val
    }

    public(friend) fun borrow_mut<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u128) : &mut T0 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, find_leaf<T0>(arg0, arg1));
        let v1 = &v0.keys_vals;
        let v2 = 0x1::vector::borrow_mut<Pair<T0>>(&mut v0.keys_vals, binary_search_p<T0>(v1, 0x1::vector::length<Pair<T0>>(v1), arg1));
        assert!(arg1 == v2.key, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::key_not_exist());
        &mut v2.val
    }

    public(friend) fun destroy_empty<T0: copy + drop + store>(arg0: Map<T0>) {
        assert!(is_empty<T0>(&arg0), 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::destroy_not_empty());
        let Map {
            id                 : v0,
            size               : _,
            counter            : _,
            root               : _,
            first              : _,
            branch_min         : _,
            branches_merge_max : _,
            branch_max         : _,
            leaf_min           : _,
            leaves_merge_max   : _,
            leaf_max           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun insert<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u128, arg2: T0) {
        let v0 = vector[];
        let v1 = arg0.root;
        while (9223372036854775808 & v1 == 0) {
            let v2 = 0x2::dynamic_field::borrow<u64, Branch>(&arg0.id, v1);
            let v3 = &v2.keys;
            let v4 = binary_search(v3, 0x1::vector::length<u128>(v3), arg1);
            0x1::vector::push_back<u64>(&mut v0, v1);
            0x1::vector::push_back<u64>(&mut v0, v4);
            v1 = *0x1::vector::borrow<u64>(&v2.kids, v4);
        };
        let v5 = arg0.counter;
        let v6 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, v1);
        let v7 = insert_into_leaf<T0>(v6, arg1, arg2);
        arg0.size = arg0.size + 1;
        if (v7 > arg0.leaf_max) {
            let v8 = &mut v5;
            let (v9, v10, v11) = split_leaf<T0>(v6, v8, v7);
            let v12 = v10;
            let v13 = v9;
            0x2::dynamic_field::add<u64, Leaf<T0>>(&mut arg0.id, v9, v11);
            let v14 = 0x1::vector::length<u64>(&v0);
            while (v13 != 0) {
                if (v14 > 0) {
                    v14 = v14 - 2;
                    let v15 = 0x1::vector::pop_back<u64>(&mut v0);
                    let v16 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, 0x1::vector::pop_back<u64>(&mut v0));
                    0x1::vector::insert<u128>(&mut v16.keys, v12, v15);
                    0x1::vector::insert<u64>(&mut v16.kids, v13, v15 + 1);
                    let v17 = 0x1::vector::length<u64>(&v16.kids);
                    if (v17 > arg0.branch_max) {
                        let v18 = &mut v5;
                        let (v19, v20, v21) = split_branch(v16, v18, v17);
                        v12 = v20;
                        v13 = v19;
                        0x2::dynamic_field::add<u64, Branch>(&mut arg0.id, v19, v21);
                        continue
                    } else {
                        break
                    };
                };
                let v22 = 0x1::vector::empty<u128>();
                0x1::vector::push_back<u128>(&mut v22, v12);
                let v23 = 0x1::vector::empty<u64>();
                let v24 = &mut v23;
                0x1::vector::push_back<u64>(v24, arg0.root);
                0x1::vector::push_back<u64>(v24, v13);
                let v25 = Branch{
                    keys : v22,
                    kids : v23,
                };
                let v26 = &mut v5;
                arg0.root = increase_counter(v26);
                0x2::dynamic_field::add<u64, Branch>(&mut arg0.id, arg0.root, v25);
                v13 = 0;
            };
            arg0.counter = v5;
        };
    }

    public(friend) fun remove<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u128) : T0 {
        let v0 = arg0.root;
        if (9223372036854775808 & v0 == 0) {
            let (v1, v2) = remove_from_branch<T0>(arg0, v0, arg1);
            if (v2 == 1) {
                let v3 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, v0);
                arg0.root = 0x1::vector::pop_back<u64>(&mut v3.kids);
            };
            return v1
        };
        let (v4, _) = remove_from_leaf<T0>(arg0, v0, arg1);
        v4
    }

    fun append_left<T0: copy + drop + store>(arg0: vector<T0>, arg1: &mut vector<T0>) {
        reverse<T0>(arg1);
        append_reversed_right<T0>(arg1, arg0);
        reverse<T0>(arg1);
    }

    fun append_reversed_right<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: vector<T0>) {
        while (0x1::vector::length<T0>(&arg1) > 0) {
            0x1::vector::push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    fun append_right<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: &vector<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(arg1)) {
            0x1::vector::push_back<T0>(arg0, *0x1::vector::borrow<T0>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun batch_drop<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u128, arg2: bool) {
        if (!arg2) {
            if (arg1 == 0) {
                return
            };
            arg1 = arg1 - 1;
        };
        batch_drop_from_root<T0>(arg0, arg1);
    }

    fun batch_drop_from_branch<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u128) : u128 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        let v1 = &v0.keys;
        let v2 = 0x1::vector::length<u128>(v1);
        let v3 = binary_search(v1, v2, arg4);
        let v4 = v3 < v2 && *0x1::vector::borrow<u128>(v1, v3) == arg4;
        let v5 = if (v4) {
            v3 + 1
        } else {
            v3
        };
        let v6 = &mut v0.kids;
        let v7 = *0x1::vector::borrow_mut<u64>(v6, v3);
        let v8 = 9223372036854775808 & v7 == 0;
        let v9 = &mut v0.keys;
        drop_left<u128>(v9, v5);
        let v10 = if (v8) {
            cut_reversed_left<u64>(v6, v5)
        } else {
            drop_left<u64>(v6, v5);
            vector[]
        };
        let v11 = v2 - v5 + 1;
        if (v4) {
            if (v11 < arg0.branch_min) {
                arg2 = migrate_to_left_branch<T0>(arg0, arg1, v11, arg2, arg3);
            };
            drop_kids<T0>(arg0, v5, v8, v10);
            return arg2
        };
        let (v12, v13) = if (v11 <= arg0.branch_min) {
            let (v14, v15, v16) = migrate_to_left_branch1<T0>(arg0, arg1, v11, arg2, arg3);
            arg2 = v14;
            (v16, v15)
        } else {
            (*0x1::vector::borrow_mut<u64>(v6, 1), *0x1::vector::borrow_mut<u128>(&mut v0.keys, 0))
        };
        drop_kids<T0>(arg0, v5, v8, v10);
        if (v8) {
            let v17 = batch_drop_from_branch<T0>(arg0, v7, v13, v12, arg4);
            if (v17 != v13) {
                let v18 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
                if (v17 == 0) {
                    let v19 = &mut v18.keys;
                    drop_first<u128>(v19);
                    let v20 = &mut v18.kids;
                    drop_second<u64>(v20);
                    return arg2
                };
                *0x1::vector::borrow_mut<u128>(&mut v18.keys, 0) = v17;
                return arg2
            };
            return arg2
        };
        let v21 = batch_drop_from_leaf<T0>(arg0, v7, arg4);
        if (v21 < arg0.leaf_min) {
            let v22 = migrate_to_left_leaf<T0>(arg0, v7, v21, v12);
            let v23 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
            if (v22 == 0) {
                let v24 = &mut v23.keys;
                drop_first<u128>(v24);
                let v25 = &mut v23.kids;
                drop_second<u64>(v25);
                return arg2
            };
            *0x1::vector::borrow_mut<u128>(&mut v23.keys, 0) = v22;
            return arg2
        };
        arg2
    }

    fun batch_drop_from_leaf<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        let v1 = &v0.keys_vals;
        let v2 = 0x1::vector::length<Pair<T0>>(v1);
        let v3 = binary_search_rightmost<T0>(v1, v2, arg2);
        let v4 = &mut v0.keys_vals;
        drop_left<Pair<T0>>(v4, v3);
        arg0.size = arg0.size - v3;
        v2 - v3
    }

    fun batch_drop_from_root<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u128) {
        let v0 = arg0.root;
        loop {
            if (9223372036854775808 & v0 != 0) {
                break
            };
            let v1 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, v0);
            let v2 = &v1.keys;
            let v3 = 0x1::vector::length<u128>(v2);
            let v4 = binary_search(v2, v3, arg1);
            let v5 = v4 < v3 && *0x1::vector::borrow<u128>(v2, v4) == arg1;
            let v6 = if (v5) {
                v4 + 1
            } else {
                v4
            };
            let v7 = &mut v1.kids;
            let v8 = *0x1::vector::borrow_mut<u64>(v7, v4);
            let v9 = 9223372036854775808 & v8 == 0;
            let v10 = &mut v1.keys;
            drop_left<u128>(v10, v6);
            let v11 = if (v9) {
                cut_reversed_left<u64>(v7, v6)
            } else {
                drop_left<u64>(v7, v6);
                vector[]
            };
            let v12 = v3 - v6;
            if (v12 == 0) {
                drop_kids<T0>(arg0, v6, v9, v11);
                let v13 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, v0);
                let v14 = 0x1::vector::pop_back<u64>(&mut v13.kids);
                v0 = v14;
                arg0.root = v14;
                if (v5) {
                    return
                } else {
                    continue
                };
            };
            if (v5) {
                drop_kids<T0>(arg0, v6, v9, v11);
                return
            };
            let v15 = *0x1::vector::borrow_mut<u128>(&mut v1.keys, 0);
            drop_kids<T0>(arg0, v6, v9, v11);
            if (v9) {
                let v16 = batch_drop_from_branch<T0>(arg0, v8, v15, *0x1::vector::borrow_mut<u64>(v7, 1), arg1);
                if (v16 != v15) {
                    let v17 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, v0);
                    if (v16 == 0) {
                        let v18 = &mut v17.keys;
                        drop_first<u128>(v18);
                        let v19 = &mut v17.kids;
                        drop_second<u64>(v19);
                        if (v12 == 1) {
                            let v20 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, v0);
                            arg0.root = 0x1::vector::pop_back<u64>(&mut v20.kids);
                            return
                        };
                        return
                    };
                    *0x1::vector::borrow_mut<u128>(&mut v17.keys, 0) = v16;
                    return
                };
                return
            };
            let v21 = batch_drop_from_leaf<T0>(arg0, v8, arg1);
            if (v21 < arg0.leaf_min) {
                let v22 = migrate_to_left_leaf<T0>(arg0, v8, v21, *0x1::vector::borrow_mut<u64>(v7, 1));
                let v23 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, v0);
                if (v22 == 0) {
                    let v24 = &mut v23.keys;
                    drop_first<u128>(v24);
                    let v25 = &mut v23.kids;
                    drop_second<u64>(v25);
                    if (v12 == 1) {
                        let v26 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, v0);
                        arg0.root = 0x1::vector::pop_back<u64>(&mut v26.kids);
                        return
                    };
                    return
                };
                *0x1::vector::borrow_mut<u128>(&mut v23.keys, 0) = v22;
                return
            };
            return
        };
        batch_drop_from_leaf<T0>(arg0, v0, arg1);
    }

    fun binary_search(arg0: &vector<u128>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0;
        while (v0 < arg1) {
            arg1 = v0 + arg1 >> 1;
            if (*0x1::vector::borrow<u128>(arg0, arg1) < arg2) {
                v0 = arg1 + 1;
                continue
            };
        };
        v0
    }

    fun binary_search_p<T0: copy + drop + store>(arg0: &vector<Pair<T0>>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0;
        while (v0 < arg1) {
            arg1 = v0 + arg1 >> 1;
            if (0x1::vector::borrow<Pair<T0>>(arg0, arg1).key < arg2) {
                v0 = arg1 + 1;
                continue
            };
        };
        v0
    }

    fun binary_search_rightmost<T0: copy + drop + store>(arg0: &vector<Pair<T0>>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = v0 + arg1 >> 1;
            if (0x1::vector::borrow<Pair<T0>>(arg0, v1).key > arg2) {
                arg1 = v1;
                continue
            };
            v0 = v1 + 1;
        };
        arg1
    }

    public(friend) fun change_params<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        check_map_params(arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(arg0.size > 3, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::map_too_small());
        assert!(arg1 <= arg0.branch_min && arg0.branch_max <= arg3, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
        assert!(arg4 <= arg0.leaf_min && arg0.leaf_max <= arg6, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
        arg0.branch_min = arg1;
        arg0.branches_merge_max = arg2;
        arg0.branch_max = arg3;
        arg0.leaf_min = arg4;
        arg0.leaves_merge_max = arg5;
        arg0.leaf_max = arg6;
    }

    fun check_map_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(2 <= arg0 && arg0 <= arg2 / 2, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
        assert!(2 * arg0 <= arg1 && arg1 <= arg2, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
        assert!(2 <= arg3 && arg3 <= (arg5 + 1) / 2, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
        assert!(2 * arg3 - 1 <= arg4 && arg4 <= arg5, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::invalid_map_parameters());
    }

    public(friend) fun clear<T0: copy + drop + store>(arg0: &mut Map<T0>) {
        let v0 = arg0.root;
        let v1 = v0;
        if (9223372036854775808 & v0 == 0) {
            let v2;
            let v3;
            loop {
                let v4 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, v1);
                let v5 = &v4.kids;
                v2 = 0x1::vector::length<u64>(v5) - 1;
                v3 = *0x1::vector::borrow<u64>(v5, v2);
                v1 = v3;
                if (9223372036854775808 & v3 == 0) {
                    let v6 = 0;
                    while (v6 < v2) {
                        drop_branch<T0>(arg0, *0x1::vector::borrow<u64>(v5, v6));
                        v6 = v6 + 1;
                    };
                } else {
                    break
                };
            };
            drop_first_leaves<T0>(arg0, v2);
            arg0.root = v3;
        };
        clear_leaf<T0>(arg0, v1);
    }

    fun clear_leaf<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        v0.keys_vals = 0x1::vector::empty<Pair<T0>>();
        arg0.size = arg0.size - 0x1::vector::length<Pair<T0>>(&v0.keys_vals);
    }

    fun copy_slice<T0: copy + drop + store>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun cut_reversed_left<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = arg1;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow_mut<T0>(arg0, v1));
        };
        drop_left<T0>(arg0, arg1);
        v0
    }

    fun cut_reversed_left1<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) : (T0, vector<T0>) {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = arg1 - 1;
        let v2 = v1;
        let v3 = *0x1::vector::borrow_mut<T0>(arg0, v1);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow_mut<T0>(arg0, v2));
        };
        drop_left<T0>(arg0, arg1);
        (v3, v0)
    }

    fun cut_reversed_right<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 > 0) {
            0x1::vector::push_back<T0>(&mut v0, 0x1::vector::pop_back<T0>(arg0));
            arg1 = arg1 - 1;
        };
        v0
    }

    fun cut_right<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = cut_reversed_right<T0>(arg0, arg1);
        let v1 = &mut v0;
        reverse<T0>(v1);
        v0
    }

    fun drop_branch<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64) {
        let v0 = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, arg1);
        let v1 = &v0.kids;
        let v2 = *0x1::vector::borrow<u64>(v1, 0);
        if (9223372036854775808 & v2 == 0) {
            drop_branch<T0>(arg0, v2);
            let v3 = 1;
            while (v3 < 0x1::vector::length<u64>(v1)) {
                drop_branch<T0>(arg0, *0x1::vector::borrow<u64>(v1, v3));
                v3 = v3 + 1;
            };
            return
        };
        drop_first_leaves<T0>(arg0, 0x1::vector::length<u64>(v1));
    }

    fun drop_first<T0: copy + drop + store>(arg0: &mut vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        while (v0 > 1) {
            v0 = v0 - 1;
            0x1::vector::swap<T0>(arg0, 0, v0);
        };
        0x1::vector::pop_back<T0>(arg0);
    }

    fun drop_first_leaves<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64) {
        let v0 = 0;
        let v1 = arg0.first;
        while (arg1 > 0) {
            let v2 = 0x2::dynamic_field::remove<u64, Leaf<T0>>(&mut arg0.id, v1);
            v0 = v0 + 0x1::vector::length<Pair<T0>>(&v2.keys_vals);
            v1 = v2.next;
            arg1 = arg1 - 1;
        };
        arg0.size = arg0.size - v0;
        arg0.first = v1;
    }

    fun drop_kids<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: bool, arg3: vector<u64>) {
        if (arg1 == 0) {
            return
        };
        if (arg2) {
            while (arg1 > 0) {
                arg1 = arg1 - 1;
                drop_branch<T0>(arg0, 0x1::vector::pop_back<u64>(&mut arg3));
            };
        } else {
            drop_first_leaves<T0>(arg0, arg1);
        };
    }

    fun drop_left<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) {
        let v0 = 0x1::vector::length<T0>(arg0);
        if (2 * arg1 > v0) {
            *arg0 = copy_slice<T0>(arg0, arg1, v0);
            return
        };
        while (arg1 < v0) {
            0x1::vector::swap<T0>(arg0, arg1 - arg1, arg1);
            arg1 = arg1 + 1;
        };
        drop_right<T0>(arg0, arg1);
    }

    fun drop_right<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) {
        while (arg1 > 0) {
            0x1::vector::pop_back<T0>(arg0);
            arg1 = arg1 - 1;
        };
    }

    fun drop_second<T0: copy + drop + store>(arg0: &mut vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        while (v0 != 2) {
            v0 = v0 - 1;
            0x1::vector::swap<T0>(arg0, 1, v0);
        };
        0x1::vector::pop_back<T0>(arg0);
    }

    public(friend) fun find_leaf<T0: copy + drop + store>(arg0: &Map<T0>, arg1: u128) : u64 {
        let v0 = arg0.root;
        while (9223372036854775808 & v0 == 0) {
            let v1 = 0x2::dynamic_field::borrow<u64, Branch>(&arg0.id, v0);
            let v2 = &v1.keys;
            v0 = *0x1::vector::borrow<u64>(&v1.kids, binary_search(v2, 0x1::vector::length<u128>(v2), arg1));
        };
        v0
    }

    public(friend) fun first_leaf_ptr<T0: copy + drop + store>(arg0: &Map<T0>) : u64 {
        arg0.first
    }

    public(friend) fun get_leaf<T0: copy + drop + store>(arg0: &Map<T0>, arg1: u64) : &Leaf<T0> {
        0x2::dynamic_field::borrow<u64, Leaf<T0>>(&arg0.id, arg1)
    }

    public(friend) fun get_leaf_mut<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64) : &mut Leaf<T0> {
        0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1)
    }

    public(friend) fun has_key<T0: copy + drop + store>(arg0: &Map<T0>, arg1: u128) : bool {
        let v0 = &0x2::dynamic_field::borrow<u64, Leaf<T0>>(&arg0.id, find_leaf<T0>(arg0, arg1)).keys_vals;
        let v1 = 0x1::vector::length<Pair<T0>>(v0);
        let v2 = binary_search_p<T0>(v0, v1, arg1);
        v2 < v1 && arg1 == 0x1::vector::borrow<Pair<T0>>(v0, v2).key
    }

    fun increase_counter(arg0: &mut u64) : u64 {
        *arg0 = *arg0 + 1;
        *arg0
    }

    fun insert_into_leaf<T0: copy + drop + store>(arg0: &mut Leaf<T0>, arg1: u128, arg2: T0) : u64 {
        let v0 = &arg0.keys_vals;
        let v1 = 0x1::vector::length<Pair<T0>>(v0);
        let v2 = binary_search_p<T0>(v0, v1, arg1);
        assert!(v2 == v1 || arg1 != 0x1::vector::borrow<Pair<T0>>(v0, v2).key, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::key_already_exists());
        let v3 = Pair<T0>{
            key : arg1,
            val : arg2,
        };
        0x1::vector::insert<Pair<T0>>(&mut arg0.keys_vals, v3, v2);
        v1 + 1
    }

    public(friend) fun is_empty<T0: copy + drop + store>(arg0: &Map<T0>) : bool {
        arg0.size == 0
    }

    fun last<T0: copy + drop + store>(arg0: &vector<T0>) : &T0 {
        0x1::vector::borrow<T0>(arg0, 0x1::vector::length<T0>(arg0) - 1)
    }

    public(friend) fun leaf_elem<T0: copy + drop + store>(arg0: &Leaf<T0>, arg1: u64) : (u128, &T0) {
        let v0 = 0x1::vector::borrow<Pair<T0>>(&arg0.keys_vals, arg1);
        (v0.key, &v0.val)
    }

    public(friend) fun leaf_elem_mut<T0: copy + drop + store>(arg0: &mut Leaf<T0>, arg1: u64) : (u128, &mut T0) {
        let v0 = 0x1::vector::borrow_mut<Pair<T0>>(&mut arg0.keys_vals, arg1);
        (v0.key, &mut v0.val)
    }

    public(friend) fun leaf_find_index<T0: copy + drop + store>(arg0: &Leaf<T0>, arg1: u128) : u64 {
        let v0 = &arg0.keys_vals;
        binary_search_p<T0>(v0, 0x1::vector::length<Pair<T0>>(v0), arg1)
    }

    public(friend) fun leaf_next<T0: copy + drop + store>(arg0: &Leaf<T0>) : u64 {
        arg0.next
    }

    public(friend) fun leaf_size<T0: copy + drop + store>(arg0: &Leaf<T0>) : u64 {
        0x1::vector::length<Pair<T0>>(&arg0.keys_vals)
    }

    fun merge_branches<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128, arg3: u64) {
        let Branch {
            keys : v0,
            kids : v1,
        } = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        0x1::vector::push_back<u128>(&mut v4.keys, arg2);
        let v5 = &mut v4.keys;
        append_right<u128>(v5, &v3);
        let v6 = &mut v4.kids;
        append_right<u64>(v6, &v2);
    }

    fun merge_leaves<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64) {
        let Leaf {
            keys_vals : v0,
            next      : v1,
        } = 0x2::dynamic_field::remove<u64, Leaf<T0>>(&mut arg0.id, arg2);
        let v2 = v0;
        let v3 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        let v4 = &mut v3.keys_vals;
        append_right<Pair<T0>>(v4, &v2);
        v3.next = v1;
    }

    fun migrate_to_left_branch<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : u128 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg4);
        let v1 = arg2 + 0x1::vector::length<u64>(&v0.kids);
        if (v1 <= arg0.branches_merge_max) {
            merge_branches<T0>(arg0, arg1, arg3, arg4);
            return 0
        };
        let v2 = (v1 + 1) / 2 - arg2;
        let v3 = &mut v0.keys;
        let (v4, v5) = cut_reversed_left1<u128>(v3, v2);
        let v6 = &mut v0.kids;
        let v7 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        0x1::vector::push_back<u128>(&mut v7.keys, arg3);
        let v8 = &mut v7.keys;
        append_reversed_right<u128>(v8, v5);
        let v9 = &mut v7.kids;
        append_reversed_right<u64>(v9, cut_reversed_left<u64>(v6, v2));
        v4
    }

    fun migrate_to_left_branch1<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : (u128, u128, u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg4);
        let v1 = arg2 + 0x1::vector::length<u64>(&v0.kids);
        if (v1 <= arg0.branches_merge_max) {
            let Branch {
                keys : v2,
                kids : v3,
            } = 0x2::dynamic_field::remove<u64, Branch>(&mut arg0.id, arg4);
            let v4 = v3;
            let v5 = v2;
            let v6 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
            let v7 = &mut v6.keys;
            let v8 = &mut v6.kids;
            0x1::vector::push_back<u128>(v7, arg3);
            append_right<u128>(v7, &v5);
            append_right<u64>(v8, &v4);
            return (0, *0x1::vector::borrow_mut<u128>(v7, 0), *0x1::vector::borrow_mut<u64>(v8, 1))
        };
        let v9 = (v1 + 1) / 2 - arg2;
        let v10 = &mut v0.keys;
        let (v11, v12) = cut_reversed_left1<u128>(v10, v9);
        let v13 = &mut v0.kids;
        let v14 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        let v15 = &mut v14.keys;
        let v16 = &mut v14.kids;
        0x1::vector::push_back<u128>(v15, arg3);
        append_reversed_right<u128>(v15, v12);
        append_reversed_right<u64>(v16, cut_reversed_left<u64>(v13, v9));
        (v11, *0x1::vector::borrow_mut<u128>(v15, 0), *0x1::vector::borrow_mut<u64>(v16, 1))
    }

    fun migrate_to_left_leaf<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg3);
        let v1 = arg2 + 0x1::vector::length<Pair<T0>>(&v0.keys_vals);
        if (v1 <= arg0.leaves_merge_max) {
            merge_leaves<T0>(arg0, arg1, arg3);
            return 0
        };
        let v2 = &mut v0.keys_vals;
        let v3 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        let v4 = &mut v3.keys_vals;
        append_reversed_right<Pair<T0>>(v4, cut_reversed_left<Pair<T0>>(v2, v1 / 2 - arg2));
        last<Pair<T0>>(&v3.keys_vals).key
    }

    fun migrate_to_right_branch<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        let v1 = 0x1::vector::length<u64>(&v0.kids) + arg4;
        if (v1 <= arg0.branches_merge_max) {
            merge_branches<T0>(arg0, arg1, arg2, arg3);
            return 0
        };
        let v2 = v1 / 2 - arg4;
        let v3 = &mut v0.keys;
        let v4 = cut_right<u128>(v3, v2 - 1);
        let v5 = 0x1::vector::pop_back<u128>(&mut v0.keys);
        let v6 = &mut v0.kids;
        let v7 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg3);
        0x1::vector::push_back<u128>(&mut v4, arg2);
        let v8 = &mut v7.keys;
        append_left<u128>(v4, v8);
        let v9 = &mut v7.kids;
        append_left<u64>(cut_right<u64>(v6, v2), v9);
        v5
    }

    fun migrate_to_right_leaf<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        let v1 = 0x1::vector::length<Pair<T0>>(&v0.keys_vals) + arg3;
        if (v1 <= arg0.leaves_merge_max) {
            merge_leaves<T0>(arg0, arg1, arg2);
            return 0
        };
        let v2 = &mut v0.keys_vals;
        let v3 = last<Pair<T0>>(&v0.keys_vals).key;
        let v4 = &mut 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg2).keys_vals;
        append_left<Pair<T0>>(cut_right<Pair<T0>>(v2, v1 / 2 - arg3), v4);
        v3
    }

    public(friend) fun min_key<T0: copy + drop + store>(arg0: &Map<T0>) : u128 {
        0x1::vector::borrow<Pair<T0>>(&0x2::dynamic_field::borrow<u64, Leaf<T0>>(&arg0.id, arg0.first).keys_vals, 0).key
    }

    fun remove_at<T0: copy + drop + store>(arg0: &mut vector<T0>, arg1: u64) : T0 {
        let v0 = 0x1::vector::length<T0>(arg0) - 1;
        while (v0 != arg1) {
            0x1::vector::swap<T0>(arg0, arg1, v0);
            v0 = v0 - 1;
        };
        0x1::vector::pop_back<T0>(arg0)
    }

    fun remove_from_branch<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128) : (T0, u64) {
        let v0 = 0x2::dynamic_field::borrow<u64, Branch>(&arg0.id, arg1);
        let v1 = &v0.keys;
        let v2 = 0x1::vector::length<u128>(v1);
        let v3 = binary_search(v1, v2, arg2);
        let v4 = &v0.kids;
        let v5 = *0x1::vector::borrow<u64>(v4, v3);
        if (9223372036854775808 & v5 == 0) {
            if (v3 < v2) {
                let v6 = v3 + 1;
                let (v7, v8) = remove_from_branch<T0>(arg0, v5, arg2);
                if (v8 < arg0.branch_min) {
                    let v9 = migrate_to_left_branch<T0>(arg0, v5, v8, *0x1::vector::borrow<u128>(v1, v3), *0x1::vector::borrow<u64>(v4, v6));
                    let v10 = &mut v2;
                    update_after_migration<T0>(arg0, arg1, v10, v3, v9, v6);
                };
                return (v7, v2 + 1)
            };
            let v11 = v3 - 1;
            let (v12, v13) = remove_from_branch<T0>(arg0, v5, arg2);
            if (v13 < arg0.branch_min) {
                let v14 = migrate_to_right_branch<T0>(arg0, *0x1::vector::borrow<u64>(v4, v11), *0x1::vector::borrow<u128>(v1, v11), v5, v13);
                let v15 = &mut v2;
                update_after_migration_last<T0>(arg0, arg1, v15, v11, v14);
            };
            return (v12, v2 + 1)
        };
        if (v3 < v2) {
            let v16 = v3 + 1;
            let (v17, v18) = remove_from_leaf<T0>(arg0, v5, arg2);
            if (v18 < arg0.leaf_min) {
                let v19 = migrate_to_left_leaf<T0>(arg0, v5, v18, *0x1::vector::borrow<u64>(v4, v16));
                let v20 = &mut v2;
                update_after_migration<T0>(arg0, arg1, v20, v3, v19, v16);
            };
            return (v17, v2 + 1)
        };
        let v21 = v3 - 1;
        let (v22, v23) = remove_from_leaf<T0>(arg0, v5, arg2);
        if (v23 < arg0.leaf_min) {
            let v24 = migrate_to_right_leaf<T0>(arg0, *0x1::vector::borrow<u64>(v4, v21), v5, v23);
            let v25 = &mut v2;
            update_after_migration_last<T0>(arg0, arg1, v25, v21, v24);
        };
        (v22, v2 + 1)
    }

    fun remove_from_leaf<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: u128) : (T0, u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Leaf<T0>>(&mut arg0.id, arg1);
        let v1 = &v0.keys_vals;
        let v2 = 0x1::vector::length<Pair<T0>>(v1);
        let v3 = binary_search_p<T0>(v1, v2, arg2);
        let v4 = &mut v0.keys_vals;
        let v5 = remove_at<Pair<T0>>(v4, v3);
        assert!(arg2 == v5.key, 0xa9a28467215c27cf504d858634b4e6bbd44755421d31062724c674b13624c900::errors::key_not_exist());
        arg0.size = arg0.size - 1;
        (v5.val, v2 - 1)
    }

    fun reverse<T0: copy + drop + store>(arg0: &mut vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = v0 / 2;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::swap<T0>(arg0, v1, v0 - 1 - v1);
        };
    }

    public(friend) fun size<T0: copy + drop + store>(arg0: &Map<T0>) : u64 {
        arg0.size
    }

    fun split_branch(arg0: &mut Branch, arg1: &mut u64, arg2: u64) : (u64, u128, Branch) {
        let v0 = arg2 >> 1;
        let v1 = &mut arg0.keys;
        let v2 = cut_right<u128>(v1, v0 - 1);
        let v3 = &mut arg0.kids;
        let v4 = Branch{
            keys : v2,
            kids : cut_right<u64>(v3, v0),
        };
        (increase_counter(arg1), 0x1::vector::pop_back<u128>(&mut arg0.keys), v4)
    }

    fun split_leaf<T0: copy + drop + store>(arg0: &mut Leaf<T0>, arg1: &mut u64, arg2: u64) : (u64, u128, Leaf<T0>) {
        let v0 = arg2 >> 1;
        let v1 = &mut arg0.keys_vals;
        let v2 = 9223372036854775808 | increase_counter(arg1);
        arg0.next = v2;
        let v3 = Leaf<T0>{
            keys_vals : cut_right<Pair<T0>>(v1, v0),
            next      : arg0.next,
        };
        (v2, 0x1::vector::borrow<Pair<T0>>(&arg0.keys_vals, arg2 - v0 - 1).key, v3)
    }

    fun update_after_migration<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: &mut u64, arg3: u64, arg4: u128, arg5: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        if (arg4 == 0) {
            let v1 = &mut v0.keys;
            remove_at<u128>(v1, arg3);
            let v2 = &mut v0.kids;
            remove_at<u64>(v2, arg5);
            *arg2 = *arg2 - 1;
            return
        };
        *0x1::vector::borrow_mut<u128>(&mut v0.keys, arg3) = arg4;
    }

    fun update_after_migration_last<T0: copy + drop + store>(arg0: &mut Map<T0>, arg1: u64, arg2: &mut u64, arg3: u64, arg4: u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Branch>(&mut arg0.id, arg1);
        if (arg4 == 0) {
            0x1::vector::pop_back<u128>(&mut v0.keys);
            0x1::vector::pop_back<u64>(&mut v0.kids);
            *arg2 = *arg2 - 1;
            return
        };
        *0x1::vector::borrow_mut<u128>(&mut v0.keys, arg3) = arg4;
    }

    // decompiled from Move bytecode v6
}

