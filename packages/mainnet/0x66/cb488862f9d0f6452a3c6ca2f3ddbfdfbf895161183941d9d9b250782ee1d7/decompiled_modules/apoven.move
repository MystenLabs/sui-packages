module 0x66cb488862f9d0f6452a3c6ca2f3ddbfdfbf895161183941d9d9b250782ee1d7::apoven {
    struct APOVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOVEN>(arg0, 6, b"APOVEN", b"APO THE VEN", b"Sui ecosystem favouring all and sundry in the space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_213318_031_b745a95b00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APOVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

