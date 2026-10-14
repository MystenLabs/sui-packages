module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma {
    struct EwmaState has copy, drop, store {
        mean: u64,
        variance: u64,
        last_updated_timestamp_ms: u64,
    }

    public(friend) fun new(arg0: &0x2::tx_context::TxContext) : EwmaState {
        EwmaState{
            mean                      : scaled_gas(arg0),
            variance                  : 0,
            last_updated_timestamp_ms : 0,
        }
    }

    fun scaled_gas(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::gas_price(arg0) * 1000000000
    }

    // decompiled from Move bytecode v7
}

