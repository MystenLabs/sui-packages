module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::machine {
    struct ForwardGuard has copy, drop, store {
        guard: address,
        order_ids: vector<u8>,
    }

    struct Forward has copy, drop, store {
        namedOperator: 0x1::string::String,
        weight: u16,
        guard: 0x1::option::Option<ForwardGuard>,
        permission_index: 0x1::option::Option<u16>,
    }

    struct NodePair has copy, drop, store {
        threshold: u32,
        forwards: 0x2::vec_map::VecMap<0x1::string::String, Forward>,
    }

    struct Node has drop, store {
        name: 0x1::string::String,
        body: 0x2::vec_map::VecMap<0x1::string::String, NodePair>,
    }

    public fun NODE_COUNT(arg0: u64) {
        assert!(arg0 < 200, 1404);
    }

    public fun NODE_EXIST() {
        abort 1401
    }

    public fun NODE_NOT_FOUND(arg0: bool) {
        assert!(arg0, 1407);
    }

    public fun PROGRESS(arg0: bool, arg1: bool) {
        assert!(!arg0, 1400);
        assert!(arg1, 1403);
    }

    public fun UNPUBLISHED(arg0: bool) {
        assert!(!arg0, 1402);
    }

    public fun forward(arg0: 0x1::string::String, arg1: 0x1::option::Option<u16>, arg2: u16, arg3: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg4: vector<u8>) : Forward {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(&arg0);
        assert!(0x1::vector::length<u8>(&arg4) <= 20, 1405);
        assert!(!0x1::string::is_empty(&arg0) || 0x1::option::is_some<u16>(&arg1), 1406);
        let v0 = b"order";
        assert!(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::isWineessModule(arg3, &arg4, &v0), 1408);
        let v1 = ForwardGuard{
            guard     : 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg3),
            order_ids : arg4,
        };
        Forward{
            namedOperator    : arg0,
            weight           : arg2,
            guard            : 0x1::option::some<ForwardGuard>(v1),
            permission_index : arg1,
        }
    }

    public fun forward2(arg0: 0x1::string::String, arg1: 0x1::option::Option<u16>, arg2: u16) : Forward {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(&arg0);
        assert!(!0x1::string::is_empty(&arg0) || 0x1::option::is_some<u16>(&arg1), 1406);
        Forward{
            namedOperator    : arg0,
            weight           : arg2,
            guard            : 0x1::option::none<ForwardGuard>(),
            permission_index : arg1,
        }
    }

    public fun forward_add(arg0: &mut Node, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<u32>, arg4: &Forward) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(&arg1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN_ANDNOT_EMPTY(&arg2);
        if (0x2::vec_map::contains<0x1::string::String, NodePair>(&arg0.body, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, NodePair>(&mut arg0.body, &arg1);
            nodepair_threshold_set(v0, &arg3);
            if (0x2::vec_map::contains<0x1::string::String, Forward>(&v0.forwards, &arg2)) {
                *0x2::vec_map::get_mut<0x1::string::String, Forward>(&mut v0.forwards, &arg2) = *arg4;
            } else {
                0x2::vec_map::insert<0x1::string::String, Forward>(&mut v0.forwards, arg2, *arg4);
            };
        } else {
            0x2::vec_map::insert<0x1::string::String, NodePair>(&mut arg0.body, arg1, nodepair(&arg3, &arg2, arg4));
        };
    }

    public fun forward_add_none(arg0: &mut Node, arg1: 0x1::string::String, arg2: 0x1::option::Option<u32>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(&arg1);
        if (0x2::vec_map::contains<0x1::string::String, NodePair>(&arg0.body, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, NodePair>(&mut arg0.body, &arg1);
            nodepair_threshold_set(v0, &arg2);
        } else {
            0x2::vec_map::insert<0x1::string::String, NodePair>(&mut arg0.body, arg1, nodepair2(&arg2));
        };
    }

    public fun forward_borrow(arg0: &0x2::vec_map::VecMap<0x1::string::String, NodePair>, arg1: &0x1::string::String, arg2: &0x1::string::String) : &Forward {
        0x2::vec_map::get<0x1::string::String, Forward>(&0x2::vec_map::get<0x1::string::String, NodePair>(arg0, arg1).forwards, arg2)
    }

    public fun forward_data(arg0: &Forward) : (u16, 0x1::option::Option<address>, vector<u8>, &0x1::string::String, &0x1::option::Option<u16>) {
        if (0x1::option::is_some<ForwardGuard>(&arg0.guard)) {
            let v0 = 0x1::option::borrow<ForwardGuard>(&arg0.guard);
            return (arg0.weight, 0x1::option::some<address>(v0.guard), v0.order_ids, &arg0.namedOperator, &arg0.permission_index)
        };
        (arg0.weight, 0x1::option::none<address>(), 0x1::vector::empty<u8>(), &arg0.namedOperator, &arg0.permission_index)
    }

    public fun forward_remove(arg0: &mut Node, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, NodePair>(&arg0.body, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, NodePair>(&mut arg0.body, &arg1);
            if (0x2::vec_map::contains<0x1::string::String, Forward>(&v0.forwards, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, Forward>(&mut v0.forwards, &arg2);
            };
        };
    }

    public fun node_add_imp(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, NodePair>, arg1: &Node) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::string::String, NodePair>(&arg1.body)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, NodePair>(&arg1.body, v0);
            if (0x2::vec_map::contains<0x1::string::String, NodePair>(arg0, v1)) {
                *0x2::vec_map::get_mut<0x1::string::String, NodePair>(arg0, v1) = *v2;
            } else {
                0x2::vec_map::insert<0x1::string::String, NodePair>(arg0, *v1, *v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun node_get(arg0: &Node) : (&0x1::string::String, &0x2::vec_map::VecMap<0x1::string::String, NodePair>) {
        (&arg0.name, &arg0.body)
    }

    public fun node_new(arg0: 0x1::string::String) : Node {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN_ANDNOT_EMPTY(&arg0);
        Node{
            name : arg0,
            body : 0x2::vec_map::empty<0x1::string::String, NodePair>(),
        }
    }

    public fun node_new2(arg0: &0x1::string::String, arg1: &0x2::vec_map::VecMap<0x1::string::String, NodePair>) : Node {
        Node{
            name : *arg0,
            body : *arg1,
        }
    }

    fun nodepair(arg0: &0x1::option::Option<u32>, arg1: &0x1::string::String, arg2: &Forward) : NodePair {
        let v0 = 0;
        if (0x1::option::is_some<u32>(arg0)) {
            v0 = *0x1::option::borrow<u32>(arg0);
        };
        let v1 = NodePair{
            threshold : v0,
            forwards  : 0x2::vec_map::empty<0x1::string::String, Forward>(),
        };
        0x2::vec_map::insert<0x1::string::String, Forward>(&mut v1.forwards, *arg1, *arg2);
        v1
    }

    fun nodepair2(arg0: &0x1::option::Option<u32>) : NodePair {
        let v0 = 0;
        if (0x1::option::is_some<u32>(arg0)) {
            v0 = *0x1::option::borrow<u32>(arg0);
        };
        NodePair{
            threshold : v0,
            forwards  : 0x2::vec_map::empty<0x1::string::String, Forward>(),
        }
    }

    fun nodepair_threshold_set(arg0: &mut NodePair, arg1: &0x1::option::Option<u32>) {
        if (0x1::option::is_some<u32>(arg1)) {
            arg0.threshold = *0x1::option::borrow<u32>(arg1);
        };
    }

    public fun pair_remove(arg0: &mut Node, arg1: 0x1::string::String) {
        let v0 = &mut arg0.body;
        pair_remove_imp(v0, &arg1);
    }

    public fun pair_remove_imp(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, NodePair>, arg1: &0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, NodePair>(arg0, arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, NodePair>(arg0, arg1);
        };
    }

    public fun threshold(arg0: &0x2::vec_map::VecMap<0x1::string::String, NodePair>, arg1: &0x1::string::String) : u32 {
        0x2::vec_map::get<0x1::string::String, NodePair>(arg0, arg1).threshold
    }

    public fun threshold_set(arg0: &mut Node, arg1: 0x1::string::String, arg2: 0x1::option::Option<u32>) {
        if (0x2::vec_map::contains<0x1::string::String, NodePair>(&arg0.body, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, NodePair>(&mut arg0.body, &arg1);
            nodepair_threshold_set(v0, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

