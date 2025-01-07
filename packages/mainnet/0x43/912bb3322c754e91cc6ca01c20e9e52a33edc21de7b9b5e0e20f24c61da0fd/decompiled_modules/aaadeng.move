module 0x43912bb3322c754e91cc6ca01c20e9e52a33edc21de7b9b5e0e20f24c61da0fd::aaadeng {
    struct AAADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADENG>(arg0, 6, b"AAADENG", b"aaaDeng", b"Can't stop, won't stop (talking about Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_791aedba99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

