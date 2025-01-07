module 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::lending_market::LendingMarketOwnerCap<LAUNCH>>(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::lending_market::create_lending_market<LAUNCH>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

