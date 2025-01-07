module 0x92820fe2316099007ba79ff45a26febb5ab1d1eef3523884fc7008ef0de1638::shepe {
    struct SHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPE>(arg0, 6, b"SHEPE", b"SHARK PEPE", b"The OG has been reborn on SUI as a shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0277_4be216cb21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

