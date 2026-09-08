module 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position {
    struct BinPosition has copy, drop, store {
        shares: u128,
        generation: u64,
        vec_index: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        bins: 0x2::table::Table<u32, BinPosition>,
        bin_ids: vector<u32>,
        extra: 0x2::bag::Bag,
    }

    public(friend) fun destroy_empty(arg0: Position) {
        let Position {
            id      : v0,
            pool_id : _,
            bins    : v2,
            bin_ids : v3,
            extra   : v4,
        } = arg0;
        let v5 = v3;
        assert!(0x1::vector::length<u32>(&v5) == 0, 301);
        0x2::table::destroy_empty<u32, BinPosition>(v2);
        0x2::bag::destroy_empty(v4);
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id      : 0x2::object::new(arg1),
            pool_id : arg0,
            bins    : 0x2::table::new<u32, BinPosition>(arg1),
            bin_ids : vector[],
            extra   : 0x2::bag::new(arg1),
        }
    }

    public(friend) fun add_shares_for_generation(arg0: &mut Position, arg1: u32, arg2: u128, arg3: u64) {
        assert!(arg2 > 0, 305);
        if (0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1)) {
            let v0 = 0x2::table::borrow_mut<u32, BinPosition>(&mut arg0.bins, arg1);
            assert!(v0.generation == arg3, 306);
            assert!((v0.shares as u256) + (arg2 as u256) <= 340282366920938463463374607431768211455, 303);
            v0.shares = v0.shares + arg2;
        } else {
            assert!(0x1::vector::length<u32>(&arg0.bin_ids) < 256, 304);
            let v1 = BinPosition{
                shares     : arg2,
                generation : arg3,
                vec_index  : 0x1::vector::length<u32>(&arg0.bin_ids),
            };
            0x2::table::add<u32, BinPosition>(&mut arg0.bins, arg1, v1);
            0x1::vector::push_back<u32>(&mut arg0.bin_ids, arg1);
        };
    }

    public(friend) fun bin_generation(arg0: &Position, arg1: u32) : u64 {
        if (0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1)) {
            0x2::table::borrow<u32, BinPosition>(&arg0.bins, arg1).generation
        } else {
            0
        }
    }

    public fun bin_ids(arg0: &Position) : &vector<u32> {
        &arg0.bin_ids
    }

    public fun has_bin(arg0: &Position, arg1: u32) : bool {
        0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1)
    }

    public(friend) fun matches_generation(arg0: &Position, arg1: u32, arg2: u64) : bool {
        0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1) && 0x2::table::borrow<u32, BinPosition>(&arg0.bins, arg1).generation == arg2
    }

    public fun max_bins_per_position() : u64 {
        256
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun remove_shares(arg0: &mut Position, arg1: u32, arg2: u128) : u128 {
        assert!(0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1), 301);
        let v0 = 0x2::table::borrow_mut<u32, BinPosition>(&mut arg0.bins, arg1);
        let v1 = if (arg2 > v0.shares) {
            v0.shares
        } else {
            arg2
        };
        v0.shares = v0.shares - v1;
        if (v0.shares == 0) {
            let v2 = 0x2::table::remove<u32, BinPosition>(&mut arg0.bins, arg1);
            0x1::vector::swap_remove<u32>(&mut arg0.bin_ids, v2.vec_index);
            if (v2.vec_index < 0x1::vector::length<u32>(&arg0.bin_ids)) {
                0x2::table::borrow_mut<u32, BinPosition>(&mut arg0.bins, *0x1::vector::borrow<u32>(&arg0.bin_ids, v2.vec_index)).vec_index = v2.vec_index;
            };
        };
        v1
    }

    public fun shares_in_bin(arg0: &Position, arg1: u32) : u128 {
        if (0x2::table::contains<u32, BinPosition>(&arg0.bins, arg1)) {
            0x2::table::borrow<u32, BinPosition>(&arg0.bins, arg1).shares
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

