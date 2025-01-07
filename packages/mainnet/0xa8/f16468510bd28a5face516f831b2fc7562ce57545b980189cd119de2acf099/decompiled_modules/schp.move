module 0xa8f16468510bd28a5face516f831b2fc7562ce57545b980189cd119de2acf099::schp {
    struct SCHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHP>(arg0, 6, b"SCHP", b"SUCHIP", b"Sui Chip on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4785_024c780f76.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

