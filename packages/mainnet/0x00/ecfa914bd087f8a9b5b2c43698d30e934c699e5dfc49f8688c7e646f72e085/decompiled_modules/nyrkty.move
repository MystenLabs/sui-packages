module 0xecfa914bd087f8a9b5b2c43698d30e934c699e5dfc49f8688c7e646f72e085::nyrkty {
    struct NYRKTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYRKTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYRKTY>(arg0, 9, b"NYRKTY", b"Nurk", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/248a362be320431485d1cce27616c66fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYRKTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYRKTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

