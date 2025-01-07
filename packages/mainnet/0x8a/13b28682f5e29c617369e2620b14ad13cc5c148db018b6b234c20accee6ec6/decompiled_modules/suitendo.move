module 0x8a13b28682f5e29c617369e2620b14ad13cc5c148db018b6b234c20accee6ec6::suitendo {
    struct SUITENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITENDO>(arg0, 6, b"SUITENDO", b"SuiTendo", b"Its the console of the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_57_24_06d2d999f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITENDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITENDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

