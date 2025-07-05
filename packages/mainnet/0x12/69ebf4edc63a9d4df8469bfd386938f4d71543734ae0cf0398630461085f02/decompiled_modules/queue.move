module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::queue {
    struct FifoQueue<T0: store> has store {
        shard_size: u64,
        cursor: u64,
        shards: 0x2::table::Table<u64, vector<T0>>,
    }

    public(friend) fun new<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FifoQueue<T0> {
        FifoQueue<T0>{
            shard_size : arg0,
            cursor     : 0,
            shards     : 0x2::table::new<u64, vector<T0>>(arg1),
        }
    }

    public(friend) fun consume<T0: store>(arg0: &mut FifoQueue<T0>) : vector<T0> {
        if (0x2::table::is_empty<u64, vector<T0>>(&arg0.shards)) {
            arg0.cursor = 0;
        } else {
            arg0.cursor = arg0.cursor + 1;
        };
        0x2::table::remove<u64, vector<T0>>(&mut arg0.shards, arg0.cursor)
    }

    public fun insert<T0: store>(arg0: &mut FifoQueue<T0>, arg1: T0) {
        if (0x2::table::is_empty<u64, vector<T0>>(&arg0.shards)) {
            0x2::table::add<u64, vector<T0>>(&mut arg0.shards, 0, 0x1::vector::empty<T0>());
        };
        let v0 = 0x2::table::length<u64, vector<T0>>(&arg0.shards) - 1 + arg0.cursor;
        let v1 = 0x2::table::borrow_mut<u64, vector<T0>>(&mut arg0.shards, v0);
        if (0x1::vector::length<T0>(v1) < arg0.shard_size) {
            0x1::vector::push_back<T0>(v1, arg1);
        } else {
            let v2 = 0x1::vector::empty<T0>();
            0x1::vector::push_back<T0>(&mut v2, arg1);
            0x2::table::add<u64, vector<T0>>(&mut arg0.shards, v0 + 1, v2);
        };
    }

    // decompiled from Move bytecode v6
}

