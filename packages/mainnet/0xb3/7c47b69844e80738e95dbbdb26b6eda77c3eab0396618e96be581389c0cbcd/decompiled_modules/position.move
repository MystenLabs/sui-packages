module 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::position {
    struct StakePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        staked: bool,
    }

    struct PositionManager has store {
        tick_spacing: u32,
        position_index: u64,
        positions: 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
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
        tick_lower_index: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32,
        tick_upper_index: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32,
        liquidity: u128,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tick_lower_index: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32,
        tick_upper_index: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owned_a: u64,
        fee_owned_b: u64,
        points_owned: u128,
        points_growth_inside: u128,
        rewards: vector<PositionReward>,
        magma_distribution_staked: bool,
        magma_distribution_growth_inside: u128,
        magma_distribution_owned: u64,
    }

    struct PositionReward has copy, drop, store {
        growth_inside: u128,
        amount_owned: u64,
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
        let v3 = if (arg0.liquidity == 0) {
            if (arg0.fee_owned_a == 0) {
                arg0.fee_owned_b == 0
            } else {
                false
            }
        } else {
            false
        };
        v3 && v0
    }

    public(friend) fun new(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : PositionManager {
        PositionManager{
            tick_spacing   : arg0,
            position_index : 0,
            positions      : 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::new<0x2::object::ID, PositionInfo>(arg1),
        }
    }

    fun borrow_mut_position_info(arg0: &mut PositionManager, arg1: 0x2::object::ID) : &mut PositionInfo {
        assert!(0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow_mut<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    public fun borrow_position_info(arg0: &PositionManager, arg1: 0x2::object::ID) : &PositionInfo {
        assert!(0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1), 6);
        let v0 = 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1);
        assert!(v0.position_id == arg1, 6);
        v0
    }

    public fun check_position_tick_range(arg0: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, arg1: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, arg2: u32) {
        let v0 = if (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::lt(arg0, arg1)) {
            if (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::gte(arg0, 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::tick_math::min_tick())) {
                if (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::lte(arg1, 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::tick_math::max_tick())) {
                    if (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::mod(arg0, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::from(arg2)) == 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::zero()) {
                        0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::mod(arg1, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::from(arg2)) == 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::zero()
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
        assert!(v0, 5);
    }

    public(friend) fun close_position(arg0: &mut PositionManager, arg1: Position) {
        let v0 = 0x2::object::id<Position>(&arg1);
        let v1 = borrow_mut_position_info(arg0, v0);
        if (!is_empty(v1)) {
            abort 7
        };
        0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, v0);
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
        update_magma_distribution_internal(v0, arg7);
        assert!(v0.liquidity >= arg2, 9);
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

    public fun fetch_positions(arg0: &PositionManager, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PositionInfo> {
        let v0 = 0x1::vector::empty<PositionInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::head<0x2::object::ID, PositionInfo>(&arg0.positions)
        } else {
            0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::next<0x2::object::ID, PositionInfo>(0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow_node<0x2::object::ID, PositionInfo>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(&arg1, 0)))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v2)) {
            let v4 = 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow_node<0x2::object::ID, PositionInfo>(&arg0.positions, *0x1::option::borrow<0x2::object::ID>(&v2));
            v2 = 0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::next<0x2::object::ID, PositionInfo>(v4);
            0x1::vector::push_back<PositionInfo>(&mut v0, *0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow_value<0x2::object::ID, PositionInfo>(v4));
            let v5 = v3 + 1;
            v3 = v5;
            if (v5 == arg2) {
                break
            };
        };
        v0
    }

    public(friend) fun increase_liquidity(arg0: &mut PositionManager, arg1: &mut Position, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, 0x2::object::id<Position>(arg1));
        update_fee_internal(v0, arg3, arg4);
        update_points_internal(v0, arg5);
        update_rewards_internal(v0, arg6);
        update_magma_distribution_internal(v0, arg7);
        assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::add_check(v0.liquidity, arg2), 8);
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

    public fun info_magma_distribution_owned(arg0: &PositionInfo) : u64 {
        arg0.magma_distribution_owned
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

    public fun info_tick_range(arg0: &PositionInfo) : (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.cetus.zone/position?chain=sui&id={id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Cetus"));
        let v2 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Position>(&v2, v0, v1, arg1);
        0x2::display::update_version<Position>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun inited_rewards_count(arg0: &PositionManager, arg1: 0x2::object::ID) : u64 {
        0x1::vector::length<PositionReward>(&0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::borrow<0x2::object::ID, PositionInfo>(&arg0.positions, arg1).rewards)
    }

    public fun is_position_exist(arg0: &PositionManager, arg1: 0x2::object::ID) : bool {
        0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public fun is_staked(arg0: &PositionInfo) : bool {
        arg0.magma_distribution_staked
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun mark_position_staked(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        assert!(v0.magma_distribution_staked != arg2, 11);
        v0.magma_distribution_staked = arg2;
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
        let v0 = 0x1::string::utf8(b"Magma position:");
        0x1::string::append(&mut v0, 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::utils::str(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::utils::str(arg1));
        v0
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, arg5: 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, arg6: &mut 0x2::tx_context::TxContext) : Position {
        check_position_tick_range(arg4, arg5, arg0.tick_spacing);
        let v0 = arg0.position_index + 1;
        let v1 = Position{
            id               : 0x2::object::new(arg6),
            pool             : arg1,
            index            : v0,
            coin_type_a      : 0x1::type_name::get<T0>(),
            coin_type_b      : 0x1::type_name::get<T1>(),
            name             : new_position_name(arg2, v0),
            description      : 0x1::string::utf8(b"Magma Liquidity Position"),
            url              : arg3,
            tick_lower_index : arg4,
            tick_upper_index : arg5,
            liquidity        : 0,
        };
        let v2 = 0x2::object::id<Position>(&v1);
        let v3 = PositionInfo{
            position_id                      : v2,
            liquidity                        : 0,
            tick_lower_index                 : arg4,
            tick_upper_index                 : arg5,
            fee_growth_inside_a              : 0,
            fee_growth_inside_b              : 0,
            fee_owned_a                      : 0,
            fee_owned_b                      : 0,
            points_owned                     : 0,
            points_growth_inside             : 0,
            rewards                          : 0x1::vector::empty<PositionReward>(),
            magma_distribution_staked        : false,
            magma_distribution_growth_inside : 0,
            magma_distribution_owned         : 0,
        };
        0x3a763e0b5fc83c56cfcfd260d8fd68b4b78dee0371cde97d4aba19933b0c2f20::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, v2, v3);
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

    public fun set_display(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::checked_package_version(arg0);
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
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg5);
        let v2 = 0x2::display::new_with_fields<Position>(arg1, v0, v1, arg6);
        0x2::display::update_version<Position>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v2, 0x2::tx_context::sender(arg6));
    }

    public fun tick_range(arg0: &Position) : (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::I32) {
        (arg0.tick_lower_index, arg0.tick_upper_index)
    }

    public(friend) fun update_and_reset_fee(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_fee_internal(v0, arg2, arg3);
        v0.fee_owned_a = 0;
        v0.fee_owned_b = 0;
        (v0.fee_owned_a, v0.fee_owned_b)
    }

    public(friend) fun update_and_reset_magma_distribution(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u64 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_magma_distribution_internal(v0, arg2);
        v0.magma_distribution_owned = 0;
        v0.magma_distribution_owned
    }

    public(friend) fun update_and_reset_rewards(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: vector<u128>, arg3: u64) : u64 {
        assert!(0x1::vector::length<u128>(&arg2) > arg3, 10);
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
        let v0 = (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(arg0.liquidity, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::wrapping_sub(arg1, arg0.fee_growth_inside_a), 64) as u64);
        let v1 = (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(arg0.liquidity, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_b), 64) as u64);
        assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u64::add_check(arg0.fee_owned_a, v0), 1);
        assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u64::add_check(arg0.fee_owned_b, v1), 1);
        arg0.fee_owned_a = arg0.fee_owned_a + v0;
        arg0.fee_owned_b = arg0.fee_owned_b + v1;
        arg0.fee_growth_inside_a = arg1;
        arg0.fee_growth_inside_b = arg2;
    }

    public(friend) fun update_magma_distribution(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u64 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_magma_distribution_internal(v0, arg2);
        v0.magma_distribution_owned
    }

    fun update_magma_distribution_internal(arg0: &mut PositionInfo, arg1: u128) {
        let v0 = (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(arg0.liquidity, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::wrapping_sub(arg1, arg0.magma_distribution_growth_inside), 64) as u64);
        assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u64::add_check(arg0.magma_distribution_owned, v0), 9223374347547181055);
        arg0.magma_distribution_owned = arg0.magma_distribution_owned + v0;
        arg0.magma_distribution_growth_inside = arg1;
    }

    public(friend) fun update_points(arg0: &mut PositionManager, arg1: 0x2::object::ID, arg2: u128) : u128 {
        let v0 = borrow_mut_position_info(arg0, arg1);
        update_points_internal(v0, arg2);
        v0.points_owned
    }

    fun update_points_internal(arg0: &mut PositionInfo, arg1: u128) {
        let v0 = 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(arg0.liquidity, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::wrapping_sub(arg1, arg0.points_growth_inside), 64);
        assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::add_check(arg0.points_owned, v0), 3);
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
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v1 = *0x1::vector::borrow<u128>(&arg1, v0);
            if (0x1::vector::length<PositionReward>(&arg0.rewards) > v0) {
                let v2 = 0x1::vector::borrow_mut<PositionReward>(&mut arg0.rewards, v0);
                let v3 = (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u128::wrapping_sub(v1, v2.growth_inside), arg0.liquidity, 64) as u64);
                assert!(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::math_u64::add_check(v2.amount_owned, v3), 1);
                v2.growth_inside = v1;
                v2.amount_owned = v2.amount_owned + v3;
            } else {
                let v4 = PositionReward{
                    growth_inside : v1,
                    amount_owned  : (0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_shr(v1, arg0.liquidity, 64) as u64),
                };
                0x1::vector::push_back<PositionReward>(&mut arg0.rewards, v4);
            };
            v0 = v0 + 1;
        };
    }

    public fun url(arg0: &Position) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

