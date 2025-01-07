module 0x17b3d1ba021b91d07fb83d40827bd80becb04c1b8bd8c08e9880d1c6624163f2::gwoat {
    struct GWOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWOAT>(arg0, 6, b"GWOAT", b"Gwoat", b"Gwoat is a relentless gym-loving goat, he's forged his body into pure strength. Now, he uses his power to protect Sui, ready to crush any threat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GWOAT_498f666a7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

