module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue {
    struct RevenueVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        paused: bool,
    }

    public fun value<T0>(arg0: &RevenueVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun create_vault<T0>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevenueVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            paused  : false,
        };
        0x2::transfer::share_object<RevenueVault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut RevenueVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(!arg0.paused, 1);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun deposit_coin<T0>(arg0: &mut RevenueVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun set_paused<T0>(arg0: &mut RevenueVault<T0>, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun withdraw<T0>(arg0: &mut RevenueVault<T0>, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused, 1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg0.balance), 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

