module 0xa861d39a024f93188febb2fe80f689651f5357917f70cf222b00b6d937c62c56::pool {
    struct Pool has store, key {
        id: 0x2::object::UID,
        balanceA: u64,
        balanceB: u64,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id       : 0x2::object::new(arg0),
            balanceA : 0,
            balanceB : 0,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

