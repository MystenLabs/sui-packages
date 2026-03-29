module 0x835d4362789fa09952a41a81d2d9589e6a1e3e08817a3de5e39b6ac3c0536e64::s_coin_converter {
    struct SCoinTreasury<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_s_coin<T0, T1>(arg0: &mut SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun mint_s_coin<T0, T1>(arg0: &mut SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

