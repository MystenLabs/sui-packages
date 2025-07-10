module 0xbe11164e5748c15c509a0f11787a888207f1a3fbf3a583dc5a7fbcfeae2378ef::mozg {
    struct MOZG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZG>(arg0, 6, b"MOZG", b"MOZGai", x"4e657720657261200a4e65772070726f6a656374200a4e6577207374796c65200a4e657720425443", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752173842081.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOZG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

