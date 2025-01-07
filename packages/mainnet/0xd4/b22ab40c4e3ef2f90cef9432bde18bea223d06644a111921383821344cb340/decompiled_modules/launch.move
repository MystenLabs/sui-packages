module 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::lending_market::LendingMarketOwnerCap<LAUNCH>>(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::lending_market::create_lending_market<LAUNCH>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

