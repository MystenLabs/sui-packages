module 0xdb7a1e62d5c452e876de8756377bcba9f135a3fc7d5b0692e5544c0b0feba755::cwat {
    struct CWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAT>(arg0, 6, b"CWAT", b"Sui Cwat", b"You can either fw it or just pet it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_b238f4e047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

