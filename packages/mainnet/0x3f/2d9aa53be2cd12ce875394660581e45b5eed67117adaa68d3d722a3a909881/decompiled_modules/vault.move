module 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault {
    struct MainVault has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        idle_balance: 0x2::balance::Balance<T0>,
        adapters: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct CuratorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Deposit<phantom T0, phantom T1> {
        balance: 0x2::balance::Balance<T0>,
    }

    struct Withdraw<phantom T0, phantom T1> {
        amount: u64,
    }

    public fun unwrap_deposit<T0, T1: drop>(arg0: Deposit<T0, T1>, arg1: T1) : 0x2::balance::Balance<T0> {
        let Deposit { balance: v0 } = arg0;
        v0
    }

    public fun unwrap_deposit_to_vault<T0>(arg0: &mut Vault<T0>, arg1: Deposit<T0, MainVault>) {
        let v0 = MainVault{dummy_field: false};
        0x2::balance::join<T0>(&mut arg0.idle_balance, unwrap_deposit<T0, MainVault>(arg1, v0));
    }

    public fun unwrap_withdraw<T0, T1: drop>(arg0: Withdraw<T0, T1>, arg1: T1) : u64 {
        let Withdraw { amount: v0 } = arg0;
        v0
    }

    public fun wrap_deposit<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &CuratorCap, arg2: u64) : Deposit<T0, T1> {
        assert!(0x2::balance::value<T0>(&arg0.idle_balance) >= arg2, 1000);
        Deposit<T0, T1>{balance: 0x2::balance::split<T0>(&mut arg0.idle_balance, arg2)}
    }

    public fun wrap_deposit_from_adapter<T0, T1: drop>(arg0: &Vault<T0>, arg1: T1, arg2: 0x2::balance::Balance<T0>) : Deposit<T0, MainVault> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.adapters, &v0), 10001);
        Deposit<T0, MainVault>{balance: arg2}
    }

    public fun wrap_withdraw<T0, T1: drop>(arg0: &mut Vault<T0>, arg1: &CuratorCap, arg2: u64) : Withdraw<T0, T1> {
        Withdraw<T0, T1>{amount: arg2}
    }

    // decompiled from Move bytecode v7
}

