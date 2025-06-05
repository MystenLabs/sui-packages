module 0xd6e1ecf6d72b0be2295f5eadd9de44e126d473a6f7e1c48d7b1b7c2c919e4690::emai {
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

