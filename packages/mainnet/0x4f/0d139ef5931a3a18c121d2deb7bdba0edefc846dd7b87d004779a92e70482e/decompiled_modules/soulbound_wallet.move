module 0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::soulbound_wallet {
    struct SoulboundWallet<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        grow: 0x2::balance::Balance<T0>,
    }

    public fun create_soulbound_grow<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : SoulboundWallet<T0, T1> {
        let v0 = SoulboundWallet<T0, T1>{
            id   : 0x2::object::new(arg0),
            grow : 0x2::balance::zero<T0>(),
        };
        0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::events::soulbound_grow_created(0x2::object::id_address<SoulboundWallet<T0, T1>>(&v0), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        v0
    }

    public fun deposit_growcoins_to_soulbound<T0, T1>(arg0: &mut SoulboundWallet<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.grow, 0x2::coin::into_balance<T0>(arg1));
        0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::events::soulbound_grow_deposit(0x2::object::id_address<SoulboundWallet<T0, T1>>(arg0), 0x2::coin::value<T0>(&arg1));
    }

    public fun soulbound_grow_balance<T0, T1>(arg0: &SoulboundWallet<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.grow)
    }

    public fun withdraw_growcoins_from_soulbound<T0, T1>(arg0: &mut SoulboundWallet<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::events::soulbound_grow_withdraw(0x2::object::id_address<SoulboundWallet<T0, T1>>(arg0), arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.grow, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

