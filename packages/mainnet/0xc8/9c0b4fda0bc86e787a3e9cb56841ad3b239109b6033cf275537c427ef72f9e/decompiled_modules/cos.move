module 0xc89c0b4fda0bc86e787a3e9cb56841ad3b239109b6033cf275537c427ef72f9e::cos {
    struct COS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COS>(arg0, 6, b"COS", b"Conspiracy on sui", b"You will witness a miracle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726287350497_a02a34a2c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COS>>(v1);
    }

    // decompiled from Move bytecode v6
}

