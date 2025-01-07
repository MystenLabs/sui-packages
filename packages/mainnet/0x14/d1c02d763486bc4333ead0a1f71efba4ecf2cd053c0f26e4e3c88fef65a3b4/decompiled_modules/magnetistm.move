module 0x14d1c02d763486bc4333ead0a1f71efba4ecf2cd053c0f26e4e3c88fef65a3b4::magnetistm {
    struct MAGNETISTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNETISTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNETISTM>(arg0, 6, b"MAGNETISTM", b"Book of Magnet", b"DO NOT FADE THE BOOK OF MAGNET $MAGNETISM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bookofmagnet_7ee0a143f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNETISTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNETISTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

