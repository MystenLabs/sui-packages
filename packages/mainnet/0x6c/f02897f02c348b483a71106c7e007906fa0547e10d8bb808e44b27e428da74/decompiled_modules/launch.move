module 0x6cf02897f02c348b483a71106c7e007906fa0547e10d8bb808e44b27e428da74::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6cf02897f02c348b483a71106c7e007906fa0547e10d8bb808e44b27e428da74::lending_market::LendingMarketOwnerCap<LAUNCH>>(0x6cf02897f02c348b483a71106c7e007906fa0547e10d8bb808e44b27e428da74::lending_market::create_lending_market<LAUNCH>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

