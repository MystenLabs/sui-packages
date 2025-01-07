module 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::fee_collector {
    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        total_collected: u64,
        fee_custodian: 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::Custodian<T0>,
    }

    public fun value<T0>(arg0: &FeeCollector<T0>) : u64 {
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::reserve<T0>(&arg0.fee_custodian)
    }

    public fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        assert!(arg0 < 10000, 0);
        FeeCollector<T0>{
            id              : 0x2::object::new(arg1),
            fee_rate        : arg0,
            total_collected : 0,
            fee_custodian   : 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::new<T0>(),
        }
    }

    public fun deposit<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_collected = arg0.total_collected + 0x2::coin::value<T0>(&arg1);
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::deposit<T0>(&mut arg0.fee_custodian, arg1);
    }

    public fun withdraw<T0>(arg0: &mut FeeCollector<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::withdraw<T0>(&mut arg0.fee_custodian, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut FeeCollector<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::custodian::withdraw_all<T0>(&mut arg0.fee_custodian, arg1)
    }

    public fun change_fee<T0>(arg0: &mut FeeCollector<T0>, arg1: u64) {
        arg0.fee_rate = arg1;
    }

    public fun fee_amount<T0>(arg0: &FeeCollector<T0>, arg1: u64) : u64 {
        arg0.fee_rate * arg1 / 10000
    }

    // decompiled from Move bytecode v6
}

