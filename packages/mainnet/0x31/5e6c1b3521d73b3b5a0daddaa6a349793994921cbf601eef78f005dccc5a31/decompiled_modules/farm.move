module 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm {
    struct CreateFarmEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        turbos_position_nft_id: 0x2::object::ID,
    }

    struct DestroyFarmEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        coin_amount_a: u64,
        coin_amount_b: u64,
        delta_share: u128,
    }

    struct AddLiquidityEventV2 has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        coin_amount_a: u64,
        coin_amount_b: u64,
        old_total_liquidity: u128,
        new_total_liquidity: u128,
        old_total_share: u128,
        new_total_share: u128,
    }

    struct RemoveLiquidityEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        coin_amount_a: u64,
        coin_amount_b: u64,
        delta_share: u128,
    }

    struct RemoveLiquidityEventV2 has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        coin_amount_a: u64,
        coin_amount_b: u64,
        old_total_liquidity: u128,
        new_total_liquidity: u128,
        old_total_share: u128,
        new_total_share: u128,
    }

    struct DistributeFeeAndRewardEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        protocol_amount: u64,
        reward_amount: u64,
    }

    struct RebalanceEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        old_tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        old_tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        old_liquidity: u128,
        old_coin_amount_a: u64,
        old_coin_amount_b: u64,
        new_tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        new_tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        new_liquidity: u128,
        new_coin_amount_a: u64,
        new_coin_amount_b: u64,
    }

    struct CompoundEvent has copy, drop {
        sender: address,
        farm_id: 0x2::object::ID,
        old_liquidity: u128,
        old_coin_amount_a: u64,
        old_coin_amount_b: u64,
        new_liquidity: u128,
        new_coin_amount_a: u64,
        new_coin_amount_b: u64,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        turbos_pool_id: 0x2::object::ID,
        turbos_position_nft: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>,
        total_share: u128,
        protocol_assets: 0x2::bag::Bag,
        compounding_assets: 0x2::bag::Bag,
    }

    public(friend) fun add_balance_to_compounding_asset<T0>(arg0: &mut Farm, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.compounding_assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.compounding_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.compounding_assets, v0, arg1);
        };
    }

    public(friend) fun add_balance_to_protocol_asset<T0>(arg0: &mut Farm, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_assets, v0, arg1);
        };
    }

    public(friend) fun add_liquidity_with_return<T0, T1, T2>(arg0: &mut Farm, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _) = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::get_info(arg1);
        assert!(v0 == 0x2::object::id<Farm>(arg0), 101);
        let v2 = get_turbos_position_nft_address(arg0);
        let (_, _, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, v2);
        let (_, v7) = get_info(arg0);
        let v8 = borrow_mut_turbos_position_nft(arg0);
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg2, arg3, arg4, arg5, v8, arg6, arg7, arg8, arg9, 0x2::clock::timestamp_ms(arg10) + 60000, arg10, arg11, arg12);
        let v11 = v10;
        let v12 = v9;
        let (_, _, v15) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, v2);
        let v16 = if (v5 == 0) {
            v15 - v5
        } else {
            v7 * (v15 - v5) / v5
        };
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::increase_share(arg1, v16);
        arg0.total_share = arg0.total_share + v16;
        let v17 = AddLiquidityEventV2{
            sender              : 0x2::tx_context::sender(arg12),
            farm_id             : 0x2::object::id<Farm>(arg0),
            coin_amount_a       : arg6 - 0x2::coin::value<T0>(&v12),
            coin_amount_b       : arg7 - 0x2::coin::value<T1>(&v11),
            old_total_liquidity : v5,
            new_total_liquidity : v15,
            old_total_share     : arg0.total_share,
            new_total_share     : arg0.total_share,
        };
        0x2::event::emit<AddLiquidityEventV2>(v17);
        (v12, v11)
    }

    public(friend) fun borrow_mut_turbos_position_nft(arg0: &mut Farm) : &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.turbos_position_nft)
    }

    public(friend) fun collect_fees_with_return<T0, T1, T2>(arg0: &mut Farm, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, borrow_mut_turbos_position_nft(arg0), 18446744073709551615, 18446744073709551615, arg3, 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg5, arg6)
    }

    public(friend) fun collect_reward_with_return<T0, T1, T2, T3>(arg0: &mut Farm, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg1, arg2, borrow_mut_turbos_position_nft(arg0), arg3, arg4, 18446744073709551615, arg5, 0x2::clock::timestamp_ms(arg6) + 60000, arg6, arg7, arg8)
    }

    public(friend) fun compound<T0, T1, T2>(arg0: &mut Farm, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_compounding_asset_balance<T0>(arg0);
        let v1 = get_compounding_asset_balance<T0>(arg0);
        let (_, _, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, get_turbos_position_nft_address(arg0));
        let v5 = do_take_compounding_asset_balance<T0>(arg0);
        let v6 = 0x2::coin::from_balance<T0>(v5, arg5);
        let v7 = do_take_compounding_asset_balance<T1>(arg0);
        let v8 = 0x2::coin::from_balance<T1>(v7, arg5);
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg1, arg2, 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T0>(v6), 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T1>(v8), 0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.turbos_position_nft), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v8), 0, 0, 0x2::clock::timestamp_ms(arg3) + 60000, arg3, arg4, arg5);
        add_balance_to_compounding_asset<T0>(arg0, 0x2::coin::into_balance<T0>(v9));
        add_balance_to_compounding_asset<T1>(arg0, 0x2::coin::into_balance<T1>(v10));
        let (_, _, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, get_turbos_position_nft_address(arg0));
        let v14 = CompoundEvent{
            sender            : 0x2::tx_context::sender(arg5),
            farm_id           : 0x2::object::id<Farm>(arg0),
            old_liquidity     : v4,
            old_coin_amount_a : v0,
            old_coin_amount_b : v1,
            new_liquidity     : v13,
            new_coin_amount_a : get_compounding_asset_balance<T0>(arg0),
            new_coin_amount_b : get_compounding_asset_balance<T0>(arg0),
        };
        0x2::event::emit<CompoundEvent>(v14);
    }

    public(friend) fun create_farm<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, 0, 0x2::clock::timestamp_ms(arg10) + 60000, arg10, arg11, arg12);
        let v3 = v0;
        let v4 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v3);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_to_address(&v4));
        let v8 = Farm{
            id                  : 0x2::object::new(arg12),
            turbos_pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            turbos_position_nft : 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v3),
            total_share         : v7,
            protocol_assets     : 0x2::bag::new(arg12),
            compounding_assets  : 0x2::bag::new(arg12),
        };
        let v9 = 0x2::object::id<Farm>(&v8);
        0x2::transfer::public_share_object<Farm>(v8);
        let v10 = CreateFarmEvent{
            sender                 : 0x2::tx_context::sender(arg12),
            farm_id                : v9,
            turbos_position_nft_id : v4,
        };
        0x2::event::emit<CreateFarmEvent>(v10);
        (0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::new(v9, v7, arg12), v1, v2)
    }

    public(friend) fun destroy_farm<T0, T1, T2>(arg0: Farm, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        let Farm {
            id                  : v0,
            turbos_pool_id      : _,
            turbos_position_nft : v2,
            total_share         : v3,
            protocol_assets     : v4,
            compounding_assets  : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v4;
        let v8 = v2;
        0x2::object::delete(v0);
        assert!(v3 == 0, 104);
        assert!(0x2::bag::length(&v7) == 0, 105);
        0x2::bag::destroy_empty(v7);
        assert!(0x2::bag::length(&v6) == 0, 106);
        0x2::bag::destroy_empty(v6);
        if (0x1::option::is_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v8)) {
            let v9 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v8);
            let v10 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v9);
            let (_, _, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_to_address(&v10));
            assert!(v13 == 0, 107);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg1, v9, arg2, arg3);
        } else {
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v8);
        };
        let v14 = DestroyFarmEvent{
            sender  : 0x2::tx_context::sender(arg3),
            farm_id : 0x2::object::id<Farm>(&arg0),
        };
        0x2::event::emit<DestroyFarmEvent>(v14);
    }

    public(friend) fun do_distribute_fee_and_reward<T0>(arg0: &mut Farm, arg1: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = v1 * 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::get_info(arg1) / 100000;
        add_balance_to_protocol_asset<T0>(arg0, 0x2::balance::split<T0>(&mut v0, v2));
        add_balance_to_compounding_asset<T0>(arg0, v0);
        let v3 = DistributeFeeAndRewardEvent{
            sender          : 0x2::tx_context::sender(arg3),
            farm_id         : 0x2::object::id<Farm>(arg0),
            coin_type       : 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>(),
            protocol_amount : v2,
            reward_amount   : v1 - v2,
        };
        0x2::event::emit<DistributeFeeAndRewardEvent>(v3);
    }

    public(friend) fun do_take_compounding_asset_balance<T0>(arg0: &mut Farm) : 0x2::balance::Balance<T0> {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.compounding_assets, v0)) {
            0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.compounding_assets, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun do_take_compounding_asset_balance_by_amount<T0>(arg0: &mut Farm, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.compounding_assets, v0) && arg1 > 0) {
            let v2 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.compounding_assets, v0);
            let v3 = 0x2::balance::value<T0>(v2);
            let v4 = if (v3 >= arg1) {
                arg1
            } else {
                v3
            };
            0x2::balance::split<T0>(v2, v4)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun do_take_protocol_asset_balance<T0>(arg0: &mut Farm) : 0x2::balance::Balance<T0> {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_assets, v0)) {
            0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_assets, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun do_take_protocol_asset_balance_by_amount<T0>(arg0: &mut Farm, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_assets, v0) && arg1 > 0) {
            let v2 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_assets, v0);
            let v3 = 0x2::balance::value<T0>(v2);
            let v4 = if (v3 >= arg1) {
                arg1
            } else {
                v3
            };
            0x2::balance::split<T0>(v2, v4)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun get_compounding_asset_balance<T0>(arg0: &Farm) : u64 {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.compounding_assets, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.compounding_assets, v0))
        } else {
            0
        }
    }

    public fun get_compounding_asset_balances_2<T0, T1>(arg0: &Farm) : (u64, u64) {
        (get_compounding_asset_balance<T0>(arg0), get_compounding_asset_balance<T1>(arg0))
    }

    public fun get_compounding_asset_balances_3<T0, T1, T2>(arg0: &Farm) : (u64, u64, u64) {
        (get_compounding_asset_balance<T0>(arg0), get_compounding_asset_balance<T1>(arg0), get_compounding_asset_balance<T2>(arg0))
    }

    public fun get_compounding_asset_balances_4<T0, T1, T2, T3>(arg0: &Farm) : (u64, u64, u64, u64) {
        (get_compounding_asset_balance<T0>(arg0), get_compounding_asset_balance<T1>(arg0), get_compounding_asset_balance<T2>(arg0), get_compounding_asset_balance<T3>(arg0))
    }

    public fun get_info(arg0: &Farm) : (0x2::object::ID, u128) {
        (arg0.turbos_pool_id, arg0.total_share)
    }

    public fun get_info_v2(arg0: &Farm, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions) : (0x2::object::ID, u128, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u128, u64, u64) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, get_turbos_position_nft_address(arg0));
        (arg0.turbos_pool_id, arg0.total_share, v0, v1, v2, 0x2::bag::length(&arg0.protocol_assets), 0x2::bag::length(&arg0.compounding_assets))
    }

    public fun get_protocol_asset_balance<T0>(arg0: &Farm) : u64 {
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_assets, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.protocol_assets, v0))
        } else {
            0
        }
    }

    public fun get_protocol_asset_balances_2<T0, T1>(arg0: &Farm) : (u64, u64) {
        (get_protocol_asset_balance<T0>(arg0), get_protocol_asset_balance<T1>(arg0))
    }

    public fun get_protocol_asset_balances_3<T0, T1, T2>(arg0: &Farm) : (u64, u64, u64) {
        (get_protocol_asset_balance<T0>(arg0), get_protocol_asset_balance<T1>(arg0), get_protocol_asset_balance<T2>(arg0))
    }

    public fun get_protocol_asset_balances_4<T0, T1, T2, T3>(arg0: &Farm) : (u64, u64, u64, u64) {
        (get_protocol_asset_balance<T0>(arg0), get_protocol_asset_balance<T1>(arg0), get_protocol_asset_balance<T2>(arg0), get_protocol_asset_balance<T3>(arg0))
    }

    public fun get_turbos_position_nft_address(arg0: &Farm) : address {
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(0x1::option::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.turbos_position_nft));
        0x2::object::id_to_address(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::permission::new_admin(0x2::tx_context::sender(arg0), arg0);
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::new(5000, arg0);
    }

    public(friend) fun rebalance<T0, T1, T2>(arg0: &mut Farm, arg1: u32, arg2: bool, arg3: u32, arg4: bool, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, get_turbos_position_nft_address(arg0));
        let v3 = 0x1::option::extract<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.turbos_position_nft);
        let v4 = get_compounding_asset_balance<T0>(arg0);
        let v5 = get_compounding_asset_balance<T0>(arg0);
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg5, arg6, &mut v3, v2, 0, 0, 0x2::clock::timestamp_ms(arg7) + 60000, arg7, arg8, arg9);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg6, v3, arg8, arg9);
        add_balance_to_compounding_asset<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        add_balance_to_compounding_asset<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
        let v8 = do_take_compounding_asset_balance<T0>(arg0);
        let v9 = 0x2::coin::from_balance<T0>(v8, arg9);
        let v10 = do_take_compounding_asset_balance<T1>(arg0);
        let v11 = 0x2::coin::from_balance<T1>(v10, arg9);
        let (v12, v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg5, arg6, 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T0>(v9), 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T1>(v11), arg1, arg2, arg3, arg4, 0x2::coin::value<T0>(&v9), 0x2::coin::value<T1>(&v11), 0, 0, 0x2::clock::timestamp_ms(arg7) + 60000, arg7, arg8, arg9);
        0x1::option::fill<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.turbos_position_nft, v12);
        add_balance_to_compounding_asset<T0>(arg0, 0x2::coin::into_balance<T0>(v13));
        add_balance_to_compounding_asset<T1>(arg0, 0x2::coin::into_balance<T1>(v14));
        let (v15, v16, v17) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, get_turbos_position_nft_address(arg0));
        let v18 = RebalanceEvent{
            sender               : 0x2::tx_context::sender(arg9),
            farm_id              : 0x2::object::id<Farm>(arg0),
            old_tick_lower_index : v0,
            old_tick_upper_index : v1,
            old_liquidity        : v2,
            old_coin_amount_a    : v4,
            old_coin_amount_b    : v5,
            new_tick_lower_index : v15,
            new_tick_upper_index : v16,
            new_liquidity        : v17,
            new_coin_amount_a    : get_compounding_asset_balance<T0>(arg0),
            new_coin_amount_b    : get_compounding_asset_balance<T0>(arg0),
        };
        0x2::event::emit<RebalanceEvent>(v18);
    }

    public(friend) fun remove_liquidity_with_return<T0, T1, T2>(arg0: &mut Farm, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, arg2: u128, arg3: u64, arg4: u64, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::get_info(arg1);
        assert!(v0 == 0x2::object::id<Farm>(arg0), 101);
        assert!(arg2 <= v1, 102);
        let v2 = get_turbos_position_nft_address(arg0);
        let (_, _, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, v2);
        let (_, v7) = get_info(arg0);
        let v8 = v5 * arg2 / v7;
        let v9 = borrow_mut_turbos_position_nft(arg0);
        let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg5, arg6, v9, v8, arg3, arg4, 0x2::clock::timestamp_ms(arg7) + 60000, arg7, arg8, arg9);
        let v12 = v11;
        let v13 = v10;
        let (_, _, v16) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, v2);
        assert!(v8 == v5 - v16, 103);
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::decrease_share(arg1, arg2);
        arg0.total_share = arg0.total_share - arg2;
        let v17 = RemoveLiquidityEventV2{
            sender              : 0x2::tx_context::sender(arg9),
            farm_id             : 0x2::object::id<Farm>(arg0),
            coin_amount_a       : 0x2::coin::value<T0>(&v13),
            coin_amount_b       : 0x2::coin::value<T1>(&v12),
            old_total_liquidity : v5,
            new_total_liquidity : v16,
            old_total_share     : arg0.total_share,
            new_total_share     : arg0.total_share,
        };
        0x2::event::emit<RemoveLiquidityEventV2>(v17);
        (v13, v12)
    }

    // decompiled from Move bytecode v6
}

