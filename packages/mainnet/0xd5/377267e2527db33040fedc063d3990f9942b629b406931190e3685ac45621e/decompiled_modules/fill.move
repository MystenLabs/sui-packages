module 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::fill {
    struct Fill has copy, drop, store {
        maker_order_id: u128,
        maker_client_order_id: u64,
        execution_price: u64,
        balance_manager_id: 0x2::object::ID,
        expired: bool,
        completed: bool,
        original_maker_quantity: u64,
        base_quantity: u64,
        quote_quantity: u64,
        taker_is_bid: bool,
        maker_epoch: u64,
        maker_deep_price: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::deep_price::OrderDeepPrice,
        taker_fee: u64,
        taker_fee_is_deep: bool,
        maker_fee: u64,
        maker_fee_is_deep: bool,
    }

    public(friend) fun new(arg0: u128, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::deep_price::OrderDeepPrice, arg12: bool, arg13: bool) : Fill {
        Fill{
            maker_order_id          : arg0,
            maker_client_order_id   : arg1,
            execution_price         : arg2,
            balance_manager_id      : arg3,
            expired                 : arg4,
            completed               : arg5,
            original_maker_quantity : arg6,
            base_quantity           : arg7,
            quote_quantity          : arg8,
            taker_is_bid            : arg9,
            maker_epoch             : arg10,
            maker_deep_price        : arg11,
            taker_fee               : 0,
            taker_fee_is_deep       : arg12,
            maker_fee               : 0,
            maker_fee_is_deep       : arg13,
        }
    }

    public fun balance_manager_id(arg0: &Fill) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun base_quantity(arg0: &Fill) : u64 {
        arg0.base_quantity
    }

    public fun completed(arg0: &Fill) : bool {
        arg0.completed
    }

    public fun execution_price(arg0: &Fill) : u64 {
        arg0.execution_price
    }

    public fun expired(arg0: &Fill) : bool {
        arg0.expired
    }

    public(friend) fun get_settled_maker_quantities(arg0: &Fill) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::Balances {
        let (v0, v1) = if (arg0.expired) {
            if (arg0.taker_is_bid) {
                (arg0.base_quantity, 0)
            } else {
                (0, arg0.quote_quantity)
            }
        } else if (arg0.taker_is_bid) {
            (0, arg0.quote_quantity)
        } else {
            (arg0.base_quantity, 0)
        };
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::new(v0, v1, 0)
    }

    public fun maker_client_order_id(arg0: &Fill) : u64 {
        arg0.maker_client_order_id
    }

    public fun maker_deep_price(arg0: &Fill) : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::deep_price::OrderDeepPrice {
        arg0.maker_deep_price
    }

    public fun maker_epoch(arg0: &Fill) : u64 {
        arg0.maker_epoch
    }

    public fun maker_fee(arg0: &Fill) : u64 {
        arg0.maker_fee
    }

    public fun maker_fee_is_deep(arg0: &Fill) : bool {
        arg0.maker_fee_is_deep
    }

    public fun maker_order_id(arg0: &Fill) : u128 {
        arg0.maker_order_id
    }

    public fun original_maker_quantity(arg0: &Fill) : u64 {
        arg0.original_maker_quantity
    }

    public fun quote_quantity(arg0: &Fill) : u64 {
        arg0.quote_quantity
    }

    public(friend) fun set_fill_maker_fee(arg0: &mut Fill, arg1: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::Balances) {
        if (0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::deep(arg1) > 0) {
            arg0.maker_fee_is_deep = true;
        } else {
            arg0.maker_fee_is_deep = false;
        };
        arg0.maker_fee = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::non_zero_value(arg1);
    }

    public(friend) fun set_fill_taker_fee(arg0: &mut Fill, arg1: &0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::Balances) {
        if (0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::deep(arg1) > 0) {
            arg0.taker_fee_is_deep = true;
        } else {
            arg0.taker_fee_is_deep = false;
        };
        arg0.taker_fee = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::balances::non_zero_value(arg1);
    }

    public fun taker_fee(arg0: &Fill) : u64 {
        arg0.taker_fee
    }

    public fun taker_fee_is_deep(arg0: &Fill) : bool {
        arg0.taker_fee_is_deep
    }

    public fun taker_is_bid(arg0: &Fill) : bool {
        arg0.taker_is_bid
    }

    // decompiled from Move bytecode v6
}

