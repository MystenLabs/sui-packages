module 0xfbfa1e6e2fd7e37bec5ab612c25d11e0062b66da0afed3db47523d7257f65912::katsui {
    struct KATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATSUI>(arg0, 6, b"KATSUI", b"Chicken Katsui", b"Nothing, just a chicken katsu.. who doesn't like that?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8981_scaled_9f7c62e338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

