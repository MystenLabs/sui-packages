module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve {
    struct VaultReserve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun value<T0, T1>(arg0: &VaultReserve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultReserve<T0, T1>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<VaultReserve<T0, T1>>(v0);
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut VaultReserve<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut VaultReserve<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg1)
    }

    // decompiled from Move bytecode v6
}

