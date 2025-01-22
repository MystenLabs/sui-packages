module 0x5dded4d62a32f6104bc86f98fa26fcdee4edd85238dc2bd5846612a7998ec06b::utils {
    struct DAOCoin<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun unwrap_coin<T0>(arg0: DAOCoin<T0>) : 0x2::balance::Balance<T0> {
        let DAOCoin { balance: v0 } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::withdraw_all<T0>(&mut arg0.balance)
    }

    public(friend) fun wrap_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : DAOCoin<T0> {
        DAOCoin<T0>{balance: arg0}
    }

    // decompiled from Move bytecode v6
}

