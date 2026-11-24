module 0x5ec95b86aec0b1b3b3277383713ee1815a49303b16216d90688dbda5c8cb710a::vault {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        shares_minted: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        amount_a_returned: u64,
        amount_b_returned: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        operator: address,
        old_lower_tick: u32,
        old_upper_tick: u32,
        new_lower_tick: u32,
        new_upper_tick: u32,
        timestamp_ms: u64,
    }

    struct FeeHarvestedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        gross_fee_a: u64,
        gross_fee_b: u64,
        performance_fee_a: u64,
        performance_fee_b: u64,
        compounded_amount_a: u64,
        compounded_amount_b: u64,
    }

    struct PerformanceFeePaidEvent has copy, drop {
        vault_id: 0x2::object::ID,
        treasury: address,
        fee_a: u64,
        fee_b: u64,
    }

    struct OperatorUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        new_operator: address,
    }

    struct VersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExpectedPosKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RebalanceReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
    }

    struct DepositLiquidityReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
    }

    struct WithdrawLiquidityReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        shares_burned: u64,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        total_shares: u64,
        fee_rate_bps: u64,
        fee_treasury: address,
        clmm_position_id: 0x1::option::Option<0x2::object::ID>,
        current_lower_tick: u32,
        current_upper_tick: u32,
        is_rebalancing: bool,
    }

    struct VaultShare<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    fun absorb_pro_rata_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: u128, arg4: u128) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v2 = if (v0 == 0) {
            0
        } else {
            (((arg3 * (v0 as u128) + arg4 - 1) / arg4) as u64)
        };
        let v3 = if (v1 == 0) {
            0
        } else {
            (((arg3 * (v1 as u128) + arg4 - 1) / arg4) as u64)
        };
        assert!(0x2::balance::value<T0>(arg1) >= v2 && 0x2::balance::value<T1>(arg2) >= v3, 13);
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(arg1, v2));
        };
        if (v3 > 0) {
            0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::balance::split<T1>(arg2, v3));
        };
        (v2, v3)
    }

    public fun admin_cap_vault_id(arg0: &VaultAdminCap) : 0x2::object::ID {
        arg0.vault_id
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VersionKey>(&arg0.id, v0)) {
            let v1 = VersionKey{dummy_field: false};
            assert!(*0x2::dynamic_field::borrow<VersionKey, u64>(&arg0.id, v1) == 4, 16);
        };
    }

    public fun balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun borrow_position<T0, T1, T2: store + key>(arg0: &Vault<T0, T1>) : &T2 {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PositionKey, T2>(&arg0.id, v0)
    }

    public fun clmm_position_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.clmm_position_id
    }

    public fun create_vault<T0, T1>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 2500, 4);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                 : v0,
            balance_a          : 0x2::balance::zero<T0>(),
            balance_b          : 0x2::balance::zero<T1>(),
            total_shares       : 0,
            fee_rate_bps       : arg0,
            fee_treasury       : arg1,
            clmm_position_id   : 0x1::option::none<0x2::object::ID>(),
            current_lower_tick : 0,
            current_upper_tick : 0,
            is_rebalancing     : false,
        };
        let v3 = VersionKey{dummy_field: false};
        0x2::dynamic_field::add<VersionKey, u64>(&mut v2.id, v3, 4);
        let v4 = VaultAdminCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v5 = OperatorCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v6 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<VaultAdminCap>(v4, v6);
        0x2::transfer::transfer<OperatorCap>(v5, v6);
        0x2::transfer::share_object<Vault<T0, T1>>(v2);
    }

    public fun create_vault_default<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_vault<T0, T1>(1000, arg0, arg1);
    }

    public fun current_ticks<T0, T1>(arg0: &Vault<T0, T1>) : (u32, u32) {
        (arg0.current_lower_tick, arg0.current_upper_tick)
    }

    public fun current_version() : u64 {
        4
    }

    public fun default_fee_bps() : u64 {
        1000
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : VaultShare<T0, T1> {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 11);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 || v2 > 0, 1);
        let v3 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v4 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v5 = if (arg0.total_shares == 0) {
            let v6 = v1 + v2;
            assert!(v6 > 1000, 13);
            arg0.total_shares = 1000;
            v6 - 1000
        } else if (v3 > 0 && v4 > 0) {
            assert!(v1 > 0 && v2 > 0, 1);
            let v7 = (((v1 as u128) * (arg0.total_shares as u128) / (v3 as u128)) as u64);
            let v8 = (((v2 as u128) * (arg0.total_shares as u128) / (v4 as u128)) as u64);
            if (v7 < v8) {
                v7
            } else {
                v8
            }
        } else if (v3 > 0) {
            (((v1 as u128) * (arg0.total_shares as u128) / (v3 as u128)) as u64)
        } else {
            (((v2 as u128) * (arg0.total_shares as u128) / (v4 as u128)) as u64)
        };
        assert!(v5 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        arg0.total_shares = arg0.total_shares + v5;
        let v9 = 0x2::object::uid_to_inner(&arg0.id);
        let v10 = DepositEvent{
            vault_id      : v9,
            depositor     : 0x2::tx_context::sender(arg3),
            shares_minted : v5,
            amount_a      : v1,
            amount_b      : v2,
        };
        0x2::event::emit<DepositEvent>(v10);
        VaultShare<T0, T1>{
            id       : 0x2::object::new(arg3),
            vault_id : v9,
            shares   : v5,
        }
    }

    public fun deposit_cetus_active<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (VaultShare<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 13);
        assert!(arg0.total_shares > 0, 13);
        assert!(arg5 > 0, 1);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = 0x2::coin::into_balance<T1>(arg4);
        let v3 = PositionKey{dummy_field: false};
        let v4 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v4), 14);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        assert!(v5 > 0, 13);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, v4, arg5, arg6, arg8);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v1, v7), 0x2::balance::split<T1>(&mut v2, v8), v6);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        assert!(v9 > v5, 1);
        let v10 = v9 - v5;
        let v11 = &mut v1;
        let v12 = &mut v2;
        let (v13, v14) = absorb_pro_rata_idle<T0, T1>(arg0, v11, v12, v10, v5);
        let v15 = ((v10 * (arg0.total_shares as u128) / v5) as u64);
        assert!(v15 > 0, 2);
        assert!(v15 >= arg7, 15);
        arg0.total_shares = arg0.total_shares + v15;
        let v16 = 0x2::object::uid_to_inner(&arg0.id);
        let v17 = DepositEvent{
            vault_id      : v16,
            depositor     : 0x2::tx_context::sender(arg9),
            shares_minted : v15,
            amount_a      : v7 + v13,
            amount_b      : v8 + v14,
        };
        0x2::event::emit<DepositEvent>(v17);
        let v18 = VaultShare<T0, T1>{
            id       : 0x2::object::new(arg9),
            vault_id : v16,
            shares   : v15,
        };
        (v18, 0x2::coin::from_balance<T0>(v1, arg9), 0x2::coin::from_balance<T1>(v2, arg9))
    }

    public fun deposit_position<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: T2) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0), 11);
        arg1.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&arg2));
        let v1 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg1.id, v1, arg2);
    }

    public fun deposit_turbos_active<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) : (VaultShare<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 13);
        assert!(arg0.total_shares > 0, 13);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        assert!(v1 > 0 || v2 > 0, 1);
        let v3 = PositionKey{dummy_field: false};
        let v4 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.id, v3);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(v4), 14);
        let v5 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v4);
        let v6 = 0x2::object::id_to_address(&v5);
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, v6);
        assert!(v9 > 0, 13);
        let v10 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v10, arg3);
        let v11 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v11, arg4);
        let (v12, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg1, arg2, v10, v11, v4, arg5, arg6, 0, 0, arg8, arg9, arg10, arg11);
        let (_, _, v16) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, v6);
        assert!(v16 > v9, 1);
        let v17 = v16 - v9;
        let v18 = 0x2::coin::into_balance<T1>(v13);
        let v19 = 0x2::coin::into_balance<T0>(v12);
        let v20 = &mut v19;
        let v21 = &mut v18;
        let (_, _) = absorb_pro_rata_idle<T0, T1>(arg0, v20, v21, v17, v9);
        let v24 = ((v17 * (arg0.total_shares as u128) / v9) as u64);
        assert!(v24 > 0, 2);
        assert!(v24 >= arg7, 15);
        arg0.total_shares = arg0.total_shares + v24;
        let v25 = 0x2::object::uid_to_inner(&arg0.id);
        let v26 = 0x2::balance::value<T0>(&v19);
        let v27 = 0x2::balance::value<T1>(&v18);
        let v28 = if (v1 >= v26) {
            v1 - v26
        } else {
            0
        };
        let v29 = if (v2 >= v27) {
            v2 - v27
        } else {
            0
        };
        let v30 = DepositEvent{
            vault_id      : v25,
            depositor     : 0x2::tx_context::sender(arg11),
            shares_minted : v24,
            amount_a      : v28,
            amount_b      : v29,
        };
        0x2::event::emit<DepositEvent>(v30);
        let v31 = VaultShare<T0, T1>{
            id       : 0x2::object::new(arg11),
            vault_id : v25,
            shares   : v24,
        };
        (v31, 0x2::coin::from_balance<T0>(v19, arg11), 0x2::coin::from_balance<T1>(v18, arg11))
    }

    public fun fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fee_rate_bps
    }

    public fun fee_treasury<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.fee_treasury
    }

    public fun finish_deposit_liquidity<T0, T1, T2: store + key>(arg0: &mut Vault<T0, T1>, arg1: DepositLiquidityReceipt<T0, T1>, arg2: T2, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : VaultShare<T0, T1> {
        let DepositLiquidityReceipt { vault_id: v0 } = arg1;
        assert_version<T0, T1>(arg0);
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 12);
        assert!(arg0.is_rebalancing, 10);
        assert!(arg7 > 0, 2);
        let v1 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v1), 11);
        let v2 = ExpectedPosKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExpectedPosKey>(&arg0.id, v2), 12);
        let v3 = ExpectedPosKey{dummy_field: false};
        assert!(0x2::object::id<T2>(&arg2) == 0x2::dynamic_field::remove<ExpectedPosKey, 0x2::object::ID>(&mut arg0.id, v3), 12);
        arg0.is_rebalancing = false;
        arg0.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&arg2));
        let v4 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg0.id, v4, arg2);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg4));
        arg0.total_shares = arg0.total_shares + arg7;
        let v5 = DepositEvent{
            vault_id      : v0,
            depositor     : 0x2::tx_context::sender(arg8),
            shares_minted : arg7,
            amount_a      : arg5,
            amount_b      : arg6,
        };
        0x2::event::emit<DepositEvent>(v5);
        VaultShare<T0, T1>{
            id       : 0x2::object::new(arg8),
            vault_id : v0,
            shares   : arg7,
        }
    }

    public fun finish_rebalance<T0, T1, T2: store + key>(arg0: &mut Vault<T0, T1>, arg1: RebalanceReceipt<T0, T1>, arg2: 0x1::option::Option<T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let RebalanceReceipt { vault_id: v0 } = arg1;
        assert_version<T0, T1>(arg0);
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 12);
        assert!(arg0.is_rebalancing, 10);
        arg0.is_rebalancing = false;
        if (0x1::option::is_some<T2>(&arg2)) {
            let v1 = 0x1::option::destroy_some<T2>(arg2);
            let v2 = PositionKey{dummy_field: false};
            assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v2), 11);
            arg0.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&v1));
            let v3 = PositionKey{dummy_field: false};
            0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg0.id, v3, v1);
        } else {
            0x1::option::destroy_none<T2>(arg2);
            arg0.clmm_position_id = 0x1::option::none<0x2::object::ID>();
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg4));
        assert!(arg5 < arg6, 5);
        arg0.current_lower_tick = arg5;
        arg0.current_upper_tick = arg6;
        let v4 = RebalanceEvent{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            operator       : 0x2::tx_context::sender(arg8),
            old_lower_tick : arg0.current_lower_tick,
            old_upper_tick : arg0.current_upper_tick,
            new_lower_tick : arg5,
            new_upper_tick : arg6,
            timestamp_ms   : arg7,
        };
        0x2::event::emit<RebalanceEvent>(v4);
    }

    public fun finish_withdraw_liquidity<T0, T1, T2: store + key>(arg0: &mut Vault<T0, T1>, arg1: WithdrawLiquidityReceipt<T0, T1>, arg2: T2, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let WithdrawLiquidityReceipt {
            vault_id      : v0,
            shares_burned : v1,
        } = arg1;
        assert_version<T0, T1>(arg0);
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 12);
        assert!(arg0.is_rebalancing, 10);
        let v2 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v2), 11);
        let v3 = ExpectedPosKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExpectedPosKey>(&arg0.id, v3), 12);
        let v4 = ExpectedPosKey{dummy_field: false};
        assert!(0x2::object::id<T2>(&arg2) == 0x2::dynamic_field::remove<ExpectedPosKey, 0x2::object::ID>(&mut arg0.id, v4), 12);
        arg0.is_rebalancing = false;
        arg0.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&arg2));
        let v5 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg0.id, v5, arg2);
        let v6 = WithdrawEvent{
            vault_id          : v0,
            withdrawer        : 0x2::tx_context::sender(arg5),
            shares_burned     : v1,
            amount_a_returned : arg3,
            amount_b_returned : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v6);
    }

    public fun harvest_and_compound<T0, T1>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = (((v0 as u128) * (arg1.fee_rate_bps as u128) / 10000) as u64);
        let v3 = (((v1 as u128) * (arg1.fee_rate_bps as u128) / 10000) as u64);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v2), arg4), arg1.fee_treasury);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v3), arg4), arg1.fee_treasury);
        };
        0x2::balance::join<T0>(&mut arg1.balance_a, v4);
        0x2::balance::join<T1>(&mut arg1.balance_b, v5);
        let v6 = 0x2::object::uid_to_inner(&arg1.id);
        let v7 = PerformanceFeePaidEvent{
            vault_id : v6,
            treasury : arg1.fee_treasury,
            fee_a    : v2,
            fee_b    : v3,
        };
        0x2::event::emit<PerformanceFeePaidEvent>(v7);
        let v8 = FeeHarvestedEvent{
            vault_id            : v6,
            gross_fee_a         : v0,
            gross_fee_b         : v1,
            performance_fee_a   : v2,
            performance_fee_b   : v3,
            compounded_amount_a : 0x2::balance::value<T0>(&v4),
            compounded_amount_b : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<FeeHarvestedEvent>(v8);
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0)
    }

    public fun is_rebalancing<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_rebalancing
    }

    public fun max_fee_bps() : u64 {
        2500
    }

    public fun merge_shares<T0, T1>(arg0: &mut VaultShare<T0, T1>, arg1: VaultShare<T0, T1>) {
        let VaultShare {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(arg0.vault_id == v1, 3);
        arg0.shares = arg0.shares + v2;
    }

    public fun migrate_version<T0, T1>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VersionKey>(&arg1.id, v0)) {
            let v1 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<VersionKey, u64>(&mut arg1.id, v1) = 4;
        } else {
            let v2 = VersionKey{dummy_field: false};
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg1.id, v2, 4);
        };
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun operator_cap_vault_id(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun position_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.clmm_position_id
    }

    public fun receipt_vault_id<T0, T1>(arg0: &RebalanceReceipt<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun record_rebalance<T0, T1>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        assert!(arg2 < arg3, 5);
        arg1.current_lower_tick = arg2;
        arg1.current_upper_tick = arg3;
        let v0 = RebalanceEvent{
            vault_id       : 0x2::object::uid_to_inner(&arg1.id),
            operator       : 0x2::tx_context::sender(arg5),
            old_lower_tick : arg1.current_lower_tick,
            old_upper_tick : arg1.current_upper_tick,
            new_lower_tick : arg2,
            new_upper_tick : arg3,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun set_fee_rate<T0, T1>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        assert!(arg2 <= 2500, 4);
        arg1.fee_rate_bps = arg2;
    }

    public fun set_treasury<T0, T1>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        arg1.fee_treasury = arg2;
    }

    public fun share_shares<T0, T1>(arg0: &VaultShare<T0, T1>) : u64 {
        arg0.shares
    }

    public fun share_vault_id<T0, T1>(arg0: &VaultShare<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun split_share<T0, T1>(arg0: &mut VaultShare<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VaultShare<T0, T1> {
        assert!(arg1 > 0, 2);
        assert!(arg0.shares > arg1, 6);
        arg0.shares = arg0.shares - arg1;
        VaultShare<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : arg0.vault_id,
            shares   : arg1,
        }
    }

    public fun start_deposit_liquidity<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>) : (T2, DepositLiquidityReceipt<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0), 13);
        arg1.is_rebalancing = true;
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<PositionKey, T2>(&mut arg1.id, v1);
        arg1.clmm_position_id = 0x1::option::none<0x2::object::ID>();
        let v3 = ExpectedPosKey{dummy_field: false};
        0x2::dynamic_field::add<ExpectedPosKey, 0x2::object::ID>(&mut arg1.id, v3, 0x2::object::id<T2>(&v2));
        let v4 = DepositLiquidityReceipt<T0, T1>{vault_id: 0x2::object::uid_to_inner(&arg1.id)};
        (v2, v4)
    }

    public fun start_rebalance<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, RebalanceReceipt<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        arg1.is_rebalancing = true;
        let v0 = PositionKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0)) {
            let v2 = PositionKey{dummy_field: false};
            arg1.clmm_position_id = 0x1::option::none<0x2::object::ID>();
            0x1::option::some<T2>(0x2::dynamic_object_field::remove<PositionKey, T2>(&mut arg1.id, v2))
        } else {
            0x1::option::none<T2>()
        };
        let v3 = RebalanceReceipt<T0, T1>{vault_id: 0x2::object::uid_to_inner(&arg1.id)};
        (v1, 0x2::coin::take<T0>(&mut arg1.balance_a, 0x2::balance::value<T0>(&arg1.balance_a), arg2), 0x2::coin::take<T1>(&mut arg1.balance_b, 0x2::balance::value<T1>(&arg1.balance_b), arg2), v3)
    }

    public fun start_withdraw_liquidity<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: VaultShare<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (T2, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, WithdrawLiquidityReceipt<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0), 13);
        let VaultShare {
            id       : v1,
            vault_id : v2,
            shares   : v3,
        } = arg2;
        0x2::object::delete(v1);
        let v4 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v2 == v4, 3);
        assert!(v3 > 0, 2);
        assert!(arg1.total_shares > v3, 6);
        arg1.total_shares = arg1.total_shares - v3;
        arg1.is_rebalancing = true;
        let v5 = PositionKey{dummy_field: false};
        let v6 = 0x2::dynamic_object_field::remove<PositionKey, T2>(&mut arg1.id, v5);
        arg1.clmm_position_id = 0x1::option::none<0x2::object::ID>();
        let v7 = ExpectedPosKey{dummy_field: false};
        0x2::dynamic_field::add<ExpectedPosKey, 0x2::object::ID>(&mut arg1.id, v7, 0x2::object::id<T2>(&v6));
        let v8 = WithdrawLiquidityReceipt<T0, T1>{
            vault_id      : v4,
            shares_burned : v3,
        };
        (v6, 0x2::coin::take<T0>(&mut arg1.balance_a, (((v3 as u128) * (0x2::balance::value<T0>(&arg1.balance_a) as u128) / (arg1.total_shares as u128)) as u64), arg3), 0x2::coin::take<T1>(&mut arg1.balance_b, (((v3 as u128) * (0x2::balance::value<T1>(&arg1.balance_b) as u128) / (arg1.total_shares as u128)) as u64), arg3), v8)
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun vault_version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VersionKey>(&arg0.id, v0)) {
            let v2 = VersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<VersionKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: VaultShare<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let VaultShare {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 3);
        assert!(v2 > 0, 2);
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v3 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v3), 11);
        assert!(arg0.total_shares > v2, 6);
        let v4 = (((v2 as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / (arg0.total_shares as u128)) as u64);
        let v5 = (((v2 as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / (arg0.total_shares as u128)) as u64);
        arg0.total_shares = arg0.total_shares - v2;
        let v6 = WithdrawEvent{
            vault_id          : v1,
            withdrawer        : 0x2::tx_context::sender(arg2),
            shares_burned     : v2,
            amount_a_returned : v4,
            amount_b_returned : v5,
        };
        0x2::event::emit<WithdrawEvent>(v6);
        (0x2::coin::take<T0>(&mut arg0.balance_a, v4, arg2), 0x2::coin::take<T1>(&mut arg0.balance_b, v5, arg2))
    }

    public fun withdraw_cetus_active<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: VaultShare<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 13);
        let VaultShare {
            id       : v1,
            vault_id : v2,
            shares   : v3,
        } = arg3;
        0x2::object::delete(v1);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v2 == v4, 3);
        assert!(v3 > 0, 2);
        assert!(arg0.total_shares > v3, 6);
        let v5 = arg0.total_shares;
        let v6 = PositionKey{dummy_field: false};
        let v7 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v6);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v7), 14);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v7);
        assert!(v8 > 0, 13);
        let v9 = (v3 as u128) * v8 / (v5 as u128);
        assert!(v9 > 0, 13);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, v7, v9, arg6);
        arg0.total_shares = v5 - v3;
        let v12 = 0x2::balance::split<T0>(&mut arg0.balance_a, (((v3 as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / (v5 as u128)) as u64));
        let v13 = 0x2::balance::split<T1>(&mut arg0.balance_b, (((v3 as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / (v5 as u128)) as u64));
        0x2::balance::join<T0>(&mut v12, v10);
        0x2::balance::join<T1>(&mut v13, v11);
        let v14 = 0x2::balance::value<T0>(&v12);
        let v15 = 0x2::balance::value<T1>(&v13);
        assert!(v14 >= arg4 && v15 >= arg5, 15);
        let v16 = WithdrawEvent{
            vault_id          : v4,
            withdrawer        : 0x2::tx_context::sender(arg7),
            shares_burned     : v3,
            amount_a_returned : v14,
            amount_b_returned : v15,
        };
        0x2::event::emit<WithdrawEvent>(v16);
        (0x2::coin::from_balance<T0>(v12, arg7), 0x2::coin::from_balance<T1>(v13, arg7))
    }

    public fun withdraw_turbos_active<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: VaultShare<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0), 13);
        let VaultShare {
            id       : v1,
            vault_id : v2,
            shares   : v3,
        } = arg3;
        0x2::object::delete(v1);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v2 == v4, 3);
        assert!(v3 > 0, 2);
        assert!(arg0.total_shares > v3, 6);
        let v5 = arg0.total_shares;
        let v6 = PositionKey{dummy_field: false};
        let v7 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut arg0.id, v6);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(v7), 14);
        let v8 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v7);
        let (_, _, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_to_address(&v8));
        assert!(v11 > 0, 13);
        let v12 = (v3 as u128) * v11 / (v5 as u128);
        assert!(v12 > 0, 13);
        let (v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg1, arg2, v7, v12, 0, 0, arg6, arg7, arg8, arg9);
        let v15 = v14;
        let v16 = v13;
        arg0.total_shares = v5 - v3;
        0x2::coin::join<T0>(&mut v16, 0x2::coin::take<T0>(&mut arg0.balance_a, (((v3 as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / (v5 as u128)) as u64), arg9));
        0x2::coin::join<T1>(&mut v15, 0x2::coin::take<T1>(&mut arg0.balance_b, (((v3 as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / (v5 as u128)) as u64), arg9));
        let v17 = 0x2::coin::value<T0>(&v16);
        let v18 = 0x2::coin::value<T1>(&v15);
        assert!(v17 >= arg4 && v18 >= arg5, 15);
        let v19 = WithdrawEvent{
            vault_id          : v4,
            withdrawer        : 0x2::tx_context::sender(arg9),
            shares_burned     : v3,
            amount_a_returned : v17,
            amount_b_returned : v18,
        };
        0x2::event::emit<WithdrawEvent>(v19);
        (v16, v15)
    }

    // decompiled from Move bytecode v7
}

