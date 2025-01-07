module 0x9c983da51de49a6c27b040b31d3a7897fb4d71593f9bf7d17156815f7d2f59ae::n {
    struct SUIbalance has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public fun depositSUI(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = SUIbalance{
            id     : 0x2::object::new(arg1),
            amount : arg0,
        };
        0x2::transfer::share_object<SUIbalance>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        let v0 = SUIbalance{
            id     : 0x2::object::new(arg0),
            amount : 0,
        };
        0x2::transfer::share_object<SUIbalance>(v0);
    }

    public fun withdrawSUI(arg0: SUIbalance, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SUIbalance>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

