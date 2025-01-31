module 0xe0bc3502de786e95e915b37095c468772998b33b21bdfe5f35ce498121ca9615::ckt {
    struct CKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKT>(arg0, 6, b"CKT", b"ChuckleToken on sui", b"CKT has a talented, experienced and dedicated development team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_31_13_26_18_c92e59fcb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

