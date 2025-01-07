module 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector {
    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_custodian: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::custodian::Custodian<T0>,
    }

    public fun value<T0>(arg0: &FeeCollector<T0>) : u64 {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::custodian::reserve<T0>(&arg0.fee_custodian)
    }

    public fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        FeeCollector<T0>{
            id            : 0x2::object::new(arg1),
            fee_amount    : arg0,
            fee_custodian : 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::custodian::new<T0>(),
        }
    }

    public fun deposit<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.fee_amount, 0);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::custodian::deposit<T0>(&mut arg0.fee_custodian, arg1);
    }

    public fun withdraw<T0>(arg0: &mut FeeCollector<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::custodian::withdraw<T0>(&mut arg0.fee_custodian, arg1, arg2)
    }

    public fun change_fee<T0>(arg0: &mut FeeCollector<T0>, arg1: u64) {
        arg0.fee_amount = arg1;
    }

    public fun fee_amount<T0>(arg0: &FeeCollector<T0>) : u64 {
        arg0.fee_amount
    }

    // decompiled from Move bytecode v6
}

