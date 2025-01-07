module 0x2ab39829782f8d68e9afeb62fac2092c3750c3c3a651dbf7af68f3d96663906::eggtrump {
    struct EGGTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGTRUMP>(arg0, 6, b"EGGTRUMP", b"EGG", b"https://t.me/eggtrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5930_d0088a0305.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

