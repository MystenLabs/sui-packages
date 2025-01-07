module 0x1bc9374e9ac7938d8d62758950bb8186df937818c2c44b63904126f2b803903f::blepe {
    struct BLEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEPE>(arg0, 6, b"BLEPE", b"Blue Pepe", b"$BLEPE The Blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_21_12_53_175a4631fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

