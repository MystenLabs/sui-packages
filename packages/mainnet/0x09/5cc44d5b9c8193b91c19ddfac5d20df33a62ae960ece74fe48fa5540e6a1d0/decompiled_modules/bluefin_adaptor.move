module 0x95cc44d5b9c8193b91c19ddfac5d20df33a62ae960ece74fe48fa5540e6a1d0::bluefin_adaptor {
    struct PositionRegistry has store, key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
    }

    struct BluefinOpenPosition has drop {
        dummy_field: bool,
    }

    struct BluefinAddLiquidity has drop {
        dummy_field: bool,
    }

    struct BluefinAddLiquidityFixed has drop {
        dummy_field: bool,
    }

    struct BluefinRemoveLiquidity has drop {
        dummy_field: bool,
    }

    struct BluefinClosePosition has drop {
        dummy_field: bool,
    }

    struct BluefinClaimRewards has drop {
        dummy_field: bool,
    }

    struct BluefinClaimFees has drop {
        dummy_field: bool,
    }

    struct BluefinSwap has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1, T2>(arg0: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg1: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let (v3, v4) = if (arg4) {
            let v5 = BluefinSwap{dummy_field: false};
            let v6 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinSwap, T0>(arg0, arg1, v5, arg5, &v2, arg9);
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
            (0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6)), 0x2::balance::zero<T2>())
        } else {
            let v7 = BluefinSwap{dummy_field: false};
            let v8 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T2, BluefinSwap, T0>(arg0, arg1, v7, arg5, &v2, arg9);
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(v8);
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v8)))
        };
        let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg8, arg2, arg3, v3, v4, arg4, true, arg5, arg6, arg7);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T1, T0>(arg0, 0x2::coin::from_balance<T1>(v9, arg9), arg9);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T2, T0>(arg0, 0x2::coin::from_balance<T2>(v10, arg9), arg9);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = 0x2::table::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T2>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg5), arg6, true);
        let v3 = b"";
        let v4 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v4));
        let v5 = 0x1::option::some<vector<u8>>(v3);
        let v6 = BluefinAddLiquidity{dummy_field: false};
        let v7 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinAddLiquidity, T0>(arg1, arg2, v6, v1, &v5, arg8);
        let v8 = BluefinAddLiquidity{dummy_field: false};
        let v9 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T2, BluefinAddLiquidity, T0>(arg1, arg2, v8, v2, &v5, arg8);
        0x1::option::destroy_some<vector<u8>>(v5);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T1, T2>(arg7, arg4, arg5, 0x2::table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3), 0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v7)), 0x2::coin::into_balance<T2>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v9)), arg6);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T1, T0>(arg1, 0x2::coin::from_balance<T1>(v12, arg8), arg8);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T2, T0>(arg1, 0x2::coin::from_balance<T2>(v13, arg8), arg8);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v7);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v9);
    }

    public fun add_liquidity_fixed<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinAddLiquidityFixed{dummy_field: false};
        let v4 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinAddLiquidityFixed, T0>(arg1, arg2, v3, arg6, &v2, arg10);
        let v5 = BluefinAddLiquidityFixed{dummy_field: false};
        let v6 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T2, BluefinAddLiquidityFixed, T0>(arg1, arg2, v5, arg7, &v2, arg10);
        0x1::option::destroy_some<vector<u8>>(v2);
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T1, T2>(arg9, arg4, arg5, 0x2::table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3), 0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4)), 0x2::coin::into_balance<T2>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut v6)), arg6, arg8);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T1, T0>(arg1, 0x2::coin::from_balance<T1>(v9, arg10), arg10);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T2, T0>(arg1, 0x2::coin::from_balance<T2>(v10, arg10), arg10);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T2>>(v6);
    }

    public fun claim_fees<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinClaimFees{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v2);
        let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T2>(arg6, arg4, arg5, 0x2::table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3));
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T1, T0>(arg1, 0x2::coin::from_balance<T1>(v6, arg7), arg7);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T2, T0>(arg1, 0x2::coin::from_balance<T2>(v7, arg7), arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinClaimFees, T0>(arg1, arg2, v3, 0, &v2, arg7));
    }

    public fun claim_rewards<T0, T1, T2, T3>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinClaimRewards{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v2);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T3, T0>(arg1, 0x2::coin::from_balance<T3>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T2, T3>(arg6, arg4, arg5, 0x2::table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3)), arg7), arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinClaimRewards, T0>(arg1, arg2, v3, 0, &v2, arg7));
    }

    public fun close_position<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinClosePosition{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T1, T2>(arg6, arg4, arg5, 0x2::table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3));
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinClosePosition, T0>(arg1, arg2, v3, 0, &v2, arg7));
    }

    public fun get_position(arg0: &PositionRegistry, arg1: 0x2::object::ID) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg1), 0);
        0x2::table::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id        : 0x2::object::new(arg0),
            positions : 0x2::table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0),
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun open_position<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinOpenPosition{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v2);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T2>(arg3, arg4, arg5, arg6, arg7);
        let v5 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v4);
        0x2::table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, v5, v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinOpenPosition, T0>(arg1, arg2, v3, 0, &v2, arg7));
        v5
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut PositionRegistry, arg1: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T0>, arg2: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T0>, arg3: 0x2::object::ID, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 0);
        let v0 = b"";
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BluefinRemoveLiquidity{dummy_field: false};
        0x1::option::destroy_some<vector<u8>>(v2);
        let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T2>(arg4, arg5, 0x2::table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3), arg6, arg7);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T1, T0>(arg1, 0x2::coin::from_balance<T1>(v6, arg8), arg8);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T2, T0>(arg1, 0x2::coin::from_balance<T2>(v7, arg8), arg8);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T1, BluefinRemoveLiquidity, T0>(arg1, arg2, v3, 0, &v2, arg8));
    }

    // decompiled from Move bytecode v6
}

