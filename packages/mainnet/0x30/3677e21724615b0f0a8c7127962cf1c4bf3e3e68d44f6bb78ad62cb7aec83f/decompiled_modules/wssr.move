module 0x303677e21724615b0f0a8c7127962cf1c4bf3e3e68d44f6bb78ad62cb7aec83f::wssr {
    struct WSSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSSR>(arg0, 6, b"WSSR", b"Wasser", b"Community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3131_4b98cb718d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

