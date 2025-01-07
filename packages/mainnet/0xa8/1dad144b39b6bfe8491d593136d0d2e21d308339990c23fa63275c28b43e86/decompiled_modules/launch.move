module 0xa81dad144b39b6bfe8491d593136d0d2e21d308339990c23fa63275c28b43e86::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa81dad144b39b6bfe8491d593136d0d2e21d308339990c23fa63275c28b43e86::lending_market::create_lending_market<LAUNCH>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let v2 = v0;
        0xa81dad144b39b6bfe8491d593136d0d2e21d308339990c23fa63275c28b43e86::lending_market::share_lending_market<LAUNCH>(&v2, v1);
        0x2::transfer::public_transfer<0xa81dad144b39b6bfe8491d593136d0d2e21d308339990c23fa63275c28b43e86::lending_market::LendingMarketOwnerCap<LAUNCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

