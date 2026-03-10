module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        sqrt_price: u128,
        liquidity: u128,
        tick_index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        coin_x_decimals: u8,
        coin_x_supply: u64,
        tick_spacing: u32,
        lp_fee: u64,
        is_hop_launch: bool,
        coin_creator_address: 0x1::option::Option<address>,
        max_liquidity_per_tick: u128,
        fee_growth_global_x: u128,
        fee_growth_global_y: u128,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        creator_fees: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
        buybacks_amount_y: u64,
        buybacks_amount_x_burned: u64,
        ticks: 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>,
        tick_bitmap: 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u256>,
    }

    public(friend) fun add_buybacks_amount_x_burned<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.buybacks_amount_x_burned = arg0.buybacks_amount_x_burned + arg1;
    }

    public(friend) fun add_buybacks_amount_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.buybacks_amount_y = arg0.buybacks_amount_y + arg1;
    }

    public(friend) fun add_creator_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.creator_fees, arg1);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u128) {
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::tick_spacing_to_max_liquidity_per_tick(arg0.tick_spacing);
        if (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::update(&mut arg0.ticks, arg1, arg0.tick_index, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(arg5), arg0.fee_growth_global_x, arg0.fee_growth_global_y, false, v0)) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, arg1, arg0.tick_spacing);
        };
        if (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::update(&mut arg0.ticks, arg2, arg0.tick_index, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(arg5), arg0.fee_growth_global_x, arg0.fee_growth_global_y, true, v0)) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, arg2, arg0.tick_spacing);
        };
        let v1 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::get_tick(&arg0.ticks, arg1);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_tick_update(id<T0, T1>(arg0), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::index(v1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::liquidity_net(v1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::liquidity_gross(v1));
        let v2 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::get_tick(&arg0.ticks, arg2);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_tick_update(id<T0, T1>(arg0), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::index(v2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::liquidity_net(v2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::liquidity_gross(v2));
        if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(arg0.tick_index, arg1) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg0.tick_index, arg2)) {
            arg0.liquidity = arg0.liquidity + arg5;
        };
        0x2::balance::join<T0>(&mut arg0.reserve_x, arg3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, arg4);
    }

    public(friend) fun add_protocol_fee_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.protocol_fees_x, arg1);
    }

    public(friend) fun add_protocol_fee_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.protocol_fees_y, arg1);
    }

    public fun borrow_tick_bitmap<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u256> {
        &arg0.tick_bitmap
    }

    public fun borrow_tick_table<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick> {
        &arg0.ticks
    }

    public(friend) fun borrow_tick_table_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick> {
        &mut arg0.ticks
    }

    public fun buybacks_amount_x_burned<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.buybacks_amount_x_burned
    }

    public fun buybacks_amount_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.buybacks_amount_y
    }

    public fun coin_creator<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<address> {
        arg0.coin_creator_address
    }

    public(friend) fun create<T0, T1>(arg0: u128, arg1: u32, arg2: u64, arg3: bool, arg4: 0x1::option::Option<address>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id                       : 0x2::object::new(arg7),
            sqrt_price               : arg0,
            liquidity                : 0,
            tick_index               : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_tick_at_sqrt_price(arg0),
            coin_x_decimals          : arg5,
            coin_x_supply            : arg6,
            tick_spacing             : arg1,
            lp_fee                   : arg2,
            is_hop_launch            : arg3,
            coin_creator_address     : arg4,
            max_liquidity_per_tick   : 0,
            fee_growth_global_x      : 0,
            fee_growth_global_y      : 0,
            reserve_x                : 0x2::balance::zero<T0>(),
            reserve_y                : 0x2::balance::zero<T1>(),
            creator_fees             : 0x2::balance::zero<T1>(),
            protocol_fees_x          : 0x2::balance::zero<T0>(),
            protocol_fees_y          : 0x2::balance::zero<T1>(),
            buybacks_amount_y        : 0,
            buybacks_amount_x_burned : 0,
            ticks                    : 0x2::table::new<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(arg7),
            tick_bitmap              : 0x2::table::new<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u256>(arg7),
        }
    }

    public(friend) fun decrease_reserves<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.reserve_x, arg1), 0x2::balance::split<T1>(&mut arg0.reserve_y, arg2))
    }

    public fun fee_growth_global_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_x
    }

    public fun fee_growth_global_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_y
    }

    public fun id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun increase_reserves<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.reserve_x, arg1);
        0x2::balance::join<T1>(&mut arg0.reserve_y, arg2);
    }

    public fun is_hop_launch<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_hop_launch
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun lp_fee<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_fee
    }

    public fun market_cap_sui<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = arg0.sqrt_price;
        let v1 = if (arg0.coin_x_decimals >= 9) {
            (((v0 as u256) * (v0 as u256) / 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q128()) as u128) * 0x1::u128::pow(10, arg0.coin_x_decimals - 9)
        } else {
            (((v0 as u256) * (v0 as u256) / 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q128()) as u128) / 0x1::u128::pow(10, 9 - arg0.coin_x_decimals)
        };
        ((v1 * (arg0.coin_x_supply as u128)) as u64)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: u128, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::tick_spacing_to_max_liquidity_per_tick(arg0.tick_spacing);
        if (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::update(&mut arg0.ticks, arg1, arg0.tick_index, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg_from(arg3), arg0.fee_growth_global_x, arg0.fee_growth_global_y, false, v0)) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, arg1, arg0.tick_spacing);
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::clear(&mut arg0.ticks, arg1);
        };
        if (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::update(&mut arg0.ticks, arg2, arg0.tick_index, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg_from(arg3), arg0.fee_growth_global_x, arg0.fee_growth_global_y, true, v0)) {
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, arg2, arg0.tick_spacing);
            0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::clear(&mut arg0.ticks, arg2);
        };
        if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(arg0.tick_index, arg1) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg0.tick_index, arg2)) {
            arg0.liquidity = arg0.liquidity - arg3;
        };
        (0x2::balance::split<T0>(&mut arg0.reserve_x, arg4), 0x2::balance::split<T1>(&mut arg0.reserve_y, arg5))
    }

    public fun reserve_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_x)
    }

    public fun reserve_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserve_y)
    }

    public(friend) fun set_fee_growth_global_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.fee_growth_global_x = arg1;
    }

    public(friend) fun set_fee_growth_global_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.fee_growth_global_y = arg1;
    }

    public(friend) fun set_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.liquidity = arg1;
    }

    public(friend) fun set_sqrt_price<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.sqrt_price = arg1;
    }

    public(friend) fun set_tick_index<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) {
        arg0.tick_index = arg1;
    }

    public fun sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.sqrt_price
    }

    public fun tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.tick_index
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public(friend) fun withdraw_creator_fees<T0, T1>(arg0: &mut Pool<T0, T1>) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees)
    }

    public(friend) fun withdraw_protocol_fee_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.protocol_fees_x, arg1)
    }

    public(friend) fun withdraw_protocol_fee_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.protocol_fees_y, arg1)
    }

    // decompiled from Move bytecode v6
}

