module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::vault {
    struct Vault<phantom T0> has store {
        bal: 0x2::balance::Balance<T0>,
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bal)
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.bal, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun new<T0>() : Vault<T0> {
        Vault<T0>{bal: 0x2::balance::zero<T0>()}
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal, arg1), arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal, 0x2::balance::value<T0>(&arg0.bal)), arg1)
    }

    // decompiled from Move bytecode v6
}

