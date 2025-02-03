module 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        liquidity: u128,
        fee_growth_inside_x_last: u128,
        fee_growth_inside_y_last: u128,
        coins_owed_x: u64,
        coins_owed_y: u64,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }

    public(friend) fun close(arg0: Position) {
        let Position {
            id                       : v0,
            pool_id                  : _,
            fee_rate                 : _,
            coin_type_x              : _,
            coin_type_y              : _,
            tick_lower_index         : _,
            tick_upper_index         : _,
            liquidity                : _,
            fee_growth_inside_x_last : _,
            fee_growth_inside_y_last : _,
            coins_owed_x             : _,
            coins_owed_y             : _,
            reward_infos             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun coins_owed_reward(arg0: &Position, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            0
        } else {
            0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, arg1).coins_owed_reward
        }
    }

    public fun coins_owed_x(arg0: &Position) : u64 {
        arg0.coins_owed_x
    }

    public fun coins_owed_y(arg0: &Position) : u64 {
        arg0.coins_owed_y
    }

    public(friend) fun decrease_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.coins_owed_x = arg0.coins_owed_x - arg1;
        arg0.coins_owed_y = arg0.coins_owed_y - arg2;
    }

    public(friend) fun decrease_reward_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        let v0 = try_borrow_mut_reward_info(arg0, arg1);
        v0.coins_owed_reward = v0.coins_owed_reward - arg2;
    }

    public fun fee_growth_inside_x_last(arg0: &Position) : u128 {
        arg0.fee_growth_inside_x_last
    }

    public fun fee_growth_inside_y_last(arg0: &Position) : u128 {
        arg0.fee_growth_inside_y_last
    }

    public fun fee_rate(arg0: &Position) : u64 {
        arg0.fee_rate
    }

    public(friend) fun increase_debt(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.coins_owed_x = arg0.coins_owed_x + arg1;
        arg0.coins_owed_y = arg0.coins_owed_y + arg2;
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<Position>(&v0, arg1);
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"FlowX CLMM Liquidity Positions"));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This NFT represents a liquidity position in FlowX CLMM. The owner of this NFT can modify or redeem the position."));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://ipfs.io/ipfs/QmV3S91uDAPJAcqMNed3R6JyAXKnbidgNdHGhnwU5LyUDZ"));
        0x2::display::update_version<Position>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_empty(arg0: &Position) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, v1).coins_owed_reward != 0) {
                v0 = false;
                break
            };
            v1 = v1 + 1;
        };
        let v2 = arg0.liquidity == 0 && arg0.coins_owed_x == 0 && arg0.coins_owed_y == 0;
        v2 && v0
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun open(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg6: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                       : 0x2::object::new(arg6),
            pool_id                  : arg0,
            fee_rate                 : arg1,
            coin_type_x              : arg2,
            coin_type_y              : arg3,
            tick_lower_index         : arg4,
            tick_upper_index         : arg5,
            liquidity                : 0,
            fee_growth_inside_x_last : 0,
            fee_growth_inside_y_last : 0,
            coins_owed_x             : 0,
            coins_owed_y             : 0,
            reward_infos             : 0x1::vector::empty<PositionRewardInfo>(),
        }
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun reward_growth_inside_last(arg0: &Position, arg1: u64) : u128 {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            0
        } else {
            0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, arg1).reward_growth_inside_last
        }
    }

    public fun reward_length(arg0: &Position) : u64 {
        0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)
    }

    public fun tick_lower_index(arg0: &Position) : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32 {
        arg0.tick_lower_index
    }

    public fun tick_upper_index(arg0: &Position) : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32 {
        arg0.tick_upper_index
    }

    fun try_borrow_mut_reward_info(arg0: &mut Position, arg1: u64) : &mut PositionRewardInfo {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            let v0 = PositionRewardInfo{
                reward_growth_inside_last : 0,
                coins_owed_reward         : 0,
            };
            0x1::vector::push_back<PositionRewardInfo>(&mut arg0.reward_infos, v0);
        };
        0x1::vector::borrow_mut<PositionRewardInfo>(&mut arg0.reward_infos, arg1)
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::I128, arg2: u128, arg3: u128, arg4: vector<u128>) {
        let v0 = if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::eq(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::zero())) {
            if (arg0.liquidity == 0) {
                abort 0
            };
            arg0.liquidity
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::mul_div_floor(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_x_last), arg0.liquidity, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_q64());
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::mul_div_floor(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::wrapping_sub(arg3, arg0.fee_growth_inside_y_last), arg0.liquidity, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_q64());
        if (v1 > (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_max_u64() as u128) || v2 > (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_max_u64() as u128)) {
            abort 1
        };
        if (!0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u64::add_check(arg0.coins_owed_x, (v1 as u64)) || !0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u64::add_check(arg0.coins_owed_x, (v1 as u64))) {
            abort 1
        };
        update_reward_infos(arg0, arg4);
        arg0.liquidity = v0;
        arg0.fee_growth_inside_x_last = arg2;
        arg0.fee_growth_inside_y_last = arg3;
        arg0.coins_owed_x = arg0.coins_owed_x + (v1 as u64);
        arg0.coins_owed_y = arg0.coins_owed_y + (v2 as u64);
    }

    fun update_reward_infos(arg0: &mut Position, arg1: vector<u128>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v1 = arg0.liquidity;
            let v2 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v3 = try_borrow_mut_reward_info(arg0, v0);
            let v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::mul_div_floor(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::wrapping_sub(v2, v3.reward_growth_inside_last), v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_q64());
            if (v4 > (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::constants::get_max_u64() as u128) || !0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u64::add_check(v3.coins_owed_reward, (v4 as u64))) {
                abort 1
            };
            v3.reward_growth_inside_last = v2;
            v3.coins_owed_reward = v3.coins_owed_reward + (v4 as u64);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

