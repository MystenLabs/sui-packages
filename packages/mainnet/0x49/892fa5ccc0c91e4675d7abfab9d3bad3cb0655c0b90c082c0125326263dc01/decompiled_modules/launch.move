module 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::lending_market::LendingMarketOwnerCap<LAUNCH>>(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::lending_market::create_lending_market<LAUNCH>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

