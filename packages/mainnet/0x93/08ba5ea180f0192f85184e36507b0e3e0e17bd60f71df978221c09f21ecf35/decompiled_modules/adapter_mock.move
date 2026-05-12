module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::adapter_mock {
    struct MockVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        supplied_principal: u64,
    }

    public fun balance_value<T0>(arg0: &MockVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun begin_keeper_redeem<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg3: &mut MockVault<T0>, arg4: u64) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        assert!(arg4 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg3.balance) >= arg4, 1);
        0x2::balance::join<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_mut<T0>(arg2), 0x2::balance::split<T0>(&mut arg3.balance, arg4));
        let v0 = if (arg3.supplied_principal >= arg4) {
            arg3.supplied_principal - arg4
        } else {
            0
        };
        arg3.supplied_principal = v0;
    }

    public fun begin_keeper_supply<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg3: &mut MockVault<T0>, arg4: u64) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        assert!(arg4 > 0, 2);
        assert!(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::unsupplied_balance<T0>(arg2) >= arg4, 1);
        0x2::balance::join<T0>(&mut arg3.balance, 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::split_unsupplied<T0>(arg2, arg4));
        arg3.supplied_principal = arg3.supplied_principal + arg4;
    }

    public fun create_vault<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MockVault<T0>{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<T0>(),
            supplied_principal : 0,
        };
        0x2::transfer::share_object<MockVault<T0>>(v0);
    }

    public fun harvest_yield<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut MockVault<T0>) : 0x2::balance::Balance<T0> {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        let v0 = 0x2::balance::value<T0>(&arg2.balance);
        if (v0 <= arg2.supplied_principal) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg2.balance, v0 - arg2.supplied_principal)
        }
    }

    public fun inject_yield<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut MockVault<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun supplied_principal<T0>(arg0: &MockVault<T0>) : u64 {
        arg0.supplied_principal
    }

    public fun yield_accrued<T0>(arg0: &MockVault<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 <= arg0.supplied_principal) {
            0
        } else {
            v0 - arg0.supplied_principal
        }
    }

    // decompiled from Move bytecode v7
}

