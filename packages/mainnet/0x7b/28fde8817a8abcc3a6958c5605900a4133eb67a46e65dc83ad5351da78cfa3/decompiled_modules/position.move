module 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        positions: 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32,
        tick_upper_index: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owned_a: u64,
        fee_owned_b: u64,
        points_owned: u128,
        points_growth_inside: u128,
        rewards: vector<PositionReward>,
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
        tick_lower_index: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32,
        tick_upper_index: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32,
        liquidity: u128,
        lock_until: u64,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u128,
        amount_owned: u64,
    }

    public fun is_empty(arg0: &PositionInfo) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionReward>(&arg0.rewards)) {
            let v2 = v0 && 0x1::vector::borrow<PositionReward>(&arg0.rewards, v1).amount_owned == 0;
            v0 = v2;
            v1 = v1 + 1;
        };
        arg0.liquidity == 0 && arg0.fee_owned_a == 0 && arg0.fee_owned_b == 0 && v0
    }

    public(friend) fun new(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            tick_spacing   : arg0,
            position_index : 0,
            positions      : 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::new<0x2::object::ID, PositionInfo>(arg1),
        }
    }

    fun borrow_mut_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        assert!(0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 606);
        let v0 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 606);
        v0
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 606);
        let v0 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 606);
        v0
    }

    public fun check_position_tick_range(arg0: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, arg1: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, arg2: u32) {
        assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::lt(arg0, arg1) && 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::gte(arg0, 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::tick_math::min_tick()) && 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::lte(arg1, 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::tick_math::max_tick()) && 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::mod(arg0, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::from(arg2)) == 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::zero() && 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::mod(arg1, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::from(arg2)) == 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::zero(), 605);
    }

    public(friend) fun close_position(arg0: &mut PositionManager, arg1: Position) {
        let v0 = 0x2::object::id<Position>(&arg1);
        let v1 = borrow_mut_position_info(arg0, v0);
        if (!is_empty(v1)) {
            abort 7
        };
        0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, v0);
        destroy(arg1);
    }

    public(friend) fun decrease_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: &0x2::clock::Clock) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        if (arg2 == 0) {
            return v0.liquidity
        };
        assert!(arg1.lock_until <= 0x2::clock::timestamp_ms(arg7), 611);
        update_fee_internal(v0, arg3, arg4);
        update_points_internal(v0, arg5);
        update_rewards_internal(v0, arg6);
        assert!(v0.liquidity >= arg2, 609);
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
            lock_until       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun fetch_positions(arg0: &PositionManager, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PositionInfo> {
        let v0 = 0x1::vector::empty<PositionInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::head<0x2::object::ID, PositionInfo>(&arg0.positions)
        } else {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, 0);
            assert!(0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, v2), 606);
            0x1::option::some<0x2::object::ID>(v2)
        };
        let v3 = v1;
        let v4 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v5 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_node<0x2::object::ID, PositionInfo>(&arg0.positions, *0x1::option::borrow<0x2::object::ID>(&v3));
            v3 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::next<0x2::object::ID, PositionInfo>(v5);
            0x1::vector::push_back<PositionInfo>(&mut v0, *0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_value<0x2::object::ID, PositionInfo>(v5));
            let v6 = v4 + 1;
            v4 = v6;
            if (v6 == arg2) {
                break
            };
        };
        v0
    }

    public(friend) fun get_lock_until(arg0: &Position) : u64 {
        arg0.lock_until
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: vector<u128>) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        update_fee_internal(v0, arg3, arg4);
        update_points_internal(v0, arg5);
        update_rewards_internal(v0, arg6);
        assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::add_check(v0.liquidity, arg2), 608);
        v0.liquidity = v0.liquidity + arg2;
        arg1.liquidity = v0.liquidity;
        v0.liquidity
    }

    public fun index(arg0: &Position) : u64 {
        arg0.index
    }

    public fun info_fee_growth_inside(arg0: &PositionInfo) : (u128, u128) {
        (arg0.fee_growth_inside_a, arg0.fee_growth_inside_b)
    }

    public fun info_fee_owned(arg0: &PositionInfo) : (u64, u64) {
        (arg0.fee_owned_a, arg0.fee_owned_b)
    }

    public fun info_liquidity(arg0: &PositionInfo) : u128 {
        arg0.liquidity
    }

    public fun info_points_growth_inside(arg0: &PositionInfo) : u128 {
        arg0.points_growth_inside
    }

    public fun info_points_owned(arg0: &PositionInfo) : u128 {
        arg0.points_owned
    }

    public fun info_position_id(arg0: &PositionInfo) : 0x2::object::ID {
        arg0.position_id
    }

    public fun info_rewards(arg0: &PositionInfo) : &vector<PositionReward> {
        &arg0.rewards
    }

    public fun info_tick_range(arg0: &PositionInfo) : (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.ferra.xyz/position?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra Labs"));
        let v4 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Position>(&v4, v0, v2, arg1);
        0x2::display::update_version<Position>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun inited_rewards_count(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        0x1::vector::length<PositionReward>(&0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1).rewards)
    }

    public fun is_position_exist(arg0: &PositionManager, arg1: 0x2::object::ID) : bool {
        0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun lock_position(arg0: &mut Position, arg1: u64) {
        arg0.lock_until = arg1;
    }

    public fun name(arg0: &Position) : 0x1::string::String {
        arg0.name
    }

    fun new_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Ferra LP | Pool");
        0x1::string::append(&mut v0, 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::utils::str(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::utils::str(arg1));
        v0
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, arg5: 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Position {
        check_position_tick_range(arg4, arg5, arg0.tick_spacing);
        let v0 = arg0.position_index + 1;
        let v1 = Position{
            id               : 0x2::object::new(arg7),
            pool             : arg1,
            index            : v0,
            coin_type_a      : 0x1::type_name::get<T0>(),
            coin_type_b      : 0x1::type_name::get<T1>(),
            name             : new_position_name(arg2, v0),
            description      : 0x1::string::utf8(b"Ferra Liquidity Position"),
            url              : arg3,
            tick_lower_index : arg4,
            tick_upper_index : arg5,
            liquidity        : 0,
            lock_until       : arg6,
        };
        let v2 = 0x2::object::id<Position>(&v1);
        let v3 = PositionInfo{
            position_id          : v2,
            liquidity            : 0,
            tick_lower_index     : arg4,
            tick_upper_index     : arg5,
            fee_growth_inside_a  : 0,
            fee_growth_inside_b  : 0,
            fee_owned_a          : 0,
            fee_owned_b          : 0,
            points_owned         : 0,
            points_growth_inside : 0,
            rewards              : 0x1::vector::empty<PositionReward>(),
        };
        0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, v2, v3);
        arg0.position_index = v0;
        v1
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool
    }

    public(friend) fun reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun reset_rewarder(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = 0x1::vector::borrow_mut<PositionReward>(&mut borrow_mut_position_info(arg0, arg1).rewards, arg2);
        v0.amount_owned = 0;
        v0.amount_owned
    }

    public fun reward_amount_owned(arg0: &PositionReward) : u64 {
        arg0.amount_owned
    }

    public fun reward_growth_inside(arg0: &PositionReward) : u128 {
        arg0.growth_inside
    }

    public(friend) fun rewards_amount_owned(arg0: &PositionManager, arg1: 0x2::object::ID) : vector<u64> {
        let v0 = info_rewards(borrow_position_info(arg0, arg1));
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<PositionReward>(v0)) {
            0x1::vector::push_back<u64>(&mut v2, reward_amount_owned(0x1::vector::borrow<PositionReward>(v0, v1)));
            v1 = v1 + 1;
        };
        v2
    }

    public fun set_display(arg0: &0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::config::checked_package_version(arg0);
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
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        0x1::vector::push_back<0x1::string::String>(v3, arg5);
        let v4 = 0x2::display::new_with_fields<Position>(arg1, v0, v2, arg6);
        0x2::display::update_version<Position>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v4, 0x2::tx_context::sender(arg6));
    }

    public fun tick_range(arg0: &Position) : (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    public(friend) fun update_and_reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun update_and_reset_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u128>, arg3: u64) : u64 {
        assert!(0x1::vector::length<u128>(&arg2) > arg3, 610);
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_rewards_internal(v0, arg2);
        let v1 = 0x1::vector::borrow_mut<PositionReward>(&mut v0.rewards, arg3);
        v1.amount_owned = 0;
        v1.amount_owned
    }

    public(friend) fun update_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        info_fee_owned(v0)
    }

    fun update_fee_internal(arg0: &mut PositionInfo, arg1: u128, arg2: u128) {
        let v0 = (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::full_math_u128::mul_shr(arg0.liquidity, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::wrapping_sub(arg1, arg0.fee_growth_inside_a), 64) as u64);
        let v1 = (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::full_math_u128::mul_shr(arg0.liquidity, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_b), 64) as u64);
        assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u64::add_check(arg0.fee_owned_a, v0), 601);
        assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u64::add_check(arg0.fee_owned_b, v1), 601);
        arg0.fee_owned_a = arg0.fee_owned_a + v0;
        arg0.fee_owned_b = arg0.fee_owned_b + v1;
        arg0.fee_growth_inside_a = arg1;
        arg0.fee_growth_inside_b = arg2;
    }

    public(friend) fun update_points(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_points_internal(v0, arg2);
        v0.points_owned
    }

    fun update_points_internal(arg0: &mut PositionInfo, arg1: u128) {
        let v0 = 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::full_math_u128::mul_shr(arg0.liquidity, 0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::wrapping_sub(arg1, arg0.points_growth_inside), 64);
        assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::add_check(arg0.points_owned, v0), 603);
        arg0.points_owned = arg0.points_owned + v0;
        arg0.points_growth_inside = arg1;
    }

    public(friend) fun update_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u128>) : vector<u64> {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_rewards_internal(v0, arg2);
        let v1 = info_rewards(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        while (v2 < 0x1::vector::length<PositionReward>(v1)) {
            0x1::vector::push_back<u64>(&mut v3, reward_amount_owned(0x1::vector::borrow<PositionReward>(v1, v2)));
            v2 = v2 + 1;
        };
        v3
    }

    fun update_rewards_internal(arg0: &mut PositionInfo, arg1: vector<u128>) {
        let v0 = 0x1::vector::length<u128>(&arg1);
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                let v2 = *0x1::vector::borrow<u128>(&arg1, v1);
                if (0x1::vector::length<PositionReward>(&arg0.rewards) > v1) {
                    let v3 = 0x1::vector::borrow_mut<PositionReward>(&mut arg0.rewards, v1);
                    let v4 = (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::full_math_u128::mul_shr(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u128::wrapping_sub(v2, v3.growth_inside), arg0.liquidity, 64) as u64);
                    assert!(0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::math_u64::add_check(v3.amount_owned, v4), 602);
                    v3.growth_inside = v2;
                    v3.amount_owned = v3.amount_owned + v4;
                } else {
                    let v5 = PositionReward{
                        growth_inside : v2,
                        amount_owned  : (0x5f7a7744be085d6f92587f4a0aa5d6ff85a6c804196c5a1f1bb34b0cb2db6c54::full_math_u128::mul_shr(v2, arg0.liquidity, 64) as u64),
                    };
                    0x1::vector::push_back<PositionReward>(&mut arg0.rewards, v5);
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

