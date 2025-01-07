module 0xb1c413d6b32ccd9dade98af9b44177654b9a0294b90fcf9fe8992e524968637b::bluem {
    struct BLUEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEM>(arg0, 6, b"BLUEM", b"Blue-eyed Mouse", b"Blue-eyed mouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_13_ee2109e2dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

