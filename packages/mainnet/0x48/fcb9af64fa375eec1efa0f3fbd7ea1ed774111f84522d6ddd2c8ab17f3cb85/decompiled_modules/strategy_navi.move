module 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_navi {
    struct NaviCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviConfig has copy, drop, store {
        cap_id: 0x2::object::ID,
        owner: address,
        storage: 0x2::object::ID,
        eearn_asset: u8,
        usdc_asset: u8,
        eearn_decimals: u8,
        usdc_decimals: u8,
        min_health_bps: u64,
        borrow_fee_bps: u64,
        op_dust: u64,
        max_daily_loss_bps: u64,
        loss_window_start_ms: u64,
        loss_window_base: u64,
        loss_window_spent: u64,
    }

    struct NaviOp {
        vault: 0x2::object::ID,
        rate: u64,
        nav_before: u64,
        collateral_before: u64,
        debt_before: u64,
        navi_collateral_before: u64,
        navi_debt_before: u64,
        navi_ltv_before: u64,
        redeeming_before: u64,
    }

    struct NaviAttached has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        storage: 0x2::object::ID,
    }

    struct NaviParamsSet has copy, drop {
        vault: 0x2::object::ID,
        min_health_bps: u64,
        borrow_fee_bps: u64,
        op_dust: u64,
        max_daily_loss_bps: u64,
    }

    struct NaviOpDone has copy, drop {
        vault: 0x2::object::ID,
        nav_before: u64,
        nav_after: u64,
        collateral: u64,
        debt: u64,
        ltv_bps: u64,
        apr_bps: u64,
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::sync_books<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg7);
        sync<T1, T2, T3>(arg0, arg6, arg7);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::deposit<T1, T2, T3>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg7), arg8)
    }

    public fun put_buffer<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: 0x2::coin::Coin<T0>) {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_buffer<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun put_pending<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: 0x2::coin::Coin<T0>) {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_pending<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun request_withdraw<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::WithdrawTicket {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::sync_books<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg7);
        sync<T1, T2, T3>(arg0, arg6, arg7);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::request_withdraw<T1, T2, T3>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg7), arg8)
    }

    public fun take_buffer<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        0x2::coin::from_balance<T0>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_buffer<T0, T1, T2>(arg0, arg3), arg4)
    }

    public fun take_pending<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        0x2::coin::from_balance<T0>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_pending<T0, T1, T2>(arg0, arg3), arg4)
    }

    fun assert_op<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        assert!(arg2.vault == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), 305);
    }

    public fun attach_navi<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::AdminCap, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LegLimits, arg9: &0x2::clock::Clock) {
        let v0 = NaviCapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<NaviCapKey>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0), v0), 300);
        assert!(arg4 != arg5, 313);
        assert!(arg6 <= 18 && arg7 <= 18, 310);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, v1);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1::vector::is_empty<u8>(&v5) && 0x1::vector::is_empty<u8>(&v4), 303);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::add_leg<T0, T1, T2>(arg0, arg1, 2, arg8, arg9);
        let v6 = NaviConfig{
            cap_id               : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg2),
            owner                : v1,
            storage              : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3),
            eearn_asset          : arg4,
            usdc_asset           : arg5,
            eearn_decimals       : arg6,
            usdc_decimals        : arg7,
            min_health_bps       : 10500,
            borrow_fee_bps       : 0,
            op_dust              : 10000,
            max_daily_loss_bps   : 100,
            loss_window_start_ms : 0,
            loss_window_base     : 0,
            loss_window_spent    : 0,
        };
        let v7 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v8 = NaviConfigKey{dummy_field: false};
        0x2::dynamic_field::add<NaviConfigKey, NaviConfig>(v7, v8, v6);
        let v9 = NaviCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<NaviCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v7, v9, arg2);
        let v10 = NaviAttached{
            vault   : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0),
            owner   : v1,
            storage : v6.storage,
        };
        0x2::event::emit<NaviAttached>(v10);
    }

    public fun begin_op<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviOp) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::open_op<T1, T2, T3>(arg0);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::sync_books<T0, T1, T2, T3>(arg0, arg4, arg5, arg6, arg7);
        sync<T1, T2, T3>(arg0, arg3, arg7);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg2);
        let v1 = NaviOp{
            vault                  : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            rate                   : v0,
            nav_before             : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::nav<T1, T2, T3>(arg0, v0, 0x2::clock::timestamp_ms(arg7)),
            collateral_before      : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::collateral<T1, T2, T3>(arg0),
            debt_before            : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::debt<T1, T2, T3>(arg0),
            navi_collateral_before : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_collateral<T1, T2, T3>(arg0, 2),
            navi_debt_before       : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_debt<T1, T2, T3>(arg0, 2),
            navi_ltv_before        : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_ltv_bps<T1, T2, T3>(arg0, 2, v0),
            redeeming_before       : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::redeeming<T1, T2, T3>(arg0),
        };
        let v2 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T1, T2, T3>(arg0);
        let v3 = NaviCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<NaviCapKey>(v2, v3), 301);
        let v4 = NaviCapKey{dummy_field: false};
        (0x2::dynamic_object_field::remove<NaviCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v2, v4), v1)
    }

    fun config<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : &NaviConfig {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0);
        let v1 = NaviConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<NaviConfigKey>(v0, v1), 301);
        let v2 = NaviConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow<NaviConfigKey, NaviConfig>(v0, v2)
    }

    fun config_mut<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : &mut NaviConfig {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v1 = NaviConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<NaviConfigKey>(v0, v1), 301);
        let v2 = NaviConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<NaviConfigKey, NaviConfig>(v0, v2)
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun end_op<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: NaviOp, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let NaviOp {
            vault                  : v0,
            rate                   : v1,
            nav_before             : v2,
            collateral_before      : v3,
            debt_before            : v4,
            navi_collateral_before : v5,
            navi_debt_before       : v6,
            navi_ltv_before        : v7,
            redeeming_before       : v8,
        } = arg2;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0), 305);
        let v9 = *config<T1, T2, T3>(arg0);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1) == v9.cap_id, 306);
        let v10 = NaviCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<NaviCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T1, T2, T3>(arg0), v10, arg1);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::sync_books<T0, T1, T2, T3>(arg0, arg5, arg6, arg7, arg8);
        sync<T1, T2, T3>(arg0, arg3, arg8);
        let v11 = 0x2::clock::timestamp_ms(arg8);
        let v12 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::nav<T1, T2, T3>(arg0, v1, v11);
        let v13 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::collateral<T1, T2, T3>(arg0);
        let v14 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_collateral<T1, T2, T3>(arg0, 2);
        let v15 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_debt<T1, T2, T3>(arg0, 2);
        let v16 = if (v15 > v6) {
            v15 - v6
        } else {
            0
        };
        let v17 = if (v3 > v13) {
            v3 - v13
        } else {
            0
        };
        let v18 = if (0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::redeeming<T1, T2, T3>(arg0) > v8) {
            0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::redeeming<T1, T2, T3>(arg0) - v8
        } else {
            0
        };
        let v19 = (0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::receipt_value(v17, v1) as u64);
        let v20 = if (v19 > v18) {
            v19 - v18
        } else {
            0
        };
        assert!((v12 as u128) + (mul_div_up(v16, v9.borrow_fee_bps, 10000) as u128) + (mul_div_up(v20, 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::max_exit_slippage<T1, T2, T3>(arg0), 10000) as u128) + (v9.op_dust as u128) >= (v2 as u128), 307);
        if (v12 < v2) {
            spend_loss_budget<T1, T2, T3>(arg0, v2, v2 - v12, v11);
        };
        let v21 = v15 > v6;
        if (v21) {
            assert!(!0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_paused<T1, T2, T3>(arg0), 309);
            if (0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_derisk<T1, T2, T3>(arg0) || !0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_enabled<T1, T2, T3>(arg0, 2)) {
                assert!(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::debt<T1, T2, T3>(arg0) <= v4, 309);
            };
        };
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::check_leg_after_sync<T1, T2, T3>(arg0, 2, v1, !v21, v7);
        if (v15 > 0 && (v21 || v14 < v5)) {
            assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg8, arg3, arg4, v9.owner) >= (v9.min_health_bps as u256) * 1000000000000000000000000000 / (10000 as u256), 308);
        };
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::close_op<T1, T2, T3>(arg0);
        let v22 = NaviOpDone{
            vault      : v0,
            nav_before : v2,
            nav_after  : v12,
            collateral : v14,
            debt       : v15,
            ltv_bps    : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_ltv_bps<T1, T2, T3>(arg0, 2, v1),
            apr_bps    : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::leg_borrow_apr_bps<T1, T2, T3>(arg0, 2),
        };
        0x2::event::emit<NaviOpDone>(v22);
    }

    fun from_navi(arg0: u256, arg1: u8, arg2: bool) : u64 {
        let v0 = if (arg1 == 9) {
            arg0
        } else if (arg1 < 9) {
            if (arg2) {
                div_up(arg0, pow10(9 - arg1))
            } else {
                arg0 / pow10(9 - arg1)
            }
        } else {
            arg0 * pow10(arg1 - 9)
        };
        (v0 as u64)
    }

    public fun from_suilend<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::ReduceTicket) : (u64, u64) {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::consume_reduce_ticket<T0, T1, T2>(arg0, arg3)
    }

    public fun into_suilend<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_op<T1, T2, T3>(arg0, arg1, arg2);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::deposit_and_borrow<T0, T1, T2, T3>(arg0, arg3, arg4, arg2.rate, arg5, arg6, arg7, arg8, arg9)
    }

    public fun is_attached<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : bool {
        let v0 = NaviConfigKey{dummy_field: false};
        0x2::dynamic_field::exists<NaviConfigKey>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0), v0)
    }

    public fun leg() : u64 {
        2
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 == 0) {
            0
        } else {
            (((v0 - 1) / (arg2 as u128) + 1) as u64)
        }
    }

    public fun owner<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : address {
        config<T0, T1, T2>(arg0).owner
    }

    public fun params<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : (u64, u64, u64, u64, u64) {
        let v0 = config<T0, T1, T2>(arg0);
        (v0.min_health_bps, v0.borrow_fee_bps, v0.op_dust, v0.max_daily_loss_bps, v0.loss_window_spent)
    }

    public fun position<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = *config<T0, T1, T2>(arg0);
        read(&v0, arg1, arg2)
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun read(arg0: &NaviConfig, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.storage, 302);
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg1, arg0.owner);
        let v2 = v1;
        let v3 = v0;
        let v4 = &v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(v4)) {
            assert!(*0x1::vector::borrow<u8>(v4, v5) == arg0.eearn_asset, 304);
            v5 = v5 + 1;
        };
        let v6 = &v2;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(v6)) {
            assert!(*0x1::vector::borrow<u8>(v6, v7) == arg0.usdc_asset, 304);
            v7 = v7 + 1;
        };
        let (v8, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.eearn_asset, arg0.owner);
        let (_, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.usdc_asset, arg0.owner);
        let (v12, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.eearn_asset);
        let (_, v15) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.usdc_asset);
        (from_navi(v8 * v12 / 1000000000000000000000000000, arg0.eearn_decimals, false), from_navi(div_up(v11 * v15, 1000000000000000000000000000), arg0.usdc_decimals, true))
    }

    public fun redeem<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &NaviOp, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_op<T0, T1, T2>(arg0, arg1, arg2);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 312);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T1>(arg3), 0x2::object::id_address<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), arg6, arg7);
        let (_, _, _, v4, _, _) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::decode_withdrawal_request(&v0);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::add_redeeming<T0, T1, T2>(arg0, v4);
    }

    public fun set_navi_params<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 >= 10100 && arg2 <= 2 * 10000, 310);
        assert!(arg3 <= 100, 310);
        assert!(arg4 <= 1000000, 310);
        assert!(arg5 <= 300, 310);
        let v0 = 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0);
        let v1 = config_mut<T0, T1, T2>(arg0);
        v1.min_health_bps = arg2;
        v1.borrow_fee_bps = arg3;
        v1.op_dust = arg4;
        v1.max_daily_loss_bps = arg5;
        let v2 = NaviParamsSet{
            vault              : v0,
            min_health_bps     : arg2,
            borrow_fee_bps     : arg3,
            op_dust            : arg4,
            max_daily_loss_bps : arg5,
        };
        0x2::event::emit<NaviParamsSet>(v2);
    }

    fun spend_loss_budget<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = config_mut<T0, T1, T2>(arg0);
        if (v0.loss_window_base == 0 || arg3 >= v0.loss_window_start_ms + 86400000) {
            v0.loss_window_start_ms = arg3;
            v0.loss_window_base = arg1;
            v0.loss_window_spent = 0;
        };
        v0.loss_window_spent = v0.loss_window_spent + arg2;
        assert!(v0.loss_window_spent <= mul_div_up(v0.loss_window_base, v0.max_daily_loss_bps, 10000) + v0.op_dust, 311);
    }

    public fun storage_id<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : 0x2::object::ID {
        config<T0, T1, T2>(arg0).storage
    }

    fun sync<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) {
        let v0 = *config<T0, T1, T2>(arg0);
        let (v1, v2) = read(&v0, arg1, arg2);
        let (_, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_current_rate(arg1, v0.usdc_asset);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::sync_leg_with_apr<T0, T1, T2>(arg0, 2, v1, v2, ((v4 * (10000 as u256) / 1000000000000000000000000000) as u64), 0x2::clock::timestamp_ms(arg2));
    }

    public fun sync_books<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) {
        sync<T0, T1, T2>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

