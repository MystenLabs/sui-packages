module 0xa07531c74055556ae11c262be245e3014a6093276b4523e06cbc27f452b909f5::suitizen {
    struct SUITIZEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITIZEN>, arg1: 0x2::coin::Coin<SUITIZEN>) {
        0x2::coin::burn<SUITIZEN>(arg0, arg1);
    }

    fun init(arg0: SUITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIZEN>(arg0, 2, b"Suitizen", b"STZ", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITIZEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIZEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

