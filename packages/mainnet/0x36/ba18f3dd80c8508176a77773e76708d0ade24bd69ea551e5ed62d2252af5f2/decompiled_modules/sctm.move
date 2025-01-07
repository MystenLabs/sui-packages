module 0x36ba18f3dd80c8508176a77773e76708d0ade24bd69ea551e5ed62d2252af5f2::sctm {
    struct SCTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCTM>(arg0, 6, b"SCTM", b"BOOK OF SUI-CATMAN", b"ITS ABOUT TO HUNT U!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_5ba12e5da4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

