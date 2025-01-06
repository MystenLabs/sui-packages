module 0xafc483e2e502a5ee3fdfeaa51bb2661cf093479e909b2d053e1930ffcddb5faa::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"WOJAK", b"Wojak on Sui", b"WOJAK now is on Sui, buy it before it's too late.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734888270081_6be92939f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

