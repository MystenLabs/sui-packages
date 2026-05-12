module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::adapter_suilend {
    struct SuilendVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        receipts: 0x2::balance::Balance<T1>,
        supplied_principal_reference: u64,
    }

    struct WithdrawRequest<phantom T0> {
        user: address,
        withdraw_amount: u64,
        principal_reduction: u64,
        expected_redeemed_min: u64,
    }

    struct KeeperRedeemRequest<phantom T0> {
        principal_reduction: u64,
        pool_unsupplied_snapshot: u64,
    }

    struct KeeperSupplyRequest<phantom T0> {
        amount: u64,
    }

    public fun begin_keeper_redeem<T0, T1>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut SuilendVault<T0, T1>, arg3: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, KeeperRedeemRequest<T0>) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        assert!(arg4 > 0, 4);
        let v0 = 0x2::balance::value<T1>(&arg2.receipts);
        assert!(v0 >= arg4, 1);
        let v1 = if (v0 == 0) {
            0
        } else {
            (((arg4 as u128) * (arg2.supplied_principal_reference as u128) / (v0 as u128)) as u64)
        };
        let v2 = KeeperRedeemRequest<T0>{
            principal_reduction      : v1,
            pool_unsupplied_snapshot : 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_balance<T0>(arg3),
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.receipts, arg4), arg5), v2)
    }

    public fun begin_keeper_supply<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, KeeperSupplyRequest<T0>) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        assert!(arg3 > 0, 4);
        assert!(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_balance<T0>(arg2) >= arg3, 1);
        let v0 = KeeperSupplyRequest<T0>{amount: arg3};
        (0x2::coin::from_balance<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::split_unsupplied<T0>(arg2, arg3), arg4), v0)
    }

    public fun begin_withdraw_from_yield<T0, T1>(arg0: &mut SuilendVault<T0, T1>, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, WithdrawRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 > 0 && arg3 > 0, 4);
        assert!(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::user_balance<T0>(arg1, v0) >= arg3, 1);
        let v1 = 0x2::balance::value<T1>(&arg0.receipts);
        assert!(v1 >= arg2, 1);
        let v2 = if (v1 == 0) {
            0
        } else {
            (((arg2 as u128) * (arg0.supplied_principal_reference as u128) / (v1 as u128)) as u64)
        };
        let v3 = WithdrawRequest<T0>{
            user                  : v0,
            withdraw_amount       : arg3,
            principal_reduction   : v2,
            expected_redeemed_min : arg4,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.receipts, arg2), arg5), v3)
    }

    public fun complete_keeper_redeem<T0, T1>(arg0: &mut SuilendVault<T0, T1>, arg1: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: KeeperRedeemRequest<T0>) {
        let KeeperRedeemRequest {
            principal_reduction      : v0,
            pool_unsupplied_snapshot : v1,
        } = arg3;
        0x2::balance::join<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_mut<T0>(arg1), 0x2::coin::into_balance<T0>(arg2));
        assert!(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_balance<T0>(arg1) - v1 >= v0, 6);
        let v2 = if (arg0.supplied_principal_reference >= v0) {
            arg0.supplied_principal_reference - v0
        } else {
            0
        };
        arg0.supplied_principal_reference = v2;
    }

    public fun complete_keeper_redeem_with_prize<T0, T1>(arg0: &mut SuilendVault<T0, T1>, arg1: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: KeeperRedeemRequest<T0>) : 0x2::balance::Balance<T0> {
        let KeeperRedeemRequest {
            principal_reduction      : v0,
            pool_unsupplied_snapshot : v1,
        } = arg3;
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= v0, 2);
        let v3 = v2 - v0;
        assert!(v3 <= v2, 7);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_mut<T0>(arg1), v4);
        assert!(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_balance<T0>(arg1) - v1 >= v0, 6);
        let v5 = if (arg0.supplied_principal_reference >= v0) {
            arg0.supplied_principal_reference - v0
        } else {
            0
        };
        arg0.supplied_principal_reference = v5;
        0x2::balance::split<T0>(&mut v4, v3)
    }

    public fun complete_keeper_supply<T0, T1>(arg0: &mut SuilendVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: KeeperSupplyRequest<T0>) {
        let KeeperSupplyRequest { amount: v0 } = arg2;
        assert!(0x2::coin::value<T1>(&arg1) >= (((v0 as u128) * (5000 as u128) / 10000) as u64), 6);
        0x2::balance::join<T1>(&mut arg0.receipts, 0x2::coin::into_balance<T1>(arg1));
        arg0.supplied_principal_reference = arg0.supplied_principal_reference + v0;
    }

    public fun complete_withdraw_from_yield<T0, T1>(arg0: &mut SuilendVault<T0, T1>, arg1: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: WithdrawRequest<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawRequest {
            user                  : v0,
            withdraw_amount       : v1,
            principal_reduction   : v2,
            expected_redeemed_min : v3,
        } = arg3;
        assert!(0x2::tx_context::sender(arg5) == v0, 3);
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 5);
        0x2::balance::join<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_mut<T0>(arg1), 0x2::coin::into_balance<T0>(arg2));
        let v4 = if (arg0.supplied_principal_reference >= v2) {
            arg0.supplied_principal_reference - v2
        } else {
            0
        };
        arg0.supplied_principal_reference = v4;
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::withdraw<T0>(arg1, v1, arg4, arg5)
    }

    public fun create_vault<T0, T1>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendVault<T0, T1>{
            id                           : 0x2::object::new(arg1),
            receipts                     : 0x2::balance::zero<T1>(),
            supplied_principal_reference : 0,
        };
        0x2::transfer::share_object<SuilendVault<T0, T1>>(v0);
    }

    public fun receipt_balance<T0, T1>(arg0: &SuilendVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.receipts)
    }

    public fun supplied_principal<T0, T1>(arg0: &SuilendVault<T0, T1>) : u64 {
        arg0.supplied_principal_reference
    }

    // decompiled from Move bytecode v7
}

