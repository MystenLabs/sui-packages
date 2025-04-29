module 0x54d9a70d5d6d84bf1299c7d28f982905348fa67832dcb4e1ce85d89fb6876e40::glove {
    struct GLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOVE>(arg0, 6, b"Glove", b"Gay Love", b"They love each other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002799_3339c0b6eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

