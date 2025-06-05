module 0x3fcf3138f74876fdea5df6e0863babe666a1f1a6f10ea5fb16c5f9ef9606b89e::emai {
    struct EMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMAI>(arg0, 6, b"EMAI", b"elon mask ai", b"The best EMAI on the moon space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2319_1a1f995180.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

