module 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::lending_market::create_lending_market<LAUNCH>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let v2 = v0;
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::lending_market::share_lending_market<LAUNCH>(&v2, v1);
        0x2::transfer::public_transfer<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::lending_market::LendingMarketOwnerCap<LAUNCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

