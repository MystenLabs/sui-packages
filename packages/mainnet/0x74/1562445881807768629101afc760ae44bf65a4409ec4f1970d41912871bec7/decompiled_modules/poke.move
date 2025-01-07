module 0x741562445881807768629101afc760ae44bf65a4409ec4f1970d41912871bec7::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"Poke", b"POKESUI", x"57656c636f6d6520746f20506f6b652073756920776865726520796f757220647265616d7320636f6d6520747275652e0a0a4a6f696e2074686520636f6d6d756e697479206c6574e2809973207368696c6c20616e64206368696c6c206265636175736520736f6d65206772656174207468696e67732061726520636f6d696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995660342.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

