module 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::fee_collector {
    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        total_collected: u64,
        fee_custodian: 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::custodian::Custodian<T0>,
    }

    public fun value<T0>(arg0: &FeeCollector<T0>) : u64 {
        0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::custodian::reserve<T0>(&arg0.fee_custodian)
    }

    public fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        assert!(arg0 < 10000, 0);
        FeeCollector<T0>{
            id              : 0x2::object::new(arg1),
            fee_rate        : arg0,
            total_collected : 0,
            fee_custodian   : 0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::custodian::new<T0>(),
        }
    }

    public fun deposit<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_collected = arg0.total_collected + 0x2::coin::value<T0>(&arg1);
        0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::custodian::deposit<T0>(&mut arg0.fee_custodian, arg1);
    }

    public fun withdraw<T0>(arg0: &mut FeeCollector<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3dc3e2d25886ae14aa8975bdaacfffbd3c29c7434f902a5564810f453969bb10::custodian::withdraw<T0>(&mut arg0.fee_custodian, arg1, arg2)
    }

    public fun change_fee<T0>(arg0: &mut FeeCollector<T0>, arg1: u64) {
        arg0.fee_rate = arg1;
    }

    public fun fee_amount<T0>(arg0: &FeeCollector<T0>, arg1: u64) : u64 {
        arg0.fee_rate * arg1 / 10000
    }

    // decompiled from Move bytecode v6
}

