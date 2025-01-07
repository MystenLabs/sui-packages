module 0xa79f52bef769cca3ad3aa0dd06bf684fe455520f18f358b72005dafcd0d91f27::pins {
    struct PINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINS>(arg0, 6, b"PINS", b"Official Pinky Sui", x"44455853637265656e657220706169643a2068747470733a2f2f70696e6b796f6e7375692e6f72670a68747470733a2f2f782e636f6d2f50696e6b795f5375690a68747470733a2f2f742e6d652f50696e6b795355494f696e6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_4b55d0d55b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

