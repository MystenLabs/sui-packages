module 0xf4a1d2ad2302e20763171d01f1fb61fc62dbb2601177bc5d58809c88556c2900::migration_script {
    struct PositionDirectory has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionKeys has copy, drop, store {
        position_id: 0x2::object::ID,
    }

    struct MigrateEvents has copy, drop, store {
        dummy_field: bool,
    }

    struct MigrateToTreasuryEvents has copy, drop, store {
        dummy_field: bool,
    }

    struct MigrateToCetusEvents has copy, drop, store {
        dummy_field: bool,
    }

    struct MigrationManager has store, key {
        id: 0x2::object::UID,
        fields: 0x2::bag::Bag,
    }

    struct Migrate has copy, drop, store {
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct MigrateToTreasury has copy, drop, store {
        position_id: 0x2::object::ID,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct MigrateToCetus has copy, drop, store {
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        manager: 0x2::object::ID,
    }

    struct TotalMigrated has copy, drop, store {
        amount_a: u64,
        amount_b: u64,
    }

    struct TotalMigratedToTreasury has copy, drop, store {
        amount_a: u64,
        amount_b: u64,
    }

    public fun borrow<T0: store>(arg0: &mut MigrationManager, arg1: &AdminCap, arg2: 0x2::object::ID) : &T0 {
        assert_admin(arg0, arg1);
        let v0 = PositionKeys{position_id: arg2};
        0x2::bag::borrow<PositionKeys, T0>(&arg0.fields, v0)
    }

    fun repay_add_liquidity<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg4);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, v1, arg7)), arg4);
    }

    fun assert_admin(arg0: &MigrationManager, arg1: &AdminCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.manager, 0);
    }

    public fun compute_migrated(arg0: &MigrationManager, arg1: &AdminCap) {
        let (v0, v1) = compute_migrated_(arg0, arg1);
        let v2 = TotalMigrated{
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<TotalMigrated>(v2);
    }

    fun compute_migrated_(arg0: &MigrationManager, arg1: &AdminCap) : (u64, u64) {
        assert_admin(arg0, arg1);
        let v0 = MigrateEvents{dummy_field: false};
        let v1 = 0x2::bag::borrow<MigrateEvents, vector<Migrate>>(&arg0.fields, v0);
        let v2 = 0x1::vector::length<Migrate>(v1);
        let v3 = 0;
        let v4 = 0;
        while (v2 > 0) {
            let v5 = 0x1::vector::borrow<Migrate>(v1, v2 - 1);
            v3 = v3 + v5.amount_a;
            v4 = v4 + v5.amount_b;
            v2 = v2 - 1;
        };
        (v3, v4)
    }

    public fun compute_migrated_to_treasury(arg0: &MigrationManager, arg1: &AdminCap) {
        let (v0, v1) = compute_migrated_to_treasury_(arg0, arg1);
        let v2 = TotalMigratedToTreasury{
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<TotalMigratedToTreasury>(v2);
    }

    fun compute_migrated_to_treasury_(arg0: &MigrationManager, arg1: &AdminCap) : (u64, u64) {
        assert_admin(arg0, arg1);
        let v0 = MigrateToTreasuryEvents{dummy_field: false};
        let v1 = 0x2::bag::borrow<MigrateToTreasuryEvents, vector<MigrateToTreasury>>(&arg0.fields, v0);
        let v2 = 0x1::vector::length<MigrateToTreasury>(v1);
        let v3 = 0;
        let v4 = 0;
        while (v2 > 0) {
            let v5 = 0x1::vector::borrow<MigrateToTreasury>(v1, v2 - 1);
            v3 = v3 + v5.amount_a;
            v4 = v4 + v5.amount_b;
            v2 = v2 - 1;
        };
        (v3, v4)
    }

    public fun directory(arg0: &mut MigrationManager, arg1: &AdminCap) : &vector<0x2::object::ID> {
        assert_admin(arg0, arg1);
        let v0 = PositionDirectory{dummy_field: false};
        0x2::bag::borrow<PositionDirectory, vector<0x2::object::ID>>(&arg0.fields, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MigrationManager{
            id     : 0x2::object::new(arg0),
            fields : 0x2::bag::new(arg0),
        };
        let v1 = AdminCap{
            id      : 0x2::object::new(arg0),
            manager : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = PositionDirectory{dummy_field: false};
        0x2::bag::add<PositionDirectory, vector<0x2::object::ID>>(&mut v0.fields, v2, 0x1::vector::empty<0x2::object::ID>());
        let v3 = MigrateToCetusEvents{dummy_field: false};
        0x2::bag::add<MigrateToCetusEvents, vector<MigrateToCetus>>(&mut v0.fields, v3, 0x1::vector::empty<MigrateToCetus>());
        let v4 = MigrateToTreasuryEvents{dummy_field: false};
        0x2::bag::add<MigrateToTreasuryEvents, vector<MigrateToTreasury>>(&mut v0.fields, v4, 0x1::vector::empty<MigrateToTreasury>());
        let v5 = MigrateEvents{dummy_field: false};
        0x2::bag::add<MigrateEvents, vector<Migrate>>(&mut v0.fields, v5, 0x1::vector::empty<Migrate>());
        0x2::transfer::public_transfer<AdminCap>(v1, @0xf3fab23da0ce35a901f995dc8da5f4492ad78510ed33b3422417609d22730e7d);
        0x2::transfer::public_share_object<MigrationManager>(v0);
    }

    public fun meme_decimals(arg0: u64) : u64 {
        arg0 * 100000
    }

    public fun migrate<T0, T1, T2>(arg0: &mut MigrationManager, arg1: &AdminCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u64, arg6: u64, arg7: u64, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_admin(arg0, arg1);
        let (v0, v1, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), (arg5 as u128), (arg6 as u128)) + (arg7 as u128), arg5, arg6, 0x2::clock::timestamp_ms(arg9), arg9, arg8, arg10);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, v3);
        let v6 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v6, v4);
        let (v7, v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg2, arg3, v5, v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v1), arg5, arg6, arg5, arg6, 0x2::clock::timestamp_ms(arg9), arg9, arg8, arg10);
        let v10 = v7;
        let v11 = PositionDirectory{dummy_field: false};
        0x1::vector::push_back<0x2::object::ID>(0x2::bag::borrow_mut<PositionDirectory, vector<0x2::object::ID>>(&mut arg0.fields, v11), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v10));
        let (v12, v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v10));
        assert!(v0 == v12, 10);
        assert!(v1 == v13, 11);
        let v15 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v10);
        let v16 = PositionKeys{position_id: v15};
        0x2::bag::add<PositionKeys, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.fields, v16, v10);
        0x2::coin::destroy_zero<T0>(v8);
        0x2::coin::destroy_zero<T1>(v9);
        let v17 = Migrate{
            old_position_id  : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(arg4),
            new_position_id  : v15,
            tick_lower_index : v12,
            tick_upper_index : v13,
            liquidity_delta  : v14,
            amount_a         : arg5,
            amount_b         : arg6,
        };
        0x2::event::emit<Migrate>(v17);
        let v18 = MigrateEvents{dummy_field: false};
        0x1::vector::push_back<Migrate>(0x2::bag::borrow_mut<MigrateEvents, vector<Migrate>>(&mut arg0.fields, v18), v17);
        let (v19, v20) = compute_migrated_(arg0, arg1);
        assert!(v19 <= meme_decimals(100000000000) * 50 / 1000, 2);
        assert!(v20 <= 0, 3);
        v15
    }

    public fun migrate_to_cetus<T0, T1, T2>(arg0: &mut MigrationManager, arg1: &AdminCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert_admin(arg0, arg1);
        let (v0, v1, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), (arg7 as u128), (arg8 as u128)) + (arg9 as u128), arg7, arg8, 0x2::clock::timestamp_ms(arg11), arg11, arg10, arg12);
        let v5 = v4;
        let v6 = v3;
        let v7 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v0)))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v0)
        };
        let v8 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v1)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v1)))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v1)
        };
        let v9 = &mut v6;
        let v10 = &mut v5;
        let v11 = open_position_with_liquidity_by_fix_coin_inner<T0, T1>(arg5, arg6, v9, v10, v7, v8, arg7, arg8, true, arg11, arg12);
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v11);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v0)) == v12, 10);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1)) == v13, 11);
        0x2::coin::destroy_zero<T0>(v6);
        0x2::coin::destroy_zero<T1>(v5);
        let v14 = MigrateToCetus{
            old_position_id  : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(arg4),
            new_position_id  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v11),
            tick_lower_index : v12,
            tick_upper_index : v13,
            liquidity_delta  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v11),
            amount_a         : arg7,
            amount_b         : arg8,
        };
        0x2::event::emit<MigrateToCetus>(v14);
        let v15 = MigrateToCetusEvents{dummy_field: false};
        0x1::vector::push_back<MigrateToCetus>(0x2::bag::borrow_mut<MigrateToCetusEvents, vector<MigrateToCetus>>(&mut arg0.fields, v15), v14);
        v11
    }

    public fun migrate_to_treasury<T0, T1, T2>(arg0: &mut MigrationManager, arg1: &AdminCap, arg2: address, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: u64, arg7: u64, arg8: u64, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5);
        let (v1, v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v0);
        let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg3, arg4, arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), (arg6 as u128), (arg7 as u128)) + (arg8 as u128), arg6, arg7, 0x2::clock::timestamp_ms(arg10), arg10, arg9, arg11);
        let v6 = v4;
        assert!(arg2 == @0xcd80041d73cea403348707172bef8a15349d8cbfa6e445a361e946147f9999a2, 6);
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v0);
        0x2::coin::destroy_zero<T1>(v5);
        let v10 = MigrateToTreasury{
            position_id      : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(arg5),
            tick_lower_index : v1,
            tick_upper_index : v2,
            liquidity_delta  : v9,
            amount_a         : arg6,
            amount_b         : arg7,
        };
        0x2::event::emit<MigrateToTreasury>(v10);
        let v11 = MigrateToTreasuryEvents{dummy_field: false};
        0x1::vector::push_back<MigrateToTreasury>(0x2::bag::borrow_mut<MigrateToTreasuryEvents, vector<MigrateToTreasury>>(&mut arg0.fields, v11), v10);
        let (v12, v13) = compute_migrated_to_treasury_(arg0, arg1);
        assert!(0x2::coin::value<T0>(&v6) <= meme_decimals(100000000000) * 75 / 1000, 4);
        assert!(v12 <= meme_decimals(100000000000) * 75 / 1000, 5);
        assert!(v13 <= 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg2);
    }

    fun open_position_with_liquidity_by_fix_coin_inner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg4, arg5, arg10);
        let v1 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, v1, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg2, arg3, arg0, arg1, v2, arg6, arg7, arg10);
        v0
    }

    public fun sui_decimals(arg0: u64) : u64 {
        arg0 * 1000000000
    }

    // decompiled from Move bytecode v6
}

