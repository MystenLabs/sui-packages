module 0xbc80d1347b982b72dc51351da4e0f55d3ae6f37332fba9e72b14bc8bd7122bd0::marketplace {
    struct MarketPlace has key {
        id: 0x2::object::UID,
        fee: u64,
        beneficiary: address,
    }

    public fun get_market_fee(arg0: &mut MarketPlace, arg1: u64) : (u64, address) {
        if (arg1 < 10000) {
            return (0, arg0.beneficiary)
        };
        (arg1 / 10000 * arg0.fee, arg0.beneficiary)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlace{
            id          : 0x2::object::new(arg0),
            fee         : 250,
            beneficiary : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<MarketPlace>(v0);
    }

    public entry fun set_market_fee(arg0: &mut MarketPlace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1 <= 10000, 1);
        arg0.fee = arg1;
    }

    // decompiled from Move bytecode v6
}

