module 0xf8b756fbcef811d6b9fec9b555b399e380b91ac766147e36f468115afc3a9e69::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 9, b"SUITEST", b"SUITEST", b"This is SUITEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/56954475?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

