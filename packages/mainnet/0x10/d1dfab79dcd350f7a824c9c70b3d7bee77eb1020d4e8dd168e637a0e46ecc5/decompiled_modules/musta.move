module 0x10d1dfab79dcd350f7a824c9c70b3d7bee77eb1020d4e8dd168e637a0e46ecc5::musta {
    struct MUSTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTA>(arg0, 6, b"MUSTA", b"GENTEL", b"Mustaches league", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4583922_D91_D_425_C_8_BFD_5068521_BB_5_AE_2be46e72aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

