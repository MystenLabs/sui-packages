module 0xc4831f8d187f6317154de9e8ed9e43fc50ed5e7db7e13d416465fa823a5e4b43::suiluga {
    struct SUILUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILUGA>(arg0, 6, b"SUILUGA", b"LUGALUGA", x"69742061206c756761207768616c652e2069742061207370792e20736f6d652074686e6b206d65204876616c64696d6972206275742069646b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_014036719_c482535b4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

