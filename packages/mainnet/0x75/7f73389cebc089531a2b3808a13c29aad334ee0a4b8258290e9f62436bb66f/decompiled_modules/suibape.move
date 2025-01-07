module 0x757f73389cebc089531a2b3808a13c29aad334ee0a4b8258290e9f62436bb66f::suibape {
    struct SUIBAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAPE>(arg0, 6, b"SUIBAPE", b"BRAZILIAN APE SUI", b"BRAZILIAN APE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAPECLUB_833b7a9f60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

