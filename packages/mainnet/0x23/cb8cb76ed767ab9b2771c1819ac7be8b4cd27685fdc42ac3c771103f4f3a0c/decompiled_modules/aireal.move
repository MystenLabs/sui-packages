module 0x23cb8cb76ed767ab9b2771c1819ac7be8b4cd27685fdc42ac3c771103f4f3a0c::aireal {
    struct AIREAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIREAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIREAL>(arg0, 6, b"AIREAL", b"AM.I.REAL", b"No description available.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_002556_385_7ef31aa3b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIREAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIREAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

