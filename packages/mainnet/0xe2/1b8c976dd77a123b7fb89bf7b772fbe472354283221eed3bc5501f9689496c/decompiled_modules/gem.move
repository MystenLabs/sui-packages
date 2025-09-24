module 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem {
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

