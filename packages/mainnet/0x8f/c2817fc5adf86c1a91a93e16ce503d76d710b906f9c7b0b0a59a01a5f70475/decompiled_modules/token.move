module 0x8fc2817fc5adf86c1a91a93e16ce503d76d710b906f9c7b0b0a59a01a5f70475::token {
    struct TokenData<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        debt: u64,
    }

    public fun join<T0>(arg0: &mut TokenData<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.debt = arg0.debt + arg2;
    }

    public fun assert_healthy<T0>(arg0: &TokenData<T0>) {
        assert!(balance_value<T0>(arg0) >= debt_value<T0>(arg0), 11);
    }

    public fun balance_value<T0>(arg0: &TokenData<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_zero<T0>() : TokenData<T0> {
        TokenData<T0>{
            balance : 0x2::balance::zero<T0>(),
            debt    : 0,
        }
    }

    public fun debt_value<T0>(arg0: &TokenData<T0>) : u64 {
        arg0.debt
    }

    public fun move_balance<T0>(arg0: TokenData<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let TokenData {
            balance : v0,
            debt    : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), @0x3a9051c5cdb975cb98605f3e795b7d5ea0e3f3613f32fd45ec5ac1dedd02c97f);
    }

    public fun pay_debt<T0>(arg0: &mut TokenData<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 11);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

