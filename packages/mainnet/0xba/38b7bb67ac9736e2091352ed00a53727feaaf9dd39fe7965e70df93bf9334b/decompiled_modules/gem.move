module 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem {
    struct Gem has store, key {
        id: 0x2::object::UID,
        extra: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Gem {
        Gem{
            id    : 0x2::object::new(arg1),
            extra : arg0,
        }
    }

    public fun extra(arg0: &Gem) : u64 {
        arg0.extra
    }

    // decompiled from Move bytecode v6
}

