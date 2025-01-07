module 0x26442d1cd6b087d5536421068a18716bbf5f35f12d94c9d671c32a7ba295e873::todd {
    struct TODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODD>(arg0, 6, b"Todd", b"Peter Todd", b"Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f5r3_ZOU_400x400_3188e7cda4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

