module 0x4573b9aaa2910e782a28b297280436a4554afdd8c3194289f3a8e8515208d63::porkx {
    struct PORKX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORKX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORKX>(arg0, 6, b"PORKX", b"PorkX", x"24504f524b582047657420726561647920666f72207468652063727970746f207265766f6c7574696f6e207769746820504f524b5820436f696e202d2069742773206c696b6520726964696e67206120726f636b657420746f2066696e616e6369616c2066726565646f6d210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_da1ef53407.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORKX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORKX>>(v1);
    }

    // decompiled from Move bytecode v6
}

