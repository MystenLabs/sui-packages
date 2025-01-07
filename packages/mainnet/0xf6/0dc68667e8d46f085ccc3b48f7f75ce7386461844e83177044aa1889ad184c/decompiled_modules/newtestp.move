module 0xf60dc68667e8d46f085ccc3b48f7f75ce7386461844e83177044aa1889ad184c::newtestp {
    struct SUICoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        suibalance: 0x2::balance::Balance<T0>,
    }

    public entry fun value<T0>(arg0: &SUICoin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.suibalance)
    }

    public fun deposit<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : SUICoin<T0> {
        SUICoin<T0>{
            id         : 0x2::object::new(arg1),
            suibalance : arg0,
        }
    }

    public fun withdraw<T0>(arg0: &mut SUICoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.suibalance, 0x2::balance::value<T0>(&arg0.suibalance)), arg1)
    }

    // decompiled from Move bytecode v6
}

