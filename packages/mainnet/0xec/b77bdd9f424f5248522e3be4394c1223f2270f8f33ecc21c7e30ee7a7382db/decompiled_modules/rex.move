module 0xecb77bdd9f424f5248522e3be4394c1223f2270f8f33ecc21c7e30ee7a7382db::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"SUIREX - CTO", b"They have delayed this coin for far too long! We are now live on movepump! Enjoy this journey guys <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirex_812076fc43_05128698f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

