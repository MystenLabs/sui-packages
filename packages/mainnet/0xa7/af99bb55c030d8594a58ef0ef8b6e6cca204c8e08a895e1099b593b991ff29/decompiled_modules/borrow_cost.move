module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::borrow_cost {
    struct BorrowCostSettled has copy, drop {
        trader: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        position_size: u64,
        index_price: u64,
        borrow_cost: u64,
        short_borrow_index_delta: u128,
    }

    public fun compute_borrow_cost(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg2 <= arg3) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 1000000000 * (arg2 - arg3) / 1000000000000000000) as u64)
    }

    public fun compute_borrow_cost_from_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 1000000000 * (arg2 as u128) * (arg3 as u128) / 31536000 * 10000) as u64)
    }

    public fun direction_short() : u8 {
        1
    }

    public fun is_short(arg0: u8) : bool {
        arg0 == 1
    }

    public(friend) fun settle_borrow_cost(arg0: address, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : u64 {
        if (arg3 != 1) {
            return 0
        };
        assert!(arg5 > 0, 0);
        let v0 = compute_borrow_cost(arg4, arg5, arg6, arg7);
        if (v0 > 0) {
            let v1 = BorrowCostSettled{
                trader                   : arg0,
                market_id                : arg1,
                symbol                   : arg2,
                position_size            : arg4,
                index_price              : arg5,
                borrow_cost              : v0,
                short_borrow_index_delta : arg6 - arg7,
            };
            0x2::event::emit<BorrowCostSettled>(v1);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

