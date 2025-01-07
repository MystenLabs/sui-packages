module 0x4870c0d5ea3788ce83c46a964416cc2078cd234562b15fe51a165bf529a3cbf4::saaag {
    struct SAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAAAG>(arg0, 6, b"SAAAG", b"SAAAGULL", x"566972616c2073656167756c6c206d656d652c206e6f77206c61756e63686564206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014539_4289221576.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAAAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAAAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

