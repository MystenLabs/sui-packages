module 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::position {
    struct POSITION has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32,
        upper_tick: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_coin_a: u128,
        fee_growth_coin_b: u128,
        token_a_fee: u64,
        token_b_fee: u64,
        name: 0x1::string::String,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        position_index: u128,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u128, arg6: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32, arg7: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                : 0x2::object::new(arg9),
            pool_id           : arg0,
            lower_tick        : arg6,
            upper_tick        : arg7,
            fee_rate          : arg8,
            liquidity         : 0,
            fee_growth_coin_a : 0,
            fee_growth_coin_b : 0,
            token_a_fee       : 0,
            token_b_fee       : 0,
            name              : create_position_name(arg1),
            coin_type_a       : arg3,
            coin_type_b       : arg4,
            description       : create_position_description(arg1),
            image_url         : arg2,
            position_index    : arg5,
            reward_infos      : 0x1::vector::empty<PositionRewardInfo>(),
        }
    }

    public fun coins_owed_reward(arg0: &Position, arg1: u64) : u64 {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            0
        } else {
            0x1::vector::borrow<PositionRewardInfo>(&arg0.reward_infos, arg1).coins_owed_reward
        }
    }

    fun create_position_description(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"This NFT represents a liquidity position of a Bluefin ");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" pool. The owner of this NFT can modify or redeem the position"));
        v0
    }

    fun create_position_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Bluefin Position, ");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    public(friend) fun decrease_reward_amount(arg0: &mut Position, arg1: u64, arg2: u64) {
        let v0 = get_mutable_reward_info(arg0, arg1);
        v0.coins_owed_reward = v0.coins_owed_reward - arg2;
    }

    public(friend) fun del(arg0: Position) : (0x2::object::ID, 0x2::object::ID, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32) {
        assert!(arg0.liquidity == 0, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::non_empty_position());
        let Position {
            id                : v0,
            pool_id           : v1,
            lower_tick        : v2,
            upper_tick        : v3,
            fee_rate          : _,
            liquidity         : _,
            fee_growth_coin_a : _,
            fee_growth_coin_b : _,
            token_a_fee       : _,
            token_b_fee       : _,
            name              : _,
            coin_type_a       : _,
            coin_type_b       : _,
            description       : _,
            image_url         : _,
            position_index    : _,
            reward_infos      : _,
        } = arg0;
        0x2::object::delete(v0);
        (0x2::object::id<Position>(&arg0), v1, v2, v3)
    }

    public fun get_accrued_fee(arg0: &Position) : (u64, u64) {
        (arg0.token_a_fee, arg0.token_b_fee)
    }

    fun get_mutable_reward_info(arg0: &mut Position, arg1: u64) : &mut PositionRewardInfo {
        if (arg1 >= 0x1::vector::length<PositionRewardInfo>(&arg0.reward_infos)) {
            let v0 = PositionRewardInfo{
                reward_growth_inside_last : 0,
                coins_owed_reward         : 0,
            };
            0x1::vector::push_back<PositionRewardInfo>(&mut arg0.reward_infos, v0);
        };
        0x1::vector::borrow_mut<PositionRewardInfo>(&mut arg0.reward_infos, arg1)
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"pool"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{pool_id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://trade.bluefin.io/spot-nft/id={id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://trade.bluefin.io"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Bluefin"));
        let v2 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Position>(&v2, v0, v1, arg1);
        0x2::display::update_version<Position>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun lower_tick(arg0: &Position) : 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32 {
        arg0.lower_tick
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun set_fee_amounts(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.token_a_fee = arg1;
        arg0.token_b_fee = arg2;
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::I128, arg2: u128, arg3: u128, arg4: vector<u128>) {
        let v0 = if (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::eq(arg1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::zero())) {
            assert!(arg0.liquidity > 0, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::insufficient_liquidity());
            arg0.liquidity
        } else {
            0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::full_math_u128::mul_div_floor(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u128::wrapping_sub(arg2, arg0.fee_growth_coin_a), arg0.liquidity, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::q64());
        let v2 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::full_math_u128::mul_div_floor(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u128::wrapping_sub(arg3, arg0.fee_growth_coin_b), arg0.liquidity, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::q64());
        assert!(v1 <= (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::max_u64() as u128) && v2 <= (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::max_u64() as u128), 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::invalid_fee_growth());
        assert!(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u64::add_check(arg0.token_a_fee, (v1 as u64)) && 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u64::add_check(arg0.token_b_fee, (v2 as u64)), 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::add_check_failed());
        update_reward_infos(arg0, arg4);
        arg0.liquidity = v0;
        arg0.fee_growth_coin_a = arg2;
        arg0.fee_growth_coin_b = arg3;
        arg0.token_a_fee = arg0.token_a_fee + (v1 as u64);
        arg0.token_b_fee = arg0.token_b_fee + (v2 as u64);
    }

    fun update_reward_infos(arg0: &mut Position, arg1: vector<u128>) {
        let v0 = 0;
        let v1 = arg0.liquidity;
        while (v0 < 0x1::vector::length<u128>(&arg1)) {
            let v2 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v3 = get_mutable_reward_info(arg0, v0);
            let v4 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::full_math_u128::mul_div_floor(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u128::wrapping_sub(v2, v3.reward_growth_inside_last), v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::q64());
            assert!(v4 <= (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::max_u64() as u128) && 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::math_u64::add_check(v3.coins_owed_reward, (v4 as u64)), 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::update_rewards_info_check_failed());
            v3.reward_growth_inside_last = v2;
            v3.coins_owed_reward = v3.coins_owed_reward + (v4 as u64);
            v0 = v0 + 1;
        };
    }

    public fun upper_tick(arg0: &Position) : 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i32::I32 {
        arg0.upper_tick
    }

    // decompiled from Move bytecode v6
}

