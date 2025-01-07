module 0x4b26b9069f5793a2561a9547c5c5d522ccfd230a48a6d2ea7d87431ecb30b9bf::suimala {
    struct SUIMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMALA>(arg0, 6, b"SUIMALA", b"Suimala", b"$SUIMALA  for President 2024. Show your support and join culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_03_053036_0acfa99064.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

