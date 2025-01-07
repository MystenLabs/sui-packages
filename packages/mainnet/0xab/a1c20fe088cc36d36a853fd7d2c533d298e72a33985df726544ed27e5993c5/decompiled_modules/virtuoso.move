module 0xaba1c20fe088cc36d36a853fd7d2c533d298e72a33985df726544ed27e5993c5::virtuoso {
    struct VIRTUOSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRTUOSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIRTUOSO>(arg0, 6, b"VIRTUOSO", b"Virtuoso [Never DM]", b"buy bunnding suun imma no iscame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_14_14_24_f5ea97175b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRTUOSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRTUOSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

