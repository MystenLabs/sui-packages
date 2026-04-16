module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position {
    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        min_tick_range: u32,
        positions: 0x2::table::Table<0x2::object::ID, PositionInfo>,
    }

    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        index: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        tick_lower_index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        tick_upper_index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        liquidity: u128,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        tick_upper_index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        fee_growth_inside_a: u256,
        fee_growth_inside_b: u256,
        fee_owned_a: u64,
        fee_owned_b: u64,
        rewards: vector<PositionReward>,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u256,
        amount_owned: u64,
    }

    public(friend) fun new(arg0: u32, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : PositionManager {
        let (v0, v1) = full_range_tick_range(arg0);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::as_u32(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::sub(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(v1), 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(v0))) >= arg1, 13838436777207267365);
        assert!(arg1 % arg0 == 0, 13838436781502234661);
        PositionManager{
            tick_spacing   : arg0,
            position_index : 0,
            min_tick_range : arg1,
            positions      : 0x2::table::new<0x2::object::ID, PositionInfo>(arg2),
        }
    }

    public fun contains(arg0: &PositionManager, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    fun borrow_mut_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13837032374440296473);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 13837032383030231065);
        v0
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x2::table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 13837031055885336601);
        let v0 = 0x2::table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 13837031064475271193);
        v0
    }

    public fun calculate_fee_delta(arg0: u256, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_shr(((arg0 >> 128) as u128), arg1, 0);
        let v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_shr(((arg0 & 340282366920938463463374607431768211455) as u128), arg1, 128);
        assert!(v0 + v1 <= 340282366920938463463374607431768211455, 13838721615143501863);
        v0 + v1
    }

    public fun check_position_tick_range(arg0: &PositionManager, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) {
        let v0 = if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg1, arg2)) {
            if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::gte(arg1, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::min_tick())) {
                if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lte(arg2, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::max_tick())) {
                    if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::mod(arg1, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from(arg0.tick_spacing)) == 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::zero()) {
                        0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::mod(arg2, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from(arg0.tick_spacing)) == 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::zero()
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13836468277730344981);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::as_u32(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::sub(arg2, arg1)) >= arg0.min_tick_range, 13836749765592088599);
    }

    public fun close_position(arg0: &mut PositionManager, arg1: Position) {
        let v0 = 0x2::object::id<Position>(&arg1);
        let v1 = borrow_mut_position_info(arg0, v0);
        if (!is_empty(v1)) {
            abort 13837029793165082651
        };
        0x2::table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, v0);
        destroy(arg1);
    }

    public fun decrease_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u256, arg4: u256, arg5: vector<u256>) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        if (arg2 == 0) {
            return v0.liquidity
        };
        update_fee_internal(v0, arg3, arg4);
        update_rewards_internal(v0, arg5);
        assert!(v0.liquidity >= arg2, 13837593099601051679);
        v0.liquidity = v0.liquidity - arg2;
        arg1.liquidity = v0.liquidity;
        v0.liquidity
    }

    public fun description(arg0: &Position) : 0x1::string::String {
        arg0.description
    }

    fun destroy(arg0: Position) {
        let Position {
            id               : v0,
            pool             : _,
            index            : _,
            coin_type_a      : _,
            coin_type_b      : _,
            name             : _,
            description      : _,
            url              : _,
            tick_lower_index : _,
            tick_upper_index : _,
            liquidity        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun full_range_tick_range(arg0: u32) : (u32, u32) {
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(443636 % arg0);
        (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::as_u32(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::add(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::min_tick(), v0)), 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::as_u32(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::sub(0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::max_tick(), v0)))
    }

    public fun increase_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u256, arg4: u256, arg5: vector<u256>) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        update_fee_internal(v0, arg3, arg4);
        update_rewards_internal(v0, arg5);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::add_check(v0.liquidity, arg2), 13837311439940616221);
        v0.liquidity = v0.liquidity + arg2;
        arg1.liquidity = v0.liquidity;
        v0.liquidity
    }

    public fun index(arg0: &Position) : u64 {
        arg0.index
    }

    public fun info_fee_growth_inside(arg0: &PositionInfo) : (u256, u256) {
        (arg0.fee_growth_inside_a, arg0.fee_growth_inside_b)
    }

    public fun info_fee_owned(arg0: &PositionInfo) : (u64, u64) {
        (arg0.fee_owned_a, arg0.fee_owned_b)
    }

    public fun info_liquidity(arg0: &PositionInfo) : u128 {
        arg0.liquidity
    }

    public fun info_position_id(arg0: &PositionInfo) : 0x2::object::ID {
        arg0.position_id
    }

    public fun info_rewards(arg0: &PositionInfo) : &vector<PositionReward> {
        &arg0.rewards
    }

    public fun info_tick_range(arg0: &PositionInfo) : (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        update_display_internal(&v0, 0x1::string::utf8(b"Cetus Liquidity Position"), 0x1::string::utf8(b"https://app.cetus.zone/position?chain=sui&id={id}"), 0x1::string::utf8(b"https://cetus.zone"), 0x1::string::utf8(b"Cetus"), arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun inited_rewards_count(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        0x1::vector::length<PositionReward>(&borrow_position_info(arg0, arg1).rewards)
    }

    public fun is_empty(arg0: &PositionInfo) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionReward>(&arg0.rewards)) {
            let v2 = v0 && 0x1::vector::borrow<PositionReward>(&arg0.rewards, v1).amount_owned == 0;
            v0 = v2;
            v1 = v1 + 1;
        };
        if (arg0.liquidity == 0) {
            if (arg0.fee_owned_a == 0) {
                if (arg0.fee_owned_b == 0) {
                    v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun name(arg0: &Position) : 0x1::string::String {
        arg0.name
    }

    fun new_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Cetus LP | Pool");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg1));
        v0
    }

    public fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg5: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg6: &mut 0x2::tx_context::TxContext) : Position {
        check_position_tick_range(arg0, arg4, arg5);
        let v0 = arg0.position_index + 1;
        let v1 = Position{
            id               : 0x2::object::new(arg6),
            pool             : arg1,
            index            : v0,
            coin_type_a      : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b      : 0x1::type_name::with_defining_ids<T1>(),
            name             : new_position_name(arg2, v0),
            description      : 0x1::string::utf8(b"Cetus Liquidity Position"),
            url              : arg3,
            tick_lower_index : arg4,
            tick_upper_index : arg5,
            liquidity        : 0,
        };
        let v2 = 0x2::object::id<Position>(&v1);
        let v3 = PositionInfo{
            position_id         : v2,
            liquidity           : 0,
            tick_lower_index    : arg4,
            tick_upper_index    : arg5,
            fee_growth_inside_a : 0,
            fee_growth_inside_b : 0,
            fee_owned_a         : 0,
            fee_owned_b         : 0,
            rewards             : 0x1::vector::empty<PositionReward>(),
        };
        0x2::table::add<0x2::object::ID, PositionInfo>(&mut arg0.positions, v2, v3);
        arg0.position_index = v0;
        v1
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool
    }

    public fun reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public fun reset_reward(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = 0x1::vector::borrow_mut<PositionReward>(&mut borrow_mut_position_info(arg0, arg1).rewards, arg2);
        v0.amount_owned = 0;
        v0.amount_owned
    }

    public fun reward_amount_owned(arg0: &PositionReward) : u64 {
        arg0.amount_owned
    }

    public fun reward_growth_inside(arg0: &PositionReward) : u256 {
        arg0.growth_inside
    }

    public fun rewards_amount_owned(arg0: &PositionManager, arg1: 0x2::object::ID) : vector<u64> {
        let v0 = info_rewards(borrow_position_info(arg0, arg1));
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<PositionReward>(v0)) {
            let v3 = *0x1::vector::borrow<PositionReward>(v0, v1);
            0x1::vector::push_back<u64>(&mut v2, reward_amount_owned(&v3));
            v1 = v1 + 1;
        };
        v2
    }

    public fun set_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg5);
        assert!(0x2::package::from_module<Position>(arg0), 13838155160496504867);
        update_display_internal(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun tick_range(arg0: &Position) : (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    public fun update_and_reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u256, arg3: u256) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public fun update_and_reset_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u256>, arg3: u64) : u64 {
        assert!(0x1::vector::length<u256>(&arg2) > arg3, 13837875102858870817);
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_rewards_internal(v0, arg2);
        let v1 = 0x1::vector::borrow_mut<PositionReward>(&mut v0.rewards, arg3);
        v1.amount_owned = 0;
        v1.amount_owned
    }

    fun update_display_internal(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        let v4 = 0x2::display::new_with_fields<Position>(arg0, v0, v2, arg5);
        0x2::display::update_version<Position>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v4, 0x2::tx_context::sender(arg5));
    }

    public fun update_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u256, arg3: u256) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        info_fee_owned(v0)
    }

    fun update_fee_internal(arg0: &mut PositionInfo, arg1: u256, arg2: u256) {
        let v0 = calculate_fee_delta(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg1, arg0.fee_growth_inside_a), arg0.liquidity);
        assert!(v0 <= 18446744073709551615, 13835343296946110479);
        let v1 = (v0 as u64);
        let v2 = calculate_fee_delta(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(arg2, arg0.fee_growth_inside_b), arg0.liquidity);
        assert!(v2 <= 18446744073709551615, 13835343331305848847);
        let v3 = (v2 as u64);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.fee_owned_a, v1), 13835343344190750735);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.fee_owned_b, v3), 13835343348485718031);
        arg0.fee_owned_a = arg0.fee_owned_a + v1;
        arg0.fee_owned_b = arg0.fee_owned_b + v3;
        arg0.fee_growth_inside_a = arg1;
        arg0.fee_growth_inside_b = arg2;
    }

    public fun update_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u256>) : vector<u64> {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_rewards_internal(v0, arg2);
        let v1 = info_rewards(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        while (v2 < 0x1::vector::length<PositionReward>(v1)) {
            let v4 = *0x1::vector::borrow<PositionReward>(v1, v2);
            0x1::vector::push_back<u64>(&mut v3, reward_amount_owned(&v4));
            v2 = v2 + 1;
        };
        v3
    }

    fun update_rewards_internal(arg0: &mut PositionInfo, arg1: vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg1);
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                let v2 = *0x1::vector::borrow<u256>(&arg1, v1);
                if (0x1::vector::length<PositionReward>(&arg0.rewards) > v1) {
                    let v3 = 0x1::vector::borrow_mut<PositionReward>(&mut arg0.rewards, v1);
                    let v4 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_shr(((0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_sub(v2, v3.growth_inside) >> 64) as u128), arg0.liquidity, 64);
                    assert!(v4 <= 18446744073709551615, 13835624539994718225);
                    let v5 = (v4 as u64);
                    assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(v3.amount_owned, v5), 13835624561469554705);
                    v3.growth_inside = v2;
                    v3.amount_owned = v3.amount_owned + v5;
                } else {
                    let v6 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u128::mul_shr(((v2 >> 64) as u128), arg0.liquidity, 64);
                    assert!(v6 <= 18446744073709551615, 13835624613009162257);
                    let v7 = PositionReward{
                        growth_inside : v2,
                        amount_owned  : (v6 as u64),
                    };
                    0x1::vector::push_back<PositionReward>(&mut arg0.rewards, v7);
                };
                v1 = v1 + 1;
            };
        };
    }

    public fun url(arg0: &Position) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

