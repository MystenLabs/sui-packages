module 0xe38b4e4ab17ed69912f7c2a1afb1e68877a09c1bb32cec48dce2cdc2103043c3::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
    }

    struct VaultBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow_object<T0: copy + drop + store, T1: store + key>(arg0: &Vault, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_object_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{id: 0x2::object::new(arg0)}
    }

    public(friend) fun get_balance<T0>(arg0: &Vault) : u64 {
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::coin::balance<T0>(0x2::dynamic_object_field::borrow<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0)))
    }

    public(friend) fun put_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            let v1 = VaultBalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v1)), arg1);
        } else {
            let v2 = VaultBalanceKey<T0>{dummy_field: false};
            0x2::dynamic_object_field::add<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v2, 0x2::coin::from_balance<T0>(arg1, arg2));
        };
    }

    public(friend) fun put_object<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun take_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = VaultBalanceKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<VaultBalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)), arg1)
    }

    public(friend) fun take_object<T0: copy + drop + store, T1: store + key>(arg0: &mut Vault, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

