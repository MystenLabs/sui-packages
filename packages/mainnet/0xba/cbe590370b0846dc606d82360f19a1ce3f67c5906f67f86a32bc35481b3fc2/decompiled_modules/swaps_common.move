module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common {
    struct PositionInfo has copy, drop, store {
        lower_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        input_sui: u64,
        input_usdc: u64,
        input_liquidity: u128,
    }

    struct OurPositionClosed has copy, drop {
        pool: 0x1::string::String,
        input_sui: u64,
        input_usdc: u64,
        output_sui: u64,
        output_usdc: u64,
        fee_sui: u64,
        fee_usdc: u64,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct OpenPoolPositions has store {
        cetus_low_fee_position_info: PositionInfo,
        cetus_low_fee_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        cetus_high_fee_position_info: PositionInfo,
        cetus_high_fee_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        mmt_position_info: PositionInfo,
        mmt_position: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>,
    }

    public(friend) fun bluefin_pool_id() : u64 {
        4
    }

    public(friend) fun cetus_high_fee_pool_id() : u64 {
        1
    }

    public(friend) fun cetus_high_fee_position(arg0: &mut OpenPoolPositions) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.cetus_high_fee_position
    }

    public(friend) fun cetus_high_fee_position_info(arg0: &mut OpenPoolPositions) : &mut PositionInfo {
        &mut arg0.cetus_high_fee_position_info
    }

    public(friend) fun cetus_low_fee_pool_id() : u64 {
        0
    }

    public(friend) fun cetus_low_fee_position(arg0: &mut OpenPoolPositions) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.cetus_low_fee_position
    }

    public(friend) fun cetus_low_fee_position_info(arg0: &mut OpenPoolPositions) : &mut PositionInfo {
        &mut arg0.cetus_low_fee_position_info
    }

    public(friend) fun decrease_sui_to_usdc_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1001000000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1031622776;
        };
        (v1 as u128)
    }

    public(friend) fun decrease_usdc_to_sui_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1001000000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1031622776;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun emit_our_position_closed(arg0: 0x1::string::String, arg1: &PositionInfo, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock) {
        let v0 = OurPositionClosed{
            pool         : arg0,
            input_sui    : arg1.input_sui,
            input_usdc   : arg1.input_usdc,
            output_sui   : arg2,
            output_usdc  : arg3,
            fee_sui      : arg4,
            fee_usdc     : arg5,
            position_id  : arg6,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<OurPositionClosed>(v0);
    }

    public(friend) fun empty_position_info() : PositionInfo {
        PositionInfo{
            lower_tick_index : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0),
            upper_tick_index : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0),
            input_sui        : 0,
            input_usdc       : 0,
            input_liquidity  : 0,
        }
    }

    public(friend) fun get_swap_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    public(friend) fun get_total_balance_in_positions(arg0: &OpenPoolPositions) : (u64, u64) {
        (0 + arg0.cetus_low_fee_position_info.input_usdc + arg0.cetus_high_fee_position_info.input_usdc + arg0.mmt_position_info.input_usdc, 0 + arg0.cetus_low_fee_position_info.input_sui + arg0.cetus_high_fee_position_info.input_sui + arg0.mmt_position_info.input_sui)
    }

    public(friend) fun increase_sui_to_usdc_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1001000000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1031622776;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun increase_usdc_to_sui_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1001000000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1031622776;
        };
        (v1 as u128)
    }

    public(friend) fun magma_pool_id() : u64 {
        5
    }

    public(friend) fun mmt_pool_id() : u64 {
        2
    }

    public(friend) fun mmt_position(arg0: &mut OpenPoolPositions) : &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position> {
        &mut arg0.mmt_position
    }

    public(friend) fun mmt_position_info(arg0: &mut OpenPoolPositions) : &mut PositionInfo {
        &mut arg0.mmt_position_info
    }

    public(friend) fun new_open_pool_positions() : OpenPoolPositions {
        OpenPoolPositions{
            cetus_low_fee_position_info  : empty_position_info(),
            cetus_low_fee_position       : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            cetus_high_fee_position_info : empty_position_info(),
            cetus_high_fee_position      : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            mmt_position_info            : empty_position_info(),
            mmt_position                 : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(),
        }
    }

    public(friend) fun new_position_info(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64, arg3: u64, arg4: u128) : PositionInfo {
        PositionInfo{
            lower_tick_index : arg0,
            upper_tick_index : arg1,
            input_sui        : arg2,
            input_usdc       : arg3,
            input_liquidity  : arg4,
        }
    }

    public(friend) fun position_info_input_liquidity(arg0: &PositionInfo) : u128 {
        arg0.input_liquidity
    }

    public(friend) fun position_info_input_sui(arg0: &PositionInfo) : u64 {
        arg0.input_sui
    }

    public(friend) fun position_info_input_usdc(arg0: &PositionInfo) : u64 {
        arg0.input_usdc
    }

    public(friend) fun position_info_lower_tick_index(arg0: &PositionInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.lower_tick_index
    }

    public(friend) fun position_info_upper_tick_index(arg0: &PositionInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.upper_tick_index
    }

    public fun take_cetus_high_fee_position(arg0: &mut OpenPoolPositions) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        arg0.cetus_high_fee_position_info = empty_position_info();
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_high_fee_position)
    }

    public fun take_cetus_low_fee_position(arg0: &mut OpenPoolPositions) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        arg0.cetus_low_fee_position_info = empty_position_info();
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_low_fee_position)
    }

    public fun take_mmt_position(arg0: &mut OpenPoolPositions) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        arg0.mmt_position_info = empty_position_info();
        0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.mmt_position)
    }

    public(friend) fun turbos_pool_id() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

