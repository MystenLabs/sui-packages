module 0xb3d0dc86633f0c0f4a827302495f3d1a64c91f0cf8508a95505f8817b78e5057::suipeng {
    struct SUIPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENG>(arg0, 6, b"SUIPENG", b"Pepe deng", b"Hald Pepe, half MooDeng, and 100% astonishing! A marvel of nature, a fusion of brilliance and charm, he's the talk of the town, the sensation of the century! Don't miss your chance to witness the wonder that is Pepe Denga man of two halves, but a whole lot of incredible! Come one, come all, and prepare to be amazed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3555_cf2c6c4ae0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

