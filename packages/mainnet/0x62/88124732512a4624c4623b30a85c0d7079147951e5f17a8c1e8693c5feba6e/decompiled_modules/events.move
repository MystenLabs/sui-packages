module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events {
    struct UpdateConfigEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        is_dynamic: bool,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        pool_sqrt_price: u128,
        pool_liquidity: u128,
        pool_reserve_x: u64,
        pool_reserve_y: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        pool_sqrt_price: u128,
        pool_liquidity: u128,
        pool_reserve_x: u64,
        pool_reserve_y: u64,
    }

    struct LockPositionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        x2y: bool,
        coin_in_amount: u64,
        coin_out_amount: u64,
        pool_reserve_x: u64,
        pool_reserve_y: u64,
        new_liquidity: u128,
        pre_sqrt_price: u128,
        pool_sqrt_price: u128,
        tick_index_bits: u32,
        creator_fee: u64,
    }

    struct TickUpdateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        tick_index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        new_liquidity_net: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128,
        new_liquidity_gross: u128,
    }

    struct FlywheelBuyEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        buy_amount_y: u64,
        burned_amount_x: u64,
    }

    struct CreatorFeeCollectEvent has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        sui_amount: u64,
    }

    public(friend) fun emit_add_liquidity_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = AddLiquidityEvent{
            pool_id         : arg0,
            sender          : arg1,
            position_id     : arg2,
            amount_x        : arg3,
            amount_y        : arg4,
            pool_sqrt_price : arg5,
            pool_liquidity  : arg6,
            pool_reserve_x  : arg7,
            pool_reserve_y  : arg8,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun emit_create_pool_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: bool) {
        let v0 = CreatePoolEvent{
            pool_id    : arg0,
            coin_x     : arg1,
            coin_y     : arg2,
            is_dynamic : arg3,
        };
        0x2::event::emit<CreatePoolEvent>(v0);
    }

    public(friend) fun emit_creator_fee_collect(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CreatorFeeCollectEvent{
            pool_id    : arg0,
            creator    : arg1,
            sui_amount : arg2,
        };
        0x2::event::emit<CreatorFeeCollectEvent>(v0);
    }

    public(friend) fun emit_flywheel_buy_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = FlywheelBuyEvent{
            pool_id         : arg0,
            sender          : arg1,
            buy_amount_y    : arg2,
            burned_amount_x : arg3,
        };
        0x2::event::emit<FlywheelBuyEvent>(v0);
    }

    public(friend) fun emit_lock_liquidity_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = LockPositionEvent{
            pool_id     : arg0,
            position_id : arg1,
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    public(friend) fun emit_remove_liquidity_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = RemoveLiquidityEvent{
            pool_id         : arg0,
            sender          : arg1,
            position_id     : arg2,
            amount_x        : arg3,
            amount_y        : arg4,
            pool_sqrt_price : arg5,
            pool_liquidity  : arg6,
            pool_reserve_x  : arg7,
            pool_reserve_y  : arg8,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u32, arg13: u64) {
        let v0 = SwapEvent{
            pool_id         : arg0,
            sender          : arg1,
            coin_x          : arg2,
            coin_y          : arg3,
            x2y             : arg4,
            coin_in_amount  : arg5,
            coin_out_amount : arg6,
            pool_reserve_x  : arg7,
            pool_reserve_y  : arg8,
            new_liquidity   : arg9,
            pre_sqrt_price  : arg10,
            pool_sqrt_price : arg11,
            tick_index_bits : arg12,
            creator_fee     : arg13,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public(friend) fun emit_tick_update(arg0: 0x2::object::ID, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg3: u128) {
        let v0 = TickUpdateEvent{
            pool_id             : arg0,
            tick_index          : arg1,
            new_liquidity_net   : arg2,
            new_liquidity_gross : arg3,
        };
        0x2::event::emit<TickUpdateEvent>(v0);
    }

    public(friend) fun emit_update_config_event(arg0: 0x2::object::ID) {
        let v0 = UpdateConfigEvent{id: arg0};
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

