module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events {
    struct CreatePoolEvent has copy, drop {
        sender: address,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
    }

    struct AddLpEvent has copy, drop {
        sender: address,
        lp: u64,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        input_x: u64,
        input_y: u64,
        real_x: u64,
        real_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        total_lp: u64,
    }

    struct RemoveLpEvent has copy, drop {
        sender: address,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        lp: u64,
        min_x: u64,
        min_y: u64,
        real_x: u64,
        real_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        total_lp: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        in_coin: 0x1::ascii::String,
        out_coin: 0x1::ascii::String,
        in_amount: u64,
        out_amount: u64,
        out_min_amount: u64,
        dao_fee: u64,
        lp_fee: u64,
        reserve_x: u64,
        reserve_y: u64,
    }

    public(friend) fun emit_add_lp_event<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = AddLpEvent{
            sender    : arg0,
            lp        : arg1,
            coin_x    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_y    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            input_x   : arg2,
            input_y   : arg3,
            real_x    : arg4,
            real_y    : arg5,
            reserve_x : arg6,
            reserve_y : arg7,
            total_lp  : arg8,
        };
        0x2::event::emit<AddLpEvent>(v0);
    }

    public(friend) fun emit_create_pool_event<T0, T1>(arg0: address, arg1: 0x2::object::ID) {
        let v0 = CreatePoolEvent{
            sender  : arg0,
            coin_x  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_y  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            pool_id : arg1,
        };
        0x2::event::emit<CreatePoolEvent>(v0);
    }

    public(friend) fun emit_remove_lp_event<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = RemoveLpEvent{
            sender    : arg0,
            coin_x    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_y    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            lp        : arg1,
            min_x     : arg2,
            min_y     : arg3,
            real_x    : arg4,
            real_y    : arg5,
            reserve_x : arg6,
            reserve_y : arg7,
            total_lp  : arg8,
        };
        0x2::event::emit<RemoveLpEvent>(v0);
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = SwapEvent{
            sender         : arg0,
            in_coin        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            out_coin       : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            in_amount      : arg1,
            out_amount     : arg2,
            out_min_amount : arg3,
            dao_fee        : arg4,
            lp_fee         : arg5,
            reserve_x      : arg6,
            reserve_y      : arg7,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

