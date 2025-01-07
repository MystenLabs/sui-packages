module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit {
    struct Leaf<T0> has drop, store {
        key: u64,
        value: T0,
        parent: u64,
    }

    struct InternalNode has drop, store {
        mask: u64,
        left_child: u64,
        right_child: u64,
        parent: u64,
    }

    struct CritbitTree<T0: store> has store {
        root: u64,
        internal_nodes: 0x2::table::Table<u64, InternalNode>,
        leaves: 0x2::table::Table<u64, Leaf<T0>>,
        min_leaf: u64,
        max_leaf: u64,
        next_internal_node_index: u64,
        next_leaf_index: u64,
    }

    public(friend) fun destroy_empty<T0: store>(arg0: CritbitTree<T0>) {
        assert!(0x2::table::length<u64, Leaf<T0>>(&arg0.leaves) == 0, 0);
        let CritbitTree {
            root                     : _,
            internal_nodes           : v1,
            leaves                   : v2,
            min_leaf                 : _,
            max_leaf                 : _,
            next_internal_node_index : _,
            next_leaf_index          : _,
        } = arg0;
        0x2::table::destroy_empty<u64, Leaf<T0>>(v2);
        0x2::table::destroy_empty<u64, InternalNode>(v1);
    }

    public(friend) fun drop<T0: drop + store>(arg0: CritbitTree<T0>) {
        let CritbitTree {
            root                     : _,
            internal_nodes           : v1,
            leaves                   : v2,
            min_leaf                 : _,
            max_leaf                 : _,
            next_internal_node_index : _,
            next_leaf_index          : _,
        } = arg0;
        0x2::table::drop<u64, InternalNode>(v1);
        0x2::table::drop<u64, Leaf<T0>>(v2);
    }

    public fun is_empty<T0: store>(arg0: &CritbitTree<T0>) : bool {
        0x2::table::is_empty<u64, Leaf<T0>>(&arg0.leaves)
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : CritbitTree<T0> {
        CritbitTree<T0>{
            root                     : 9223372036854775808,
            internal_nodes           : 0x2::table::new<u64, InternalNode>(arg0),
            leaves                   : 0x2::table::new<u64, Leaf<T0>>(arg0),
            min_leaf                 : 9223372036854775808,
            max_leaf                 : 9223372036854775808,
            next_internal_node_index : 0,
            next_leaf_index          : 0,
        }
    }

    public fun assert_has_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) {
        let (v0, _) = find_leaf<T0>(arg0, arg1);
        assert!(v0, 5);
    }

    public fun borrow_leaf_by_index<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : &T0 {
        &0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg1).value
    }

    public fun borrow_leaf_by_key<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : &T0 {
        let (v0, v1) = find_leaf<T0>(arg0, arg1);
        assert!(v0, 5);
        borrow_leaf_by_index<T0>(arg0, v1)
    }

    public(friend) fun borrow_mut_leaf_by_index<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64) : &mut T0 {
        &mut 0x2::table::borrow_mut<u64, Leaf<T0>>(&mut arg0.leaves, arg1).value
    }

    public fun borrow_mut_leaf_by_key<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64) : &mut T0 {
        let (v0, v1) = find_leaf<T0>(arg0, arg1);
        assert!(v0, 5);
        borrow_mut_leaf_by_index<T0>(arg0, v1)
    }

    fun count_leading_zeros(arg0: u128) : u8 {
        if (arg0 == 0) {
            128
        } else {
            let v1 = 0;
            let v2 = v1;
            if (arg0 & 340282366920938463444927863358058659840 == 0) {
                arg0 = arg0 << 64;
                v2 = v1 + 64;
            };
            if (arg0 & 340282366841710300949110269838224261120 == 0) {
                arg0 = arg0 << 32;
                v2 = v2 + 32;
            };
            if (arg0 & 340277174624079928635746076935438991360 == 0) {
                arg0 = arg0 << 16;
                v2 = v2 + 16;
            };
            if (arg0 & 338953138925153547590470800371487866880 == 0) {
                arg0 = arg0 << 8;
                v2 = v2 + 8;
            };
            if (arg0 & 319014718988379809496913694467282698240 == 0) {
                arg0 = arg0 << 4;
                v2 = v2 + 4;
            };
            if (arg0 & 255211775190703847597530955573826158592 == 0) {
                arg0 = arg0 << 2;
                v2 = v2 + 2;
            };
            if (arg0 & 170141183460469231731687303715884105728 == 0) {
                v2 = v2 + 1;
            };
            v2
        }
    }

    public(friend) fun find_closest_key<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : u64 {
        if (is_empty<T0>(arg0)) {
            return 0
        };
        0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, get_closest_leaf_index_by_key<T0>(arg0, arg1)).key
    }

    public fun find_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : (bool, u64) {
        if (is_empty<T0>(arg0)) {
            return (false, 9223372036854775808)
        };
        let v0 = get_closest_leaf_index_by_key<T0>(arg0, arg1);
        if (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v0).key != arg1) {
            return (false, 9223372036854775808)
        };
        (true, v0)
    }

    fun get_closest_leaf_index_by_key<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : u64 {
        let v0 = arg0.root;
        let v1 = v0;
        if (v0 == 9223372036854775808) {
            return 9223372036854775808
        };
        while (v1 < 9223372036854775808) {
            let v2 = 0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v1);
            if (arg1 & v2.mask == 0) {
                v1 = v2.left_child;
                continue
            };
            v1 = v2.right_child;
        };
        18446744073709551615 - v1
    }

    public fun has_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : bool {
        let (v0, _) = find_leaf<T0>(arg0, arg1);
        v0
    }

    public fun insert_leaf<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64, arg2: T0) : u64 {
        let v0 = Leaf<T0>{
            key    : arg1,
            value  : arg2,
            parent : 9223372036854775808,
        };
        let v1 = arg0.next_leaf_index;
        arg0.next_leaf_index = arg0.next_leaf_index + 1;
        assert!(v1 < 9223372036854775807 - 1, 2);
        0x2::table::add<u64, Leaf<T0>>(&mut arg0.leaves, v1, v0);
        let v2 = get_closest_leaf_index_by_key<T0>(arg0, arg1);
        if (v2 == 9223372036854775808) {
            assert!(v1 == 0, 3);
            arg0.root = 18446744073709551615 - v1;
            arg0.min_leaf = v1;
            arg0.max_leaf = v1;
            return 0
        };
        let v3 = 0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v2).key;
        assert!(v3 != arg1, 4);
        let v4 = 1 << 64 - count_leading_zeros(((v3 ^ arg1) as u128)) - 64 - 1;
        let v5 = InternalNode{
            mask        : v4,
            left_child  : 9223372036854775808,
            right_child : 9223372036854775808,
            parent      : 9223372036854775808,
        };
        let v6 = arg0.next_internal_node_index;
        arg0.next_internal_node_index = arg0.next_internal_node_index + 1;
        0x2::table::add<u64, InternalNode>(&mut arg0.internal_nodes, v6, v5);
        let v7 = arg0.root;
        let v8 = 9223372036854775808;
        while (v7 < 9223372036854775808) {
            let v9 = 0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v7);
            if (v4 > v9.mask) {
                break
            };
            if (arg1 & v9.mask == 0) {
                v7 = v9.left_child;
                continue
            };
            v7 = v9.right_child;
        };
        if (v8 == 9223372036854775808) {
            arg0.root = v6;
        } else {
            let v10 = is_left_child<T0>(arg0, v8, v7);
            update_child<T0>(arg0, v8, v6, v10);
        };
        let v11 = v4 & arg1 == 0;
        update_child<T0>(arg0, v6, 18446744073709551615 - v1, v11);
        update_child<T0>(arg0, v6, v7, !v11);
        if (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg0.min_leaf).key > arg1) {
            arg0.min_leaf = v1;
        };
        if (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg0.max_leaf).key < arg1) {
            arg0.max_leaf = v1;
        };
        v1
    }

    fun is_left_child<T0: store>(arg0: &CritbitTree<T0>, arg1: u64, arg2: u64) : bool {
        0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, arg1).left_child == arg2
    }

    fun left_most_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : u64 {
        let v0 = arg1;
        while (v0 < 9223372036854775808) {
            let v1 = &0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v0).left_child;
            v0 = *v1;
        };
        v0
    }

    public fun max_leaf<T0: store>(arg0: &CritbitTree<T0>) : (u64, u64) {
        assert!(!is_empty<T0>(arg0), 5);
        (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg0.max_leaf).key, arg0.max_leaf)
    }

    public fun min_leaf<T0: store>(arg0: &CritbitTree<T0>) : (u64, u64) {
        assert!(!is_empty<T0>(arg0), 5);
        (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg0.min_leaf).key, arg0.min_leaf)
    }

    public(friend) fun next_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : (u64, u64) {
        let (_, v1) = find_leaf<T0>(arg0, arg1);
        assert!(v1 != 9223372036854775808, 5);
        let v2 = 18446744073709551615 - v1;
        let v3 = 0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v1).parent;
        while (v3 != 9223372036854775808 && !is_left_child<T0>(arg0, v3, v2)) {
            v2 = v3;
            let v4 = &0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v3).parent;
            v3 = *v4;
        };
        if (v3 == 9223372036854775808) {
            return (0, 9223372036854775808)
        };
        let v5 = 18446744073709551615 - left_most_leaf<T0>(arg0, 0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v3).right_child);
        (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v5).key, v5)
    }

    public fun previous_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : (u64, u64) {
        let (_, v1) = find_leaf<T0>(arg0, arg1);
        assert!(v1 != 9223372036854775808, 5);
        let v2 = 18446744073709551615 - v1;
        let v3 = 0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v1).parent;
        while (v3 != 9223372036854775808 && is_left_child<T0>(arg0, v3, v2)) {
            v2 = v3;
            let v4 = &0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v3).parent;
            v3 = *v4;
        };
        if (v3 == 9223372036854775808) {
            return (0, 9223372036854775808)
        };
        let v5 = 18446744073709551615 - right_most_leaf<T0>(arg0, 0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v3).left_child);
        (0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, v5).key, v5)
    }

    public(friend) fun remove_leaf_by_index<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64) : T0 {
        let v0 = 0x2::table::borrow<u64, Leaf<T0>>(&arg0.leaves, arg1).key;
        if (arg0.min_leaf == arg1) {
            let (_, v2) = next_leaf<T0>(arg0, v0);
            arg0.min_leaf = v2;
        };
        if (arg0.max_leaf == arg1) {
            let (_, v4) = previous_leaf<T0>(arg0, v0);
            arg0.max_leaf = v4;
        };
        let Leaf {
            key    : _,
            value  : v6,
            parent : v7,
        } = 0x2::table::remove<u64, Leaf<T0>>(&mut arg0.leaves, arg1);
        if (size<T0>(arg0) == 0) {
            arg0.root = 9223372036854775808;
            arg0.min_leaf = 9223372036854775808;
            arg0.max_leaf = 9223372036854775808;
            arg0.next_internal_node_index = 0;
            arg0.next_leaf_index = 0;
        } else {
            assert!(v7 != 9223372036854775808, 7);
            let v8 = 0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v7);
            let v9 = v8.parent;
            let v10 = if (is_left_child<T0>(arg0, v7, 18446744073709551615 - arg1)) {
                v8.right_child
            } else {
                v8.left_child
            };
            if (v9 == 9223372036854775808) {
                if (v10 < 9223372036854775808) {
                    0x2::table::borrow_mut<u64, InternalNode>(&mut arg0.internal_nodes, v10).parent = 9223372036854775808;
                } else {
                    0x2::table::borrow_mut<u64, Leaf<T0>>(&mut arg0.leaves, 18446744073709551615 - v10).parent = 9223372036854775808;
                };
                arg0.root = v10;
            } else {
                let v11 = is_left_child<T0>(arg0, v9, v7);
                update_child<T0>(arg0, v9, v10, v11);
            };
            0x2::table::remove<u64, InternalNode>(&mut arg0.internal_nodes, v7);
        };
        v6
    }

    public fun remove_leaf_by_key<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64) : T0 {
        let (v0, v1) = find_leaf<T0>(arg0, arg1);
        assert!(v0, 5);
        remove_leaf_by_index<T0>(arg0, v1)
    }

    fun right_most_leaf<T0: store>(arg0: &CritbitTree<T0>, arg1: u64) : u64 {
        let v0 = arg1;
        while (v0 < 9223372036854775808) {
            let v1 = &0x2::table::borrow<u64, InternalNode>(&arg0.internal_nodes, v0).right_child;
            v0 = *v1;
        };
        v0
    }

    public fun size<T0: store>(arg0: &CritbitTree<T0>) : u64 {
        0x2::table::length<u64, Leaf<T0>>(&arg0.leaves)
    }

    fun update_child<T0: store>(arg0: &mut CritbitTree<T0>, arg1: u64, arg2: u64, arg3: bool) {
        assert!(arg1 != 9223372036854775808, 8);
        if (arg3) {
            0x2::table::borrow_mut<u64, InternalNode>(&mut arg0.internal_nodes, arg1).left_child = arg2;
        } else {
            0x2::table::borrow_mut<u64, InternalNode>(&mut arg0.internal_nodes, arg1).right_child = arg2;
        };
        if (arg2 != 9223372036854775808) {
            if (arg2 > 9223372036854775808) {
                0x2::table::borrow_mut<u64, Leaf<T0>>(&mut arg0.leaves, 18446744073709551615 - arg2).parent = arg1;
            } else {
                0x2::table::borrow_mut<u64, InternalNode>(&mut arg0.internal_nodes, arg2).parent = arg1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

