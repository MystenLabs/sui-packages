module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::active_set {
    struct ActiveSetEntry has copy, drop, store {
        node_id: 0x2::object::ID,
        staked_amount: u64,
    }

    struct ActiveSet has copy, drop, store {
        max_size: u16,
        threshold_stake: u64,
        nodes: vector<ActiveSetEntry>,
        total_stake: u64,
    }

    public(friend) fun active_ids(arg0: &ActiveSet) : vector<0x2::object::ID> {
        let v0 = &arg0.nodes;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<ActiveSetEntry>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x1::vector::borrow<ActiveSetEntry>(v0, v2).node_id);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun active_ids_and_stake(arg0: &ActiveSet) : (vector<0x2::object::ID>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = &arg0.nodes;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ActiveSetEntry>(v2)) {
            let v4 = 0x1::vector::borrow<ActiveSetEntry>(v2, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v4.node_id);
            0x1::vector::push_back<u64>(&mut v1, v4.staked_amount);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    fun insert(arg0: &mut ActiveSet, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = &arg0.nodes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<ActiveSetEntry>(v0)) {
            if (0x1::vector::borrow<ActiveSetEntry>(v0, v1).node_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_none<u64>(&v2), 1);
                if ((0x1::vector::length<ActiveSetEntry>(&arg0.nodes) as u16) < arg0.max_size) {
                    arg0.total_stake = arg0.total_stake + arg2;
                    let v3 = ActiveSetEntry{
                        node_id       : arg1,
                        staked_amount : arg2,
                    };
                    0x1::vector::push_back<ActiveSetEntry>(&mut arg0.nodes, v3);
                    return true
                };
                let v4 = arg2;
                let v5 = 0x1::option::none<u64>();
                let v6 = 0;
                while (v6 < 0x1::vector::length<ActiveSetEntry>(&arg0.nodes)) {
                    if (0x1::vector::borrow<ActiveSetEntry>(&arg0.nodes, v6).staked_amount < v4) {
                        v5 = 0x1::option::some<u64>(v6);
                        v4 = 0x1::vector::borrow<ActiveSetEntry>(&arg0.nodes, v6).staked_amount;
                    };
                    v6 = v6 + 1;
                };
                return if (0x1::option::is_some<u64>(&v5)) {
                    arg0.total_stake = arg0.total_stake - v4 + arg2;
                    let v8 = ActiveSetEntry{
                        node_id       : arg1,
                        staked_amount : arg2,
                    };
                    *0x1::vector::borrow_mut<ActiveSetEntry>(&mut arg0.nodes, 0x1::option::extract<u64>(&mut v5)) = v8;
                    true
                } else {
                    false
                }
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun insert_or_update(arg0: &mut ActiveSet, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (arg2 == 0 || arg2 < arg0.threshold_stake) {
            remove(arg0, arg1);
            return false
        };
        update(arg0, arg1, arg2) || insert(arg0, arg1, arg2)
    }

    public(friend) fun max_size(arg0: &ActiveSet) : u16 {
        arg0.max_size
    }

    public(friend) fun new(arg0: u16, arg1: u64) : ActiveSet {
        assert!(arg0 > 0, 0);
        ActiveSet{
            max_size        : arg0,
            threshold_stake : arg1,
            nodes           : 0x1::vector::empty<ActiveSetEntry>(),
            total_stake     : 0,
        }
    }

    public(friend) fun remove(arg0: &mut ActiveSet, arg1: 0x2::object::ID) {
        let v0 = &arg0.nodes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<ActiveSetEntry>(v0)) {
            if (0x1::vector::borrow<ActiveSetEntry>(v0, v1).node_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    let v3 = 0x1::vector::swap_remove<ActiveSetEntry>(&mut arg0.nodes, 0x1::option::destroy_some<u64>(v2));
                    arg0.total_stake = arg0.total_stake - v3.staked_amount;
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun size(arg0: &ActiveSet) : u16 {
        (0x1::vector::length<ActiveSetEntry>(&arg0.nodes) as u16)
    }

    public(friend) fun threshold_stake(arg0: &ActiveSet) : u64 {
        arg0.threshold_stake
    }

    public(friend) fun total_stake(arg0: &ActiveSet) : u64 {
        arg0.total_stake
    }

    public(friend) fun update(arg0: &mut ActiveSet, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = &arg0.nodes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<ActiveSetEntry>(v0)) {
            if (0x1::vector::borrow<ActiveSetEntry>(v0, v1).node_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    return false
                };
                if (0x1::option::is_some<u64>(&v2)) {
                    let v3 = 0x1::option::destroy_some<u64>(v2);
                    arg0.total_stake = arg0.total_stake + arg2 - 0x1::vector::borrow<ActiveSetEntry>(&arg0.nodes, v3).staked_amount;
                    0x1::vector::borrow_mut<ActiveSetEntry>(&mut arg0.nodes, v3).staked_amount = arg2;
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                return true
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

