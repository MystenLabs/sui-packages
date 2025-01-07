module 0xbdeeb0213615b47fd45fd1e863f9a88907c8dabfc739012dad302612b4d41645::scarp {
    struct SCARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARP>(arg0, 6, b"SCARP", b"SUICARP", b"The CARP  on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_50_55_04e405b3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

