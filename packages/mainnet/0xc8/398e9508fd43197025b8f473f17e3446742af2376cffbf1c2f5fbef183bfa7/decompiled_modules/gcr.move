module 0xc8398e9508fd43197025b8f473f17e3446742af2376cffbf1c2f5fbef183bfa7::gcr {
    struct GCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCR>(arg0, 6, b"GCR", b"Gigantic Sui Rebirth", b"Gigantic Sui Rebirth is about to come ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8874_1f981b24a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

