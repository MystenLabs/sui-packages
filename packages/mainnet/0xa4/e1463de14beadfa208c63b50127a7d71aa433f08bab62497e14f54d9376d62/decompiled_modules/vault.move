module 0xdd017b83eb244567c53538ce49b0855c28e1465412444203a87c4eea480655f8::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        bm_id: 0x2::object::ID,
    }

    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionOpened has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        deposited_a: u64,
        deposited_b: u64,
    }

    struct PositionClosed has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_removed: u128,
        removed_a: u64,
        removed_b: u64,
        fee_a: u64,
        fee_b: u64,
    }

    struct RewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        amount: u64,
    }

    public fun new(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            bm_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    fun assert_bm(arg0: &Vault, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        assert!(arg0.bm_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1), 101);
    }

    fun assert_owner(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 100);
    }

    fun available(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        min_u64(v0, arg2)
    }

    public fun bm_id(arg0: &Vault) : 0x2::object::ID {
        arg0.bm_id
    }

    public fun close<T0, T1>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg5);
        assert_bm(arg0, arg2);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 103);
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2);
        let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg1, &mut v2, v3, arg4);
        let v8 = v7;
        let v9 = v6;
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg3, arg1, &mut v2);
        let v14 = v13;
        let v15 = v12;
        0x2::balance::join<T0>(&mut v9, v15);
        0x2::balance::join<T1>(&mut v8, v14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg2, 0x2::coin::from_balance<T0>(v9, arg5), arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v8, arg5), arg5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg3, arg1, v2);
        let v16 = PositionClosed{
            vault_id          : 0x2::object::id<Vault>(arg0),
            pool_id           : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v2),
            position_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v2),
            liquidity_removed : v3,
            removed_a         : 0x2::balance::value<T0>(&v9),
            removed_b         : 0x2::balance::value<T1>(&v8),
            fee_a             : 0x2::balance::value<T0>(&v15),
            fee_b             : 0x2::balance::value<T1>(&v14),
        };
        0x2::event::emit<PositionClosed>(v16);
    }

    public fun collect_rewards<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg5);
        assert_bm(arg0, arg2);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 103);
        if (!0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg1)) {
            return
        };
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg3, arg1, v2);
        let v4 = 0x2::balance::value<T2>(&v3);
        if (v4 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg2, 0x2::coin::from_balance<T2>(v3, arg5), arg5);
            let v5 = RewardCollected{
                vault_id    : 0x2::object::id<Vault>(arg0),
                position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v2),
                reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
                amount      : v4,
            };
            0x2::event::emit<RewardCollected>(v5);
        } else {
            0x2::balance::destroy_zero<T2>(v3);
        };
    }

    public fun has_position(arg0: &Vault) : bool {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0)
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun open<T0, T1>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg14);
        assert_bm(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg13, 104);
        let v0 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 102);
        let v1 = available(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg9, arg11);
        let v2 = available(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), arg10, arg12);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1);
        let v7 = if (arg8) {
            min_u64(arg7, v1)
        } else {
            min_u64(arg7, v2)
        };
        let (_, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v3, v4, v6, v5, v7, arg8);
        let (v11, v12) = if (arg8 && v10 > v2 || !arg8 && v9 > v1) {
            let v13 = if (arg8) {
                v2
            } else {
                v1
            };
            let (_, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v3, v4, v6, v5, v13, !arg8);
            (v15, v16)
        } else {
            (v9, v10)
        };
        assert!(v11 <= v1 && v12 <= v2, 105);
        let v17 = min_u64(v11 + v11 / 1000 + 2, v1);
        let v18 = min_u64(v12 + v12 / 1000 + 2, v2);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg1, arg5, arg6, arg14);
        let v20 = if (arg8) {
            v11
        } else {
            v12
        };
        let (_, _, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg4, arg3, arg1, &mut v19, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg2, v17, arg14)), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v18, arg14)), v20, arg8);
        let v25 = v24;
        let v26 = v23;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg2, 0x2::coin::from_balance<T0>(v26, arg14), arg14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v25, arg14), arg14);
        let v27 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v27, v19);
        let v28 = PositionOpened{
            vault_id    : 0x2::object::id<Vault>(arg0),
            pool_id     : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v19),
            position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v19),
            tick_lower  : arg5,
            tick_upper  : arg6,
            liquidity   : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v19),
            deposited_a : v17 - 0x2::balance::value<T0>(&v26),
            deposited_b : v18 - 0x2::balance::value<T1>(&v25),
        };
        0x2::event::emit<PositionOpened>(v28);
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

