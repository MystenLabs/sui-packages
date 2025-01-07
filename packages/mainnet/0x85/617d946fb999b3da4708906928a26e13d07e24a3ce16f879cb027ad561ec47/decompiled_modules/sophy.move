module 0x85617d946fb999b3da4708906928a26e13d07e24a3ce16f879cb027ad561ec47::sophy {
    struct SOPHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPHY>(arg0, 6, b"SOPHY", b"Sophy", b"Sophy the cutest hippopotamus on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_21_11_45_52_7743e1cceb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

