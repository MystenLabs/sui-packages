module 0x1afdb98c6e1ac322ca5fd3a4b26a700f0ce161625828cf50344b101ad9835bcf::flash_arb {
    struct ArbReceipt<phantom T0> {
        borrowed_amount: u64,
        min_profit: u64,
    }

    public fun begin_arb<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : ArbReceipt<T0> {
        ArbReceipt<T0>{
            borrowed_amount : 0x2::coin::value<T0>(arg0),
            min_profit      : arg1,
        }
    }

    public fun finalize_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: ArbReceipt<T0>, arg2: address) {
        let ArbReceipt {
            borrowed_amount : v0,
            min_profit      : v1,
        } = arg1;
        assert!(0x2::coin::value<T0>(&arg0) >= v0 + v1, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public fun finalize_arb<T0>(arg0: &0x2::coin::Coin<T0>, arg1: ArbReceipt<T0>) {
        let ArbReceipt {
            borrowed_amount : v0,
            min_profit      : v1,
        } = arg1;
        assert!(0x2::coin::value<T0>(arg0) >= v0 + v1, 100);
    }

    // decompiled from Move bytecode v6
}

