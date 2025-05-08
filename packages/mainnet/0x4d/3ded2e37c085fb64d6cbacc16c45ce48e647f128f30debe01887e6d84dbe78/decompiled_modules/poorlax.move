module 0x4d3ded2e37c085fb64d6cbacc16c45ce48e647f128f30debe01887e6d84dbe78::poorlax {
    struct POORLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POORLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORLAX>(arg0, 6, b"POORLAX", b"Poorlax", x"496e20537069726974212120506f6f7220496e205370697269742121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250509_010510_867457a3e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POORLAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

