module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events {
    struct AdminCapTransferred has copy, drop {
        owner: address,
    }

    struct ProtocolFeeCapTransferred has copy, drop {
        owner: address,
    }

    struct PooCreated has copy, drop {
        id: 0x2::object::ID,
        coin_a: 0x1::string::String,
        coin_b: 0x1::string::String,
        coin_a_metadata: address,
        coin_b_metadata: address,
        current_sqrt_price: u128,
        current_tick_index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        tick_spacing: u32,
        fee_rate: u64,
        protocol_fee_share: u64,
    }

    struct PositionOpened has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        tick_upper: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
    }

    struct PositionClosed has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        tick_upper: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
    }

    struct AssetSwap has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        before_liquidity: u128,
        after_liquidity: u128,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        current_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        exceeded: bool,
    }

    struct FlashSwap has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        before_liquidity: u128,
        after_liquidity: u128,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        current_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        exceeded: bool,
    }

    struct ProtocolFeeClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        claimed_by: address,
        destination: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
    }

    struct LiquidityProvided has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        liquidity: u128,
        beofre_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        liquidity: u128,
        beofre_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{owner: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_flash_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg11: bool) {
        let v0 = FlashSwap{
            pool_id           : arg0,
            sender            : arg1,
            a2b               : arg2,
            amount_in         : arg3,
            amount_out        : arg4,
            fee               : arg5,
            before_liquidity  : arg6,
            after_liquidity   : arg7,
            before_sqrt_price : arg8,
            after_sqrt_price  : arg9,
            current_tick      : arg10,
            exceeded          : arg11,
        };
        0x2::event::emit<FlashSwap>(v0);
    }

    public(friend) fun emit_liquidity_provided_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        let v0 = LiquidityProvided{
            pool_id            : arg0,
            position_id        : arg1,
            coin_a_amount      : arg2,
            coin_b_amount      : arg3,
            liquidity          : arg4,
            beofre_liquidity   : arg5,
            after_liquidity    : arg6,
            current_sqrt_price : arg7,
            current_tick_index : arg8,
        };
        0x2::event::emit<LiquidityProvided>(v0);
    }

    public(friend) fun emit_liquidity_removed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        let v0 = LiquidityRemoved{
            pool_id            : arg0,
            position_id        : arg1,
            coin_a_amount      : arg2,
            coin_b_amount      : arg3,
            liquidity          : arg4,
            beofre_liquidity   : arg5,
            after_liquidity    : arg6,
            current_sqrt_price : arg7,
            current_tick_index : arg8,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public(friend) fun emit_pool_created_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: u128, arg6: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg7: u32, arg8: u64, arg9: u64) {
        let v0 = PooCreated{
            id                 : arg0,
            coin_a             : arg1,
            coin_b             : arg2,
            coin_a_metadata    : arg3,
            coin_b_metadata    : arg4,
            current_sqrt_price : arg5,
            current_tick_index : arg6,
            tick_spacing       : arg7,
            fee_rate           : arg8,
            protocol_fee_share : arg9,
        };
        0x2::event::emit<PooCreated>(v0);
    }

    public(friend) fun emit_position_close_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg4: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        let v0 = PositionClosed{
            sender      : arg0,
            pool_id     : arg1,
            position_id : arg2,
            tick_lower  : arg3,
            tick_upper  : arg4,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_open_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg4: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        let v0 = PositionOpened{
            sender      : arg0,
            pool_id     : arg1,
            position_id : arg2,
            tick_lower  : arg3,
            tick_upper  : arg4,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_protocol_fee_cap_transfer_event(arg0: address) {
        let v0 = ProtocolFeeCapTransferred{owner: arg0};
        0x2::event::emit<ProtocolFeeCapTransferred>(v0);
    }

    public(friend) fun emit_protocol_fee_claimed(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = ProtocolFeeClaimed{
            pool_id       : arg0,
            claimed_by    : arg1,
            destination   : arg2,
            coin_a_amount : arg3,
            coin_b_amount : arg4,
        };
        0x2::event::emit<ProtocolFeeClaimed>(v0);
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg11: bool) {
        let v0 = AssetSwap{
            pool_id           : arg0,
            sender            : arg1,
            a2b               : arg2,
            amount_in         : arg3,
            amount_out        : arg4,
            fee               : arg5,
            before_liquidity  : arg6,
            after_liquidity   : arg7,
            before_sqrt_price : arg8,
            after_sqrt_price  : arg9,
            current_tick      : arg10,
            exceeded          : arg11,
        };
        0x2::event::emit<AssetSwap>(v0);
    }

    // decompiled from Move bytecode v6
}

