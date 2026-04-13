module 0xbcc848c296408d6e32c3a43c48a6300e96fb4328ce85661a8c2c1f65296e448c::test {
    public entry fun mint_and_send(arg0: &mut 0x2::coin::TreasuryCap<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::mint<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

