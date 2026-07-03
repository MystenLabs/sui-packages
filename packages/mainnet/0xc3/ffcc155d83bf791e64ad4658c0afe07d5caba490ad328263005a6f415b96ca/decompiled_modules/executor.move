module 0xc3ffcc155d83bf791e64ad4658c0afe07d5caba490ad328263005a6f415b96ca::executor {
    struct BalanceReceipt<phantom T0> {
        balance_before: u64,
    }

    public fun assert_profit<T0>(arg0: BalanceReceipt<T0>, arg1: &0x2::coin::Coin<T0>, arg2: u64) {
        let BalanceReceipt { balance_before: v0 } = arg0;
        let v1 = 0x2::coin::value<T0>(arg1);
        assert!(v1 >= v0, 2);
        assert!(v1 >= v0 + arg2, 1);
    }

    public fun snapshot_balance<T0>(arg0: &0x2::coin::Coin<T0>) : BalanceReceipt<T0> {
        BalanceReceipt<T0>{balance_before: 0x2::coin::value<T0>(arg0)}
    }

    // decompiled from Move bytecode v7
}

