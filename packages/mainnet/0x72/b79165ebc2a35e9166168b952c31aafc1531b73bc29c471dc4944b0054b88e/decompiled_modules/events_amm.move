module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm {
    struct AddLiquidityEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    struct RemoveLiquidityEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    public(friend) fun emit_add_liquidity_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = AddLiquidityEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun emit_remove_liquidity_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = RemoveLiquidityEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

