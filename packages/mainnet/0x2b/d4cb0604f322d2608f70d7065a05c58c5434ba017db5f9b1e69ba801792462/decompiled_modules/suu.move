module 0x2bd4cb0604f322d2608f70d7065a05c58c5434ba017db5f9b1e69ba801792462::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 6, b"SUU", b"SuuFlex", b"SUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037280_66afd27287.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

