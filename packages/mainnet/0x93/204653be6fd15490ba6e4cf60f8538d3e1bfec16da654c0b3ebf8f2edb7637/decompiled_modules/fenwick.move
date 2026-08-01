module 0x93204653be6fd15490ba6e4cf60f8538d3e1bfec16da654c0b3ebf8f2edb7637::fenwick {
    struct Fenwick has store {
        nodes: 0x2::table::Table<u64, u128>,
        capacity: u64,
        total: u128,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Fenwick {
        assert!(arg0 > 0 && arg0 & arg0 - 1 == 0, 201);
        Fenwick{
            nodes    : 0x2::table::new<u64, u128>(arg1),
            capacity : arg0,
            total    : 0,
        }
    }

    public fun capacity(arg0: &Fenwick) : u64 {
        arg0.capacity
    }

    public fun decrease(arg0: &mut Fenwick, arg1: u64, arg2: u128) {
        assert!(arg1 >= 1 && arg1 <= arg0.capacity, 200);
        if (arg2 == 0) {
            return
        };
        assert!(arg2 <= arg0.total, 203);
        while (arg1 <= arg0.capacity) {
            let v0 = node_at(arg0, arg1);
            assert!(v0 >= arg2, 203);
            node_set(arg0, arg1, v0 - arg2);
            let v1 = lowbit(arg1);
            arg1 = arg1 + v1;
        };
        arg0.total = arg0.total - arg2;
    }

    public fun find(arg0: &Fenwick, arg1: u128) : u64 {
        assert!(arg1 < arg0.total, 202);
        let v0 = 0;
        let v1 = arg0.capacity;
        while (v1 > 0) {
            let v2 = v0 + v1;
            if (v2 <= arg0.capacity) {
                let v3 = node_at(arg0, v2);
                if (v3 <= arg1) {
                    v0 = v2;
                    arg1 = arg1 - v3;
                };
            };
            v1 = v1 / 2;
        };
        v0 + 1
    }

    public fun increase(arg0: &mut Fenwick, arg1: u64, arg2: u128) {
        assert!(arg1 >= 1 && arg1 <= arg0.capacity, 200);
        if (arg2 == 0) {
            return
        };
        while (arg1 <= arg0.capacity) {
            let v0 = node_at(arg0, arg1) + arg2;
            node_set(arg0, arg1, v0);
            let v1 = lowbit(arg1);
            arg1 = arg1 + v1;
        };
        arg0.total = arg0.total + arg2;
    }

    fun lowbit(arg0: u64) : u64 {
        arg0 & (arg0 ^ arg0 - 1)
    }

    fun node_at(arg0: &Fenwick, arg1: u64) : u128 {
        if (0x2::table::contains<u64, u128>(&arg0.nodes, arg1)) {
            *0x2::table::borrow<u64, u128>(&arg0.nodes, arg1)
        } else {
            0
        }
    }

    fun node_set(arg0: &mut Fenwick, arg1: u64, arg2: u128) {
        if (0x2::table::contains<u64, u128>(&arg0.nodes, arg1)) {
            *0x2::table::borrow_mut<u64, u128>(&mut arg0.nodes, arg1) = arg2;
        } else {
            0x2::table::add<u64, u128>(&mut arg0.nodes, arg1, arg2);
        };
    }

    public fun prefix_sum(arg0: &Fenwick, arg1: u64) : u128 {
        assert!(arg1 <= arg0.capacity, 200);
        let v0 = 0;
        while (arg1 > 0) {
            v0 = v0 + node_at(arg0, arg1);
            let v1 = lowbit(arg1);
            arg1 = arg1 - v1;
        };
        v0
    }

    public fun total(arg0: &Fenwick) : u128 {
        arg0.total
    }

    public fun weight_at(arg0: &Fenwick, arg1: u64) : u128 {
        assert!(arg1 >= 1 && arg1 <= arg0.capacity, 200);
        prefix_sum(arg0, arg1) - prefix_sum(arg0, arg1 - 1)
    }

    // decompiled from Move bytecode v7
}

