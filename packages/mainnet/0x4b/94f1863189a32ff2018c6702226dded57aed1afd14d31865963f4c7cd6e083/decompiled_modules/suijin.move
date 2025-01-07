module 0x4b94f1863189a32ff2018c6702226dded57aed1afd14d31865963f4c7cd6e083::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin", b"$SUIJIN the God of water . https://the-demonic-paradise.fandom.com/wiki/Suijin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5264_3278b65bd7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

