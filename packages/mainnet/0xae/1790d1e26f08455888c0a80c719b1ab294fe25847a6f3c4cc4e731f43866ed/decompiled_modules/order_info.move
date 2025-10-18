module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::order_info {
    struct OrderFilled has copy, drop {
        option_id: 0x2::object::ID,
        maker_order_id: u128,
        taker_order_id: u128,
        maker_address: address,
        taker_address: address,
        price: u64,
        taker_is_buy: bool,
        maker_is_buy: bool,
        taker_is_yes_outcome: bool,
        maker_is_yes_outcome: bool,
        taker_fee: u64,
        maker_fee: u64,
        taker_quantity: u64,
        maker_quantity: u64,
        maker_status: u8,
        volume_usd: u64,
        timestamp: u64,
    }

    struct OrderPlaced has copy, drop {
        order_id: u128,
        option_id: 0x2::object::ID,
        owner: address,
        price: u64,
        is_buy: bool,
        is_yes_outcome: bool,
        quantity: u64,
        executed_quantity: u64,
        epoch: u64,
        status: u8,
        timestamp: u64,
    }

    public(friend) fun emit_order_filled(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: address, arg4: address, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64) {
        let v0 = OrderFilled{
            option_id            : arg0,
            maker_order_id       : arg1,
            taker_order_id       : arg2,
            maker_address        : arg3,
            taker_address        : arg4,
            price                : arg5,
            taker_is_buy         : arg6,
            maker_is_buy         : arg7,
            taker_is_yes_outcome : arg8,
            maker_is_yes_outcome : arg9,
            taker_fee            : arg10,
            maker_fee            : arg11,
            taker_quantity       : arg12,
            maker_quantity       : arg13,
            maker_status         : arg14,
            volume_usd           : arg15,
            timestamp            : arg16,
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun emit_order_placed(arg0: u128, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u64) {
        let v0 = OrderPlaced{
            order_id          : arg0,
            option_id         : arg1,
            owner             : arg2,
            price             : arg3,
            is_buy            : arg4,
            is_yes_outcome    : arg5,
            quantity          : arg6,
            executed_quantity : arg7,
            epoch             : arg8,
            status            : arg9,
            timestamp         : arg10,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    // decompiled from Move bytecode v6
}

