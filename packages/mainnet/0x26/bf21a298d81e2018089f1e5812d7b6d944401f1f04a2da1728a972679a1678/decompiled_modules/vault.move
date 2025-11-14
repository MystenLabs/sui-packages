module 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::vault {
    struct Vault has store {
        balances: 0x2::bag::Bag,
    }

    public fun is_empty(arg0: &Vault) : bool {
        0x2::bag::is_empty(&arg0.balances)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{balances: 0x2::bag::new(arg0)}
    }

    public fun balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun close(arg0: Vault) {
        assert!(is_empty(&arg0), 0);
        let Vault { balances: v0 } = arg0;
        0x2::bag::destroy_empty(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = 0x1::type_name::with_original_ids<T0>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::with_original_ids<T0>());
        assert!(arg1 != 0, 2);
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        if (0x2::balance::value<T0>(v0) == arg1) {
            withdraw_all<T0>(arg0, arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
        }
    }

    public fun withdraw_all<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    // decompiled from Move bytecode v6
}

