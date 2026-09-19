module 0x4e41d7092382143d82eb1cce0e8231739c17823a2f3c41d352023cce5c407023::fa {
    public fun a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2)
    }

    public fun b2a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), arg2)
    }

    // decompiled from Move bytecode v7
}

