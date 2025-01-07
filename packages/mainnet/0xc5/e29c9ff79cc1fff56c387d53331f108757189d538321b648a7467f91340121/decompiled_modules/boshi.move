module 0xc5e29c9ff79cc1fff56c387d53331f108757189d538321b648a7467f91340121::boshi {
    struct BOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSHI>(arg0, 6, b"BOSHI", b"Boshi", b"Boshi is the blue-Sui dino dragon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOSHI_c51f468c64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

