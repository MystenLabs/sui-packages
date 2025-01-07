module 0x3e29ea37f930942ae7b7abf0b250eb982abd6edc06eb08b30af6fc2e53b1e4c9::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DC>(arg0, 6, b"DC", b"Dot Cat", b"Just a cat with dots ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000000239_23ec060f2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DC>>(v1);
    }

    // decompiled from Move bytecode v6
}

