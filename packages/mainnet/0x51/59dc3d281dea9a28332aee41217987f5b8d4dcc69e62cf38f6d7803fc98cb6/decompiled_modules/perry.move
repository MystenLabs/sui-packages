module 0x5159dc3d281dea9a28332aee41217987f5b8d4dcc69e62cf38f6d7803fc98cb6::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"The Sui Agent", b"PERRY who leads a double life as the best $SUI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capa_53_513eb6b836.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

