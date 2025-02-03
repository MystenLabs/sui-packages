module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        tick_lower_index: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32,
        tick_upper_index: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32,
        liquidity: u128,
        fee_growth_inside_x_last: u128,
        fee_growth_inside_y_last: u128,
        owed_coin_x: u64,
        owed_coin_y: u64,
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
            type_x                   : _,
            type_y                   : _,
            tick_lower_index         : _,
            tick_upper_index         : _,
            liquidity                : _,
            fee_growth_inside_x_last : _,
            fee_growth_inside_y_last : _,
            owed_coin_x              : _,
            owed_coin_y              : _,
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

    public(friend) fun decrease_owed_amount(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.owed_coin_x = arg0.owed_coin_x - arg1;
        arg0.owed_coin_y = arg0.owed_coin_y - arg2;
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

    public(friend) fun increase_owed_amount(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.owed_coin_x = arg0.owed_coin_x + arg1;
        arg0.owed_coin_y = arg0.owed_coin_y + arg2;
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<Position>(&v0, arg1);
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Kriya CLMM LP position"));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b""));
        0x2::display::add<Position>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://lpegyj6xxzqppw76qskh75lxiwl4pqrb7dsaizopmiisisgwcyla.arweave.net/W8hsJ9e-YPfb_oSUf_V3RZfHwiH45ARlz2IRJEjWFhY"));
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
        let v2 = arg0.liquidity == 0 && arg0.owed_coin_x == 0 && arg0.owed_coin_y == 0;
        v2 && v0
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public(friend) fun open(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg5: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg6: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                       : 0x2::object::new(arg6),
            pool_id                  : arg0,
            fee_rate                 : arg1,
            type_x                   : arg2,
            type_y                   : arg3,
            tick_lower_index         : arg4,
            tick_upper_index         : arg5,
            liquidity                : 0,
            fee_growth_inside_x_last : 0,
            fee_growth_inside_y_last : 0,
            owed_coin_x              : 0,
            owed_coin_y              : 0,
            reward_infos             : 0x1::vector::empty<PositionRewardInfo>(),
        }
    }

    public fun owed_coin_x(arg0: &Position) : u64 {
        arg0.owed_coin_x
    }

    public fun owed_coin_y(arg0: &Position) : u64 {
        arg0.owed_coin_y
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

    public fun tick_lower_index(arg0: &Position) : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32 {
        arg0.tick_lower_index
    }

    public fun tick_upper_index(arg0: &Position) : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32 {
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

    public(friend) fun update(arg0: &mut Position, arg1: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::I128, arg2: u128, arg3: u128, arg4: vector<u128>) {
        let v0 = if (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::eq(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::zero())) {
            assert!(arg0.liquidity > 0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::insufficient_liquidity());
            arg0.liquidity
        } else {
            0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_x_last), arg0.liquidity, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64());
        let v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::wrapping_sub(arg3, arg0.fee_growth_inside_y_last), arg0.liquidity, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64());
        assert!(v1 <= (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::max_u64() as u128) && v2 <= (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::max_u64() as u128), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::invalid_fee_growth());
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u64::add_check(arg0.owed_coin_x, (v1 as u64)) && 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u64::add_check(arg0.owed_coin_y, (v2 as u64)), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::add_check_failed());
        update_reward_infos(arg0, arg4);
        arg0.liquidity = v0;
        arg0.fee_growth_inside_x_last = arg2;
        arg0.fee_growth_inside_y_last = arg3;
        arg0.owed_coin_x = arg0.owed_coin_x + (v1 as u64);
        arg0.owed_coin_y = arg0.owed_coin_y + (v2 as u64);
    }

    fun update_reward_infos(arg0: &mut Position, arg1: vector<u128>) {
        let v0 = 0;
        let v1 = arg0.liquidity;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v2 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v3 = try_borrow_mut_reward_info(arg0, v0);
            let v4 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::wrapping_sub(v2, v3.reward_growth_inside_last), v1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64());
            assert!(v4 <= (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::max_u64() as u128) && 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u64::add_check(v3.coins_owed_reward, (v4 as u64)), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::update_rewards_info_check_failed());
            v3.reward_growth_inside_last = v2;
            v3.coins_owed_reward = v3.coins_owed_reward + (v4 as u64);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

