module 0x44a9e92e005b9375750045304268ea57e86f8a16a68dfac41f593d771cf40a6a::fenwick {
    struct Fenwick has store {
        nodes: 0x2::table::Table<u64, u128>,
        size: u64,
        total: u128,
    }

    public(friend) fun destroy_empty(arg0: Fenwick) {
        let Fenwick {
            nodes : v0,
            size  : _,
            total : _,
        } = arg0;
        0x2::table::drop<u64, u128>(v0);
    }

    public(friend) fun add(arg0: &mut Fenwick, arg1: u64, arg2: u128) {
        assert!(arg1 < arg0.size, 1);
        if (arg2 == 0) {
            return
        };
        let v0 = arg1 + 1;
        while (v0 <= arg0.size) {
            if (0x2::table::contains<u64, u128>(&arg0.nodes, v0)) {
                *0x2::table::borrow_mut<u64, u128>(&mut arg0.nodes, v0) = node_at(arg0, v0) + arg2;
            } else {
                0x2::table::add<u64, u128>(&mut arg0.nodes, v0, arg2);
            };
            let v1 = lowest_set_bit(v0);
            v0 = v0 + v1;
        };
        arg0.total = arg0.total + arg2;
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Fenwick {
        Fenwick{
            nodes : 0x2::table::new<u64, u128>(arg0),
            size  : 0,
            total : 0,
        }
    }

    public(friend) fun find(arg0: &Fenwick, arg1: u128) : u64 {
        assert!(arg0.total > 0, 2);
        assert!(arg1 < arg0.total, 2);
        let v0 = 0;
        let v1 = highest_power_of_two_at_most(arg0.size);
        while (v1 > 0) {
            let v2 = v0 + v1;
            if (v2 <= arg0.size) {
                let v3 = node_at(arg0, v2);
                if (v3 <= arg1) {
                    v0 = v2;
                    arg1 = arg1 - v3;
                };
            };
            v1 = v1 / 2;
        };
        v0
    }

    fun highest_power_of_two_at_most(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        while (v0 * 2 <= arg0) {
            v0 = v0 * 2;
        };
        v0
    }

    fun lowest_set_bit(arg0: u64) : u64 {
        arg0 & ((arg0 ^ arg0 - 1) + 1) / 2
    }

    fun node_at(arg0: &Fenwick, arg1: u64) : u128 {
        if (0x2::table::contains<u64, u128>(&arg0.nodes, arg1)) {
            *0x2::table::borrow<u64, u128>(&arg0.nodes, arg1)
        } else {
            0
        }
    }

    public(friend) fun prefix_sum(arg0: &Fenwick, arg1: u64) : u128 {
        assert!(arg1 <= arg0.size, 1);
        let v0 = 0;
        while (arg1 > 0) {
            v0 = v0 + node_at(arg0, arg1);
            let v1 = lowest_set_bit(arg1);
            arg1 = arg1 - v1;
        };
        v0
    }

    public(friend) fun push_slot(arg0: &mut Fenwick) : u64 {
        let v0 = arg0.size + 1;
        arg0.size = arg0.size + 1;
        let v1 = prefix_sum(arg0, v0 - 1) - prefix_sum(arg0, v0 - lowest_set_bit(v0));
        if (v1 > 0) {
            0x2::table::add<u64, u128>(&mut arg0.nodes, v0, v1);
        };
        arg0.size
    }

    public(friend) fun size(arg0: &Fenwick) : u64 {
        arg0.size
    }

    public(friend) fun total(arg0: &Fenwick) : u128 {
        arg0.total
    }

    public(friend) fun weight_at(arg0: &Fenwick, arg1: u64) : u128 {
        assert!(arg1 < arg0.size, 1);
        prefix_sum(arg0, arg1 + 1) - prefix_sum(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

