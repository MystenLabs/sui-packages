module 0xe6e874ccf77f5cf0ccd7de9f0a58170f9fb4d15c0f0af039984db11c9d4604cf::tryton {
    struct TRYTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYTON>(arg0, 6, b"Tryton", b"Tryton Sui", b"Tryton is a unique crypto project developing on various blockchain networks such as TON, SUI, Ethereum and BSC. We are creating a powerful ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_030916_624_5d2514f9d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

