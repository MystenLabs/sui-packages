module 0xeb3ea608693a9b4a3585491fa121508bad34048d4675ef7bb17ac81bee9039b4::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xeb3ea608693a9b4a3585491fa121508bad34048d4675ef7bb17ac81bee9039b4::lending_market::LendingMarketOwnerCap<LAUNCH>>(0xeb3ea608693a9b4a3585491fa121508bad34048d4675ef7bb17ac81bee9039b4::lending_market::create_lending_market<LAUNCH>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

