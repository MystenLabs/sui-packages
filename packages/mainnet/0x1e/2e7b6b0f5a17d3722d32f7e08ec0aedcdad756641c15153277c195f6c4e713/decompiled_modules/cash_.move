module 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::cash_ {
    struct CashInCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        address: address,
    }

    public fun get_address<T0>(arg0: &CashInCap<T0>) : address {
        arg0.address
    }

    public fun new_cashin<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : CashInCap<T0> {
        CashInCap<T0>{
            id      : 0x2::object::new(arg2),
            address : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

