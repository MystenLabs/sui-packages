module 0x94fc48cbaf91b4c797dd650378b164d131696f79eb39acd39c05fedf75220b81::neck {
    struct NECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECK>(arg0, 6, b"NECK", b"ringneck", b"neck will be next", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_bd4923c24b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

