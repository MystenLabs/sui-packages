module 0x3435d5a5de1ee1eae60a769c5574290c1d6839a1e095bba3ca65df135d9a11a4::rafiki {
    struct RAFIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAFIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAFIKI>(arg0, 6, b"RAFIKI", b"Rafiki SUI", b"Rafiki Knows the Way,To Pump Your Bags!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_032825_800_4f30d81a37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAFIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAFIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

