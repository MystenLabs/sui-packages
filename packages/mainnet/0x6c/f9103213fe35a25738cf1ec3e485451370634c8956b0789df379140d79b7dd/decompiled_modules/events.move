module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events {
    struct AdminCapTransferred has copy, drop {
        owner: address,
    }

    struct ProtocolFeeCapTransferred has copy, drop {
        owner: address,
    }

    struct PoolCreated has copy, drop {
        id: 0x2::object::ID,
        coin_a: 0x1::string::String,
        coin_b: 0x1::string::String,
        current_sqrt_price: u128,
        current_tick_index: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        tick_spacing: u32,
        fee_rate: u64,
        protocol_fee_share: u64,
    }

    struct PositionOpened has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        tick_upper: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
    }

    struct PositionClosed has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        tick_upper: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
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
        current_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        exceeded: bool,
        sequence_number: u128,
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
        current_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        exceeded: bool,
        sequence_number: u128,
    }

    struct ProtocolFeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        destination: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        sequence_number: u128,
    }

    struct UserFeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        sequence_number: u128,
    }

    struct LiquidityProvided has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        liquidity: u128,
        beofre_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        lower_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        upper_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        sequence_number: u128,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        destination: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        liquidity: u128,
        beofre_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        lower_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        upper_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        sequence_number: u128,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{owner: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_flash_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg11: bool, arg12: u128) {
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
            sequence_number   : arg12,
        };
        0x2::event::emit<FlashSwap>(v0);
    }

    public(friend) fun emit_liquidity_provided_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg10: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg11: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg12: u128) {
        let v0 = LiquidityProvided{
            pool_id            : arg0,
            position_id        : arg1,
            sender             : arg2,
            coin_a_amount      : arg3,
            coin_b_amount      : arg4,
            liquidity          : arg5,
            beofre_liquidity   : arg6,
            after_liquidity    : arg7,
            current_sqrt_price : arg8,
            current_tick_index : arg9,
            lower_tick         : arg10,
            upper_tick         : arg11,
            sequence_number    : arg12,
        };
        0x2::event::emit<LiquidityProvided>(v0);
    }

    public(friend) fun emit_liquidity_removed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg11: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg12: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg13: u128) {
        let v0 = LiquidityRemoved{
            pool_id            : arg0,
            position_id        : arg1,
            sender             : arg2,
            destination        : arg3,
            coin_a_amount      : arg4,
            coin_b_amount      : arg5,
            liquidity          : arg6,
            beofre_liquidity   : arg7,
            after_liquidity    : arg8,
            current_sqrt_price : arg9,
            current_tick_index : arg10,
            lower_tick         : arg11,
            upper_tick         : arg12,
            sequence_number    : arg13,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public(friend) fun emit_pool_created_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128, arg4: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg5: u32, arg6: u64, arg7: u64) {
        let v0 = PoolCreated{
            id                 : arg0,
            coin_a             : arg1,
            coin_b             : arg2,
            current_sqrt_price : arg3,
            current_tick_index : arg4,
            tick_spacing       : arg5,
            fee_rate           : arg6,
            protocol_fee_share : arg7,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_position_close_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg4: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32) {
        let v0 = PositionClosed{
            sender      : arg2,
            pool_id     : arg0,
            position_id : arg1,
            lower_tick  : arg3,
            tick_upper  : arg4,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_open_event(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg4: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32) {
        let v0 = PositionOpened{
            sender      : arg0,
            pool_id     : arg1,
            position_id : arg2,
            lower_tick  : arg3,
            tick_upper  : arg4,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_protocol_fee_cap_transfer_event(arg0: address) {
        let v0 = ProtocolFeeCapTransferred{owner: arg0};
        0x2::event::emit<ProtocolFeeCapTransferred>(v0);
    }

    public(friend) fun emit_protocol_fee_collected(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = ProtocolFeeCollected{
            pool_id         : arg0,
            sender          : arg1,
            destination     : arg2,
            coin_a_amount   : arg3,
            coin_b_amount   : arg4,
            sequence_number : arg5,
        };
        0x2::event::emit<ProtocolFeeCollected>(v0);
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg11: bool, arg12: u128) {
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
            sequence_number   : arg12,
        };
        0x2::event::emit<AssetSwap>(v0);
    }

    public(friend) fun emit_user_fee_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = UserFeeCollected{
            pool_id         : arg0,
            position_id     : arg1,
            sender          : arg2,
            coin_a_amount   : arg3,
            coin_b_amount   : arg4,
            sequence_number : arg5,
        };
        0x2::event::emit<UserFeeCollected>(v0);
    }

    // decompiled from Move bytecode v6
}

