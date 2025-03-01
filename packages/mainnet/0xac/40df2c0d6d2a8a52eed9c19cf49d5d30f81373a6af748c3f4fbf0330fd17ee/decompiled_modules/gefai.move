module 0xac40df2c0d6d2a8a52eed9c19cf49d5d30f81373a6af748c3f4fbf0330fd17ee::gefai {
    struct GEFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEFAI>(arg0, 9, b"GEFAI", b"GEFION AI", x"546865206e6577204149207375706572636f6d70757465722c206e616d656420e2809c476566696f6ee2809d20616e64206275696c74206f6e204e564944494120444758205375706572504f442c20776173206c61756e6368656420617420616e206576656e7420696e20436f70656e686167656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5026b0cb-9d5b-4d1a-b5ac-0b532bc17cba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

