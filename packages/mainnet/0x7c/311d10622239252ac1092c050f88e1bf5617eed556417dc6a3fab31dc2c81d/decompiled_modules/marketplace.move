module 0x7c311d10622239252ac1092c050f88e1bf5617eed556417dc6a3fab31dc2c81d::marketplace {
    struct MarketPlace has key {
        id: 0x2::object::UID,
        fee: u64,
    }

    public entry fun get_market_fee(arg0: &mut MarketPlace, arg1: u64) : u64 {
        if (arg1 < 10000) {
            return 0
        };
        arg1 / 10000 * arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlace{
            id  : 0x2::object::new(arg0),
            fee : 250,
        };
        0x2::transfer::share_object<MarketPlace>(v0);
    }

    public entry fun set_market_fee(arg0: &mut MarketPlace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        assert!(arg1 <= 10000, 1);
        arg0.fee = arg1;
    }

    // decompiled from Move bytecode v6
}

