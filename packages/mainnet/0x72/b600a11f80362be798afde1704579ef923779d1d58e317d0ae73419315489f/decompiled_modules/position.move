module 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::position {
    struct StakePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        staked: bool,
    }

    struct UpdateFullsailDistributionEvent has copy, drop {
        position_id: 0x2::object::ID,
        fullsail_distribution_owned: u64,
        fullsail_distribution_growth_inside: u128,
    }

    struct UpdatePointsEvent has copy, drop {
        position_id: 0x2::object::ID,
        points_owned: u128,
        points_growth_inside: u128,
    }

    struct CreateRewardEvent has copy, drop {
        position_id: 0x2::object::ID,
        reward_index: u64,
        reward_growth_inside: u128,
        reward_amount_owned: u64,
    }

    struct UpdateRewardEvent has copy, drop {
        position_id: 0x2::object::ID,
        reward_index: u64,
        reward_growth_inside: u128,
        reward_amount_owned: u64,
    }

    struct UpdateFeeEvent has copy, drop {
        position_id: 0x2::object::ID,
        fee_owned_a: u64,
        fee_owned_b: u64,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
    }

    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        positions: 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
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
        tick_lower_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        tick_upper_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        liquidity: u128,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        tick_upper_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owned_a: u64,
        fee_owned_b: u64,
        points_owned: u128,
        points_growth_inside: u128,
        rewards: vector<PositionReward>,
        fullsail_distribution_staked: bool,
        fullsail_distribution_growth_inside: u128,
        fullsail_distribution_owned: u64,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u128,
        amount_owned: u64,
    }

    public(friend) fun new(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            tick_spacing   : arg0,
            position_index : 0,
            positions      : 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::new<0x2::object::ID, PositionInfo>(arg1),
        }
    }

    fun borrow_mut_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 923070870234869348);
        let v0 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 923070870234869348);
        v0
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 923070870234869348);
        let v0 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 923070870234869348);
        v0
    }

    public fun check_position_tick_range(arg0: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg1: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg2: u32) {
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::lt(arg0, arg1) && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gte(arg0, 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::tick_math::min_tick()) && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::lte(arg1, 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::tick_math::max_tick()) && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::mod(arg0, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from(arg2)) == 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::zero() && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::mod(arg1, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from(arg2)) == 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::zero(), 923846923867923746);
    }

    public(friend) fun close_position(arg0: &mut PositionManager, arg1: Position) {
        let v0 = 0x2::object::id<Position>(&arg1);
        assert!(is_empty(borrow_position_info(arg0, v0)), 93468306382406723);
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, v0);
        destroy(arg1);
    }

    public(friend) fun decrease_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        if (arg2 == 0) {
            return v0.liquidity
        };
        update_fee_internal(v0, arg3, arg4);
        update_points_internal(v0, arg5);
        update_rewards_internal(v0, arg6);
        update_fullsail_distribution_internal(v0, arg7);
        assert!(v0.liquidity >= arg2, 923879283460923860);
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

    public fun fetch_positions(arg0: &PositionManager, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : vector<PositionInfo> {
        let v0 = 0x1::vector::empty<PositionInfo>();
        let v1 = if (0x1::option::is_none<0x2::object::ID>(&arg1)) {
            0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::head<0x2::object::ID, PositionInfo>(&arg0.positions)
        } else {
            let v2 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            if (!0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, v2)) {
                return v0
            };
            0x1::option::some<0x2::object::ID>(v2)
        };
        let v3 = v1;
        let v4 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v3) && v4 < arg2) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            if (!0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, v5)) {
                break
            };
            let v6 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_node<0x2::object::ID, PositionInfo>(&arg0.positions, v5);
            0x1::vector::push_back<PositionInfo>(&mut v0, *0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_value<0x2::object::ID, PositionInfo>(v6));
            v3 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::next<0x2::object::ID, PositionInfo>(v6);
            v4 = v4 + 1;
        };
        v0
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        update_fee_internal(v0, arg3, arg4);
        update_points_internal(v0, arg5);
        update_rewards_internal(v0, arg6);
        update_fullsail_distribution_internal(v0, arg7);
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::add_check(v0.liquidity, arg2), 923876923470938023);
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

    public fun info_fullsail_distribution_owned(arg0: &PositionInfo) : u64 {
        arg0.fullsail_distribution_owned
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

    public fun info_tick_range(arg0: &PositionInfo) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v1 = update_display(&v0, 0x1::string::utf8(b"{name}"), 0x1::string::utf8(b"{coin_type_a}"), 0x1::string::utf8(b"{coin_type_b}"), 0x1::string::utf8(b"https://app.fullsailfinance.io/position?chain=sui&id={id}"), 0x1::string::utf8(b"{url}"), 0x1::string::utf8(b"{description}"), 0x1::string::utf8(b"https://fullsailfinance.io"), 0x1::string::utf8(b"FULLSAIL"), arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun inited_rewards_count(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        0x1::vector::length<PositionReward>(&0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1).rewards)
    }

    public fun is_empty(arg0: &PositionInfo) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionReward>(&arg0.rewards)) {
            let v2 = 0x1::vector::borrow<PositionReward>(&arg0.rewards, v1).amount_owned == 0;
            v0 = v2;
            if (!v2) {
                break
            };
            v1 = v1 + 1;
        };
        arg0.liquidity == 0 && arg0.fee_owned_a == 0 && arg0.fee_owned_b == 0 && v0
    }

    public fun is_position_exist(arg0: &PositionManager, arg1: 0x2::object::ID) : bool {
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public fun is_staked(arg0: &PositionInfo) : bool {
        arg0.fullsail_distribution_staked
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun mark_position_staked(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        assert!(v0.fullsail_distribution_staked != arg2, 92372398045693466);
        v0.fullsail_distribution_staked = arg2;
        let v1 = StakePositionEvent{
            position_id : v0.position_id,
            staked      : arg2,
        };
        0x2::event::emit<StakePositionEvent>(v1);
    }

    public fun name(arg0: &Position) : 0x1::string::String {
        arg0.name
    }

    fun new_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Fullsail position:");
        0x1::string::append(&mut v0, 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::utils::str(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::utils::str(arg1));
        v0
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg5: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg6: &mut 0x2::tx_context::TxContext) : Position {
        check_position_tick_range(arg4, arg5, arg0.tick_spacing);
        let v0 = arg0.position_index + 1;
        let v1 = Position{
            id               : 0x2::object::new(arg6),
            pool             : arg1,
            index            : v0,
            coin_type_a      : 0x1::type_name::get<T0>(),
            coin_type_b      : 0x1::type_name::get<T1>(),
            name             : new_position_name(arg2, v0),
            description      : 0x1::string::utf8(b"Fullsail Liquidity Position"),
            url              : arg3,
            tick_lower_index : arg4,
            tick_upper_index : arg5,
            liquidity        : 0,
        };
        let v2 = 0x2::object::id<Position>(&v1);
        let v3 = PositionInfo{
            position_id                         : v2,
            liquidity                           : 0,
            tick_lower_index                    : arg4,
            tick_upper_index                    : arg5,
            fee_growth_inside_a                 : 0,
            fee_growth_inside_b                 : 0,
            fee_owned_a                         : 0,
            fee_owned_b                         : 0,
            points_owned                        : 0,
            points_growth_inside                : 0,
            rewards                             : 0x1::vector::empty<PositionReward>(),
            fullsail_distribution_staked        : false,
            fullsail_distribution_growth_inside : 0,
            fullsail_distribution_owned         : 0,
        };
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, v2, v3);
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

    public fun set_description(arg0: &mut Position, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public fun set_display(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Position>(arg1), 985489328434574338);
        0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::checked_package_version(arg0);
        let v0 = update_display(arg1, 0x1::string::utf8(b"{name}"), 0x1::string::utf8(b"{coin_type_a}"), 0x1::string::utf8(b"{coin_type_b}"), arg3, 0x1::string::utf8(b"{url}"), arg2, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun set_display_v2(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Position>(arg1), 985489328434574338);
        0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::checked_package_version(arg0);
        let v0 = update_display(arg1, 0x1::string::utf8(b"{name}"), 0x1::string::utf8(b"{coin_type_a}"), 0x1::string::utf8(b"{coin_type_b}"), arg3, arg4, arg2, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun tick_range(arg0: &Position) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    public(friend) fun update_and_reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun update_and_reset_fullsail_distribution(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u64 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fullsail_distribution_internal(v0, arg2);
        v0.fullsail_distribution_owned = 0;
        v0.fullsail_distribution_owned
    }

    public(friend) fun update_and_reset_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u128>, arg3: u64) : u64 {
        assert!(0x1::vector::length<u128>(&arg2) > arg3, 932047692306234633);
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_rewards_internal(v0, arg2);
        let v1 = 0x1::vector::borrow_mut<PositionReward>(&mut v0.rewards, arg3);
        v1.amount_owned = 0;
        v1.amount_owned
    }

    fun update_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Position> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg1);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg5);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg6);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg7);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg8);
        let v2 = 0x2::display::new_with_fields<Position>(arg0, v0, v1, arg9);
        0x2::display::update_version<Position>(&mut v2);
        v2
    }

    public(friend) fun update_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        info_fee_owned(v0)
    }

    fun update_fee_internal(arg0: &mut PositionInfo, arg1: u128, arg2: u128) {
        let v0 = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(arg0.liquidity, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(arg1, arg0.fee_growth_inside_a), 64) as u64);
        let v1 = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(arg0.liquidity, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_b), 64) as u64);
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u64::add_check(arg0.fee_owned_a, v0), 923065912304623497);
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u64::add_check(arg0.fee_owned_b, v1), 923065912304623497);
        arg0.fee_owned_a = arg0.fee_owned_a + v0;
        arg0.fee_owned_b = arg0.fee_owned_b + v1;
        arg0.fee_growth_inside_a = arg1;
        arg0.fee_growth_inside_b = arg2;
        let v2 = UpdateFeeEvent{
            position_id         : arg0.position_id,
            fee_owned_a         : arg0.fee_owned_a,
            fee_owned_b         : arg0.fee_owned_b,
            fee_growth_inside_a : arg0.fee_growth_inside_a,
            fee_growth_inside_b : arg0.fee_growth_inside_b,
        };
        0x2::event::emit<UpdateFeeEvent>(v2);
    }

    public(friend) fun update_fullsail_distribution(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u64 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fullsail_distribution_internal(v0, arg2);
        v0.fullsail_distribution_owned
    }

    fun update_fullsail_distribution_internal(arg0: &mut PositionInfo, arg1: u128) {
        let v0 = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(arg0.liquidity, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(arg1, arg0.fullsail_distribution_growth_inside), 64) as u64);
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u64::add_check(arg0.fullsail_distribution_owned, v0), 932069234723906182);
        arg0.fullsail_distribution_owned = arg0.fullsail_distribution_owned + v0;
        arg0.fullsail_distribution_growth_inside = arg1;
        let v1 = UpdateFullsailDistributionEvent{
            position_id                         : arg0.position_id,
            fullsail_distribution_owned         : arg0.fullsail_distribution_owned,
            fullsail_distribution_growth_inside : arg0.fullsail_distribution_growth_inside,
        };
        0x2::event::emit<UpdateFullsailDistributionEvent>(v1);
    }

    public(friend) fun update_points(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_points_internal(v0, arg2);
        v0.points_owned
    }

    fun update_points_internal(arg0: &mut PositionInfo, arg1: u128) {
        let v0 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(arg0.liquidity, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(arg1, arg0.points_growth_inside), 64);
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::add_check(arg0.points_owned, v0), 923065912304623497);
        arg0.points_owned = arg0.points_owned + v0;
        arg0.points_growth_inside = arg1;
        let v1 = UpdatePointsEvent{
            position_id          : arg0.position_id,
            points_owned         : arg0.points_owned,
            points_growth_inside : arg0.points_growth_inside,
        };
        0x2::event::emit<UpdatePointsEvent>(v1);
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
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v1 = *0x1::vector::borrow<u128>(&arg1, v0);
            if (0x1::vector::length<PositionReward>(&arg0.rewards) > v0) {
                let v2 = 0x1::vector::borrow_mut<PositionReward>(&mut arg0.rewards, v0);
                let v3 = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(v1, v2.growth_inside), arg0.liquidity, 64) as u64);
                assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u64::add_check(v2.amount_owned, v3), 923065912304623497);
                v2.growth_inside = v1;
                v2.amount_owned = v2.amount_owned + v3;
                let v4 = UpdateRewardEvent{
                    position_id          : arg0.position_id,
                    reward_index         : v0,
                    reward_growth_inside : v2.growth_inside,
                    reward_amount_owned  : v2.amount_owned,
                };
                0x2::event::emit<UpdateRewardEvent>(v4);
            } else {
                let v5 = PositionReward{
                    growth_inside : v1,
                    amount_owned  : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr(v1, arg0.liquidity, 64) as u64),
                };
                let v6 = CreateRewardEvent{
                    position_id          : arg0.position_id,
                    reward_index         : v0,
                    reward_growth_inside : v5.growth_inside,
                    reward_amount_owned  : v5.amount_owned,
                };
                0x2::event::emit<CreateRewardEvent>(v6);
                0x1::vector::push_back<PositionReward>(&mut arg0.rewards, v5);
            };
            v0 = v0 + 1;
        };
    }

    public fun url(arg0: &Position) : 0x1::string::String {
        arg0.url
    }

    public fun validate_position_exists(arg0: &PositionManager, arg1: 0x2::object::ID) {
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 923070870234869348);
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1).position_id == arg1, 923070870234869348);
    }

    // decompiled from Move bytecode v6
}

