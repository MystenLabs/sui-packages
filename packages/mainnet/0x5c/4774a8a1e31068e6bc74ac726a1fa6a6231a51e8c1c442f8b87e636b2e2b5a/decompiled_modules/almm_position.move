module 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        shares: 0x2::table::Table<u32, u64>,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: vector<u32>, arg2: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id      : 0x2::object::new(arg2),
            pair_id : arg0,
            bin_ids : arg1,
            shares  : 0x2::table::new<u32, u64>(arg2),
        }
    }

    public(friend) fun decrease_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.shares, arg1)
        } else {
            0
        };
        assert!(v0 >= arg2, 1);
        0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v0 - arg2);
    }

    public(friend) fun destroy(arg0: Position) {
        let Position {
            id      : v0,
            pair_id : _,
            bin_ids : _,
            shares  : v3,
        } = arg0;
        0x2::table::drop<u32, u64>(v3);
        0x2::object::delete(v0);
    }

    public fun ids(arg0: &Position) : &vector<u32> {
        &arg0.bin_ids
    }

    public(friend) fun increase_shares(arg0: &mut Position, arg1: u32, arg2: u64) {
        let v0 = if (0x2::table::contains<u32, u64>(&arg0.shares, arg1)) {
            0x2::table::remove<u32, u64>(&mut arg0.shares, arg1)
        } else {
            0
        };
        0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v0 + arg2);
    }

    public fun info(arg0: &Position) : (0x2::object::ID, &vector<u32>, &0x2::table::Table<u32, u64>) {
        (pair_id(arg0), ids(arg0), shares(arg0))
    }

    public fun pair_id(arg0: &Position) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun shares(arg0: &Position) : &0x2::table::Table<u32, u64> {
        &arg0.shares
    }

    public(friend) fun shrink(arg0: &mut Position, arg1: u32, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<u32>(&arg0.bin_ids, &arg1);
        assert!(v0, 13906834410566582271);
        assert!(*0x2::table::borrow<u32, u64>(&arg0.shares, arg1) >= arg2, 13906834414861549567);
        let v2 = 0x2::table::remove<u32, u64>(&mut arg0.shares, arg1);
        if (v2 == arg2) {
            0x1::vector::remove<u32>(&mut arg0.bin_ids, v1);
        } else {
            0x2::table::add<u32, u64>(&mut arg0.shares, arg1, v2 - arg2);
        };
    }

    // decompiled from Move bytecode v6
}

