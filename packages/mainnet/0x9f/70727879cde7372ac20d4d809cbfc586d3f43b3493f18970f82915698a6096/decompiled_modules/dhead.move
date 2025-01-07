module 0x9f70727879cde7372ac20d4d809cbfc586d3f43b3493f18970f82915698a6096::dhead {
    struct DHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHEAD>(arg0, 6, b"Dhead", b"Dickhead", b"Join us Dick lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_01_12_57_045b58d434.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

