module 0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::utils {
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

