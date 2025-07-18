module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager {
    struct TurbosPositionBurnNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        position_nft: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        fee_type: 0x1::type_name::TypeName,
    }

    struct PositionRewardInfo has store {
        reward_growth_inside: u128,
        amount_owed: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct Positions has store, key {
        id: 0x2::object::UID,
        nft_minted: u64,
        user_position: 0x2::table::Table<address, 0x2::object::ID>,
        nft_name: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_img_url: 0x1::string::String,
    }

    struct IncreaseLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        liquidity: u128,
    }

    struct DecreaseLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        liquidity: u128,
    }

    struct CollectEvent has copy, drop {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        recipient: address,
    }

    struct CollectRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        vault: 0x2::object::ID,
        reward_index: u64,
        recipient: address,
    }

    struct BurnPositionEvent has copy, drop {
        nft_address: address,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        burn_nft_address: address,
    }

    public entry fun burn<T0, T1, T2>(arg0: &mut Positions, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg2);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg0.id, v0);
        let v2 = if (v1.liquidity == 0) {
            if (v1.tokens_owed_a == 0) {
                v1.tokens_owed_b == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 6);
        let v3 = 0;
        while (v3 < 0x1::vector::length<PositionRewardInfo>(&v1.reward_infos)) {
            assert!(0x1::vector::borrow<PositionRewardInfo>(&v1.reward_infos, v3).amount_owed == 0, 6);
            v3 = v3 + 1;
        };
        delete_user_position(arg0, v0);
        burn_nft(arg1);
    }

    public fun collect_reward_with_return_<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(arg2), 15);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 8);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, v0);
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, v0, v1.tick_lower_index, v1.tick_upper_index)) {
            v0
        } else {
            0x2::tx_context::sender(arg10)
        };
        if (v1.liquidity > 0) {
            let (_, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::burn<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index, 0, arg8, arg10);
            let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index);
            copy_position<T0, T1, T2>(arg0, v5, v1);
        };
        assert!(arg4 < 0x1::vector::length<PositionRewardInfo>(&v1.reward_infos), 10);
        let v6 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut v1.reward_infos, arg4);
        let v7 = if (arg5 > v6.amount_owed) {
            v6.amount_owed
        } else {
            arg5
        };
        let v8 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::collect_reward_with_return_<T0, T1, T2, T3>(arg0, arg3, arg6, v2, v1.tick_lower_index, v1.tick_upper_index, v7, arg4, arg10);
        v6.amount_owed = v6.amount_owed - v7;
        let v9 = CollectRewardEvent{
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount       : 0x2::coin::value<T3>(&v8),
            vault        : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>>(arg3),
            reward_index : arg4,
            recipient    : arg6,
        };
        0x2::event::emit<CollectRewardEvent>(v9);
        v8
    }

    public(friend) fun migrate_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: vector<address>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<address>(&mut arg2);
        let (v1, v2) = get_position_tick_info(arg1, v0);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, arg3, v1, v2), 11);
        assert!(!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, v0, v1, v2), 12);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, arg3, v1, v2);
        copy_position_with_address<T0, T1, T2>(arg0, arg1, v3, v0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::migrate_position<T0, T1, T2>(arg0, v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v0, v1, v2), arg4);
        while (0x1::vector::length<address>(&arg2) > 0) {
            clean_position(arg1, v1, v2, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public entry fun mint<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: u64, arg14: &0x2::clock::Clock, arg15: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg16: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg15);
        let (v0, v1, v2) = mint_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg16));
        };
        if (0x2::coin::value<T1>(&v3) == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg16));
        };
        0x2::transfer::public_transfer<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v0, arg12);
    }

    fun add_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u128, u64, u64) {
        abort 0
    }

    fun add_liquidity_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u128, u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg5), (arg6 as u128), (arg7 as u128));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::mint<T0, T1, T2>(arg0, arg3, arg4, arg5, v0, arg8, arg9);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg0);
        let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::split_and_return_<T0, T1, T2>(arg0, arg1, v1, arg2, v2, arg9);
        let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg0);
        assert!(v3 + v1 <= v7, 7);
        assert!(v4 + v2 <= v8, 7);
        (v0, v1, v2, v5, v6)
    }

    fun burn_nft(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::burn(arg0);
    }

    public fun burn_nft_collect_fee_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut TurbosPositionBurnNFT, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg2.position_nft;
        collect_with_return_<T0, T1, T2>(arg0, arg1, v0, arg3, arg4, @0x0, arg5, arg6, arg7, arg8)
    }

    public fun burn_nft_collect_reward_with_return_<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut TurbosPositionBurnNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg8);
        let v0 = &mut arg2.position_nft;
        collect_reward_with_return_<T0, T1, T2, T3>(arg0, arg1, v0, arg3, arg4, arg5, @0x0, arg6, arg7, arg8, arg9)
    }

    public entry fun burn_nft_directly(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::burn(arg0);
    }

    public fun burn_position_nft_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : TurbosPositionBurnNFT {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg2);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg2), 15);
        let v1 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, v1);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636 % 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0));
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v2.tick_lower_index, v3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636)), 16);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v2.tick_upper_index, v3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636)), 16);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&arg2);
        let v5 = TurbosPositionBurnNFT{
            id           : 0x2::object::new(arg4),
            name         : 0x1::string::utf8(b"Proof of Turbos Position Burn"),
            description  : 0x1::string::utf8(b"Proof of Turbos Position Burn"),
            img_url      : 0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://app.turbos.finance/icon/turbos-position-burn-nft.png"))),
            position_nft : arg2,
            position_id  : v4,
            pool_id      : v0,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            fee_type     : 0x1::type_name::get<T2>(),
        };
        let v6 = BurnPositionEvent{
            nft_address      : v1,
            position_id      : v4,
            pool_id          : v0,
            burn_nft_address : 0x2::object::id_address<TurbosPositionBurnNFT>(&v5),
        };
        0x2::event::emit<BurnPositionEvent>(v6);
        v5
    }

    fun clean_position(arg0: &mut Positions, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg0.id, arg3);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v0.tick_lower_index, arg1) && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v0.tick_upper_index, arg2), 14);
        v0.liquidity = 0;
        v0.tick_lower_index = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero();
        v0.tick_upper_index = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero();
        v0.fee_growth_inside_a = 0;
        v0.fee_growth_inside_b = 0;
        v0.tokens_owed_a = 0;
        v0.tokens_owed_b = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRewardInfo>(&v0.reward_infos)) {
            let v2 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut v0.reward_infos, v1);
            v2.reward_growth_inside = 0;
            v2.amount_owed = 0;
            v1 = v1 + 1;
        };
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_position, arg3)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_position, arg3);
        };
    }

    public entry fun collect<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg8);
        let (v0, v1) = collect_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg5);
    }

    public entry fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(collect_reward_with_return_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg6);
    }

    public fun collect_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg8);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(arg2), 15);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 8);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, v0);
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, v0, v1.tick_lower_index, v1.tick_upper_index)) {
            v0
        } else {
            0x2::tx_context::sender(arg9)
        };
        if (v1.liquidity > 0) {
            let (_, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::burn<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index, 0, arg7, arg9);
            let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index);
            copy_position<T0, T1, T2>(arg0, v5, v1);
        };
        let v6 = v1.tokens_owed_a;
        let v7 = v1.tokens_owed_b;
        let v8 = if (arg3 > v6) {
            v6
        } else {
            arg3
        };
        let v9 = if (arg4 > v7) {
            v7
        } else {
            arg4
        };
        let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::collect_v2<T0, T1, T2>(arg0, arg5, v2, v1.tick_lower_index, v1.tick_upper_index, v8, v9, arg9);
        let (v12, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::split_out_and_return_<T0, T1, T2>(arg0, v10, v11, arg9);
        v1.tokens_owed_a = v1.tokens_owed_a - v8;
        v1.tokens_owed_b = v1.tokens_owed_b - v9;
        let v14 = CollectEvent{
            pool      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount_a  : v10,
            amount_b  : v11,
            recipient : arg5,
        };
        0x2::event::emit<CollectEvent>(v14);
        (v12, v13)
    }

    fun copy_position<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x1::string::String, arg2: &mut Position) {
        let (v0, v1, v2, v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_base_info<T0, T1, T2>(arg0, arg1);
        arg2.liquidity = v0;
        arg2.fee_growth_inside_a = v1;
        arg2.fee_growth_inside_b = v2;
        arg2.tokens_owed_a = v3;
        arg2.tokens_owed_b = v4;
        let v6 = &mut arg2.reward_infos;
        copy_reward_info(v5, v6);
    }

    fun copy_position_with_address<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: 0x1::string::String, arg3: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, arg3);
        copy_position<T0, T1, T2>(arg0, arg2, v0);
    }

    fun copy_reward_info(arg0: &vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PositionRewardInfo>, arg1: &mut vector<PositionRewardInfo>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PositionRewardInfo>(arg0)) {
            let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_reward_info(0x1::vector::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PositionRewardInfo>(arg0, v0));
            try_init_reward_infos(arg1, v0);
            let v3 = 0x1::vector::borrow_mut<PositionRewardInfo>(arg1, v0);
            v3.reward_growth_inside = v1;
            v3.amount_owed = v2;
            v0 = v0 + 1;
        };
    }

    public entry fun decrease_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg8);
        let (v0, v1) = decrease_liquidity_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public(friend) fun decrease_liquidity_admin<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: address, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg3, arg4);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg5, arg6);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, arg2, v0, v1);
        if (0x2::dynamic_object_field::exists_<address>(&arg1.id, arg2)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, arg2);
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v0, v3.tick_lower_index), 6);
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v1, v3.tick_upper_index), 6);
            copy_position<T0, T1, T2>(arg0, v2, v3);
        };
        let (v4, _, _, _, _, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_base_info<T0, T1, T2>(arg0, v2);
        let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::burn<T0, T1, T2>(arg0, arg2, v0, v1, v4, arg8, arg9);
        let (v12, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::split_out_and_return_<T0, T1, T2>(arg0, v10, v11, arg9);
        let v14 = DecreaseLiquidityEvent{
            pool      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount_a  : v10,
            amount_b  : v11,
            liquidity : v4,
        };
        0x2::event::emit<DecreaseLiquidityEvent>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, arg7);
    }

    public fun decrease_liquidity_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg8);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(arg2), 15);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 8);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, v0);
        assert!(v1.liquidity >= arg3, 9);
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, v0, v1.tick_lower_index, v1.tick_upper_index)) {
            v0
        } else {
            0x2::tx_context::sender(arg9)
        };
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::burn<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index, arg3, arg7, arg9);
        assert!(v3 >= arg4 && v4 >= arg5, 5);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index);
        copy_position<T0, T1, T2>(arg0, v5, v1);
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::split_out_and_return_<T0, T1, T2>(arg0, v3, v4, arg9);
        let v8 = DecreaseLiquidityEvent{
            pool      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount_a  : v3,
            amount_b  : v4,
            liquidity : arg3,
        };
        0x2::event::emit<DecreaseLiquidityEvent>(v8);
        (v6, v7)
    }

    fun delete_user_position(arg0: &mut Positions, arg1: address) {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_position, arg1)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_position, arg1);
        };
    }

    fun get_mut_position(arg0: &mut Positions, arg1: address) : &mut Position {
        0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg0.id, arg1)
    }

    public fun get_position_info(arg0: &Positions, arg1: address) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u128) {
        let v0 = 0x2::dynamic_object_field::borrow<address, Position>(&arg0.id, arg1);
        (v0.tick_lower_index, v0.tick_upper_index, v0.liquidity)
    }

    fun get_position_tick_info(arg0: &mut Positions, arg1: address) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        let v0 = 0x2::dynamic_object_field::borrow<address, Position>(&arg0.id, arg1);
        (v0.tick_lower_index, v0.tick_upper_index)
    }

    public entry fun increase_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        let (v0, v1) = increase_liquidity_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg12));
        };
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg12));
        };
    }

    public fun increase_liquidity_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg11);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(arg4), 15);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 8);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) > 0, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T1>>(&arg3) > 0, 4);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg1.id, v0);
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_position_exists<T0, T1, T2>(arg0, v0, v1.tick_lower_index, v1.tick_upper_index)) {
            v0
        } else {
            0x2::tx_context::sender(arg12)
        };
        let (v3, v4, v5, v6, v7) = add_liquidity_with_return_<T0, T1, T2>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T1>(arg3), v2, v1.tick_lower_index, v1.tick_upper_index, arg5, arg6, arg10, arg12);
        assert!(v4 >= arg7 && v5 >= arg8, 5);
        let v8 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v2, v1.tick_lower_index, v1.tick_upper_index);
        copy_position<T0, T1, T2>(arg0, v8, v1);
        let v9 = IncreaseLiquidityEvent{
            pool      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount_a  : v4,
            amount_b  : v5,
            liquidity : v3,
        };
        0x2::event::emit<IncreaseLiquidityEvent>(v9);
        (v6, v7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_(arg0);
    }

    fun init_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Positions{
            id              : 0x2::object::new(arg0),
            nft_minted      : 0,
            user_position   : 0x2::table::new<address, 0x2::object::ID>(arg0),
            nft_name        : 0x1::string::utf8(b"Turbos Position's NFT"),
            nft_description : 0x1::string::utf8(b"An NFT created by Turbos CLMM"),
            nft_img_url     : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmTxRsWbrLG6mkjg375wW77Lfzm38qsUQjRBj3b2K3t8q1?filename=Turbos_nft.png"),
        };
        0x2::transfer::share_object<Positions>(v0);
    }

    fun insert_user_position(arg0: &mut Positions, arg1: 0x2::object::ID, arg2: address) {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_position, arg2)) {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_position, arg2, arg1);
        };
    }

    fun mint_nft<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut Positions, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : address {
        let v0 = mint_nft_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v0, arg3);
        0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v0)
    }

    fun mint_nft_with_return_<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut Positions, arg3: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        arg2.nft_minted = arg2.nft_minted + 1;
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::mint(arg2.nft_name, arg2.nft_description, arg2.nft_img_url, arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), 0x1::type_name::get<T2>(), arg3)
    }

    public fun mint_with_return_<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut Positions, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg15: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg14);
        assert!(0x2::clock::timestamp_ms(arg13) <= arg12, 8);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) > 0, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T1>>(&arg3) > 0, 4);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg4, arg5);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg6, arg7);
        let v2 = 0x2::object::new(arg15);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = mint_nft_with_return_<T0, T1, T2>(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0), v3, arg1, arg15);
        let v5 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v4);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_position_key_fix<T0, T1, T2>(arg0, v5, v0, v1);
        let (v7, v8, v9, v10, v11) = add_liquidity_with_return_<T0, T1, T2>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T0>(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::merge_coin<T1>(arg3), v5, v0, v1, arg8, arg9, arg13, arg15);
        assert!(v8 >= arg10 && v9 >= arg11, 5);
        let v12 = Position{
            id                  : v2,
            tick_lower_index    : v0,
            tick_upper_index    : v1,
            liquidity           : v7,
            fee_growth_inside_a : 0,
            fee_growth_inside_b : 0,
            tokens_owed_a       : 0,
            tokens_owed_b       : 0,
            reward_infos        : 0x1::vector::empty<PositionRewardInfo>(),
        };
        let v13 = &mut v12;
        copy_position<T0, T1, T2>(arg0, v6, v13);
        0x2::dynamic_object_field::add<address, Position>(&mut arg1.id, v5, v12);
        insert_user_position(arg1, v3, v5);
        let v14 = IncreaseLiquidityEvent{
            pool      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            amount_a  : v8,
            amount_b  : v9,
            liquidity : v7,
        };
        0x2::event::emit<IncreaseLiquidityEvent>(v14);
        (v4, v10, v11)
    }

    public(friend) fun modify_position_reward_inside(arg0: &mut Positions, arg1: address, arg2: u64, arg3: u128) {
        let v0 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut 0x2::dynamic_object_field::borrow_mut<address, Position>(&mut arg0.id, arg1).reward_infos, arg2);
        v0.reward_growth_inside = arg3;
        v0.amount_owed = 0;
    }

    fun try_init_reward_infos(arg0: &mut vector<PositionRewardInfo>, arg1: u64) {
        if (arg1 == 0x1::vector::length<PositionRewardInfo>(arg0)) {
            let v0 = PositionRewardInfo{
                reward_growth_inside : 0,
                amount_owed          : 0,
            };
            0x1::vector::push_back<PositionRewardInfo>(arg0, v0);
        };
    }

    public(friend) fun update_nft_description(arg0: &mut Positions, arg1: 0x1::string::String) {
        arg0.nft_description = arg1;
    }

    public(friend) fun update_nft_img_url(arg0: &mut Positions, arg1: 0x1::string::String) {
        arg0.nft_img_url = arg1;
    }

    public(friend) fun update_nft_name(arg0: &mut Positions, arg1: 0x1::string::String) {
        arg0.nft_name = arg1;
    }

    // decompiled from Move bytecode v6
}

