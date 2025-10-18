module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::order {
    struct OrderCanceled has copy, drop {
        order_id: u128,
        option_id: 0x2::object::ID,
        owner: address,
        price: u64,
        original_quantity: u64,
        quantity_canceled: u64,
        is_buy: bool,
        is_yes_outcome: bool,
        timestamp: u64,
    }

    public(friend) fun emit_order_canceled(arg0: u128, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u64) {
        let v0 = OrderCanceled{
            order_id          : arg0,
            option_id         : arg1,
            owner             : arg2,
            price             : arg3,
            original_quantity : arg4,
            quantity_canceled : arg5,
            is_buy            : arg6,
            is_yes_outcome    : arg7,
            timestamp         : arg8,
        };
        0x2::event::emit<OrderCanceled>(v0);
    }

    // decompiled from Move bytecode v6
}

