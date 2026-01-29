module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public(friend) fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun share_vault<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 101);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

