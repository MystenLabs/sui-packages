module 0x34aecfd3552a7c717a62a70c9626ec549d3e069aef94f172488dea207445ddfb::minos {
    struct MINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINOS>(arg0, 6, b"MINOS", b"Mino", b"Mino on Sui Shiba Origins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9134_203af7194a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

