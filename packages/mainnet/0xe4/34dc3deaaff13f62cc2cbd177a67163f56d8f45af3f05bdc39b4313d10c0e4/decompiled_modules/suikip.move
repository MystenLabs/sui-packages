module 0xe434dc3deaaff13f62cc2cbd177a67163f56d8f45af3f05bdc39b4313d10c0e4::suikip {
    struct SUIKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIP>(arg0, 6, b"Suikip", b"Mudsuikip", b"Another meme pokemon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9700_0b3238e409.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

