module 0x2a36a573fa3da738a4e7efc51444d127018f16cb9b17f93051ce209c35d2fee2::suimas {
    struct SUIMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAS>(arg0, 6, b"SUIMAS", b"Marry Christmas SUI", b"happy marry christmas SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_75_31ebe56e44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

