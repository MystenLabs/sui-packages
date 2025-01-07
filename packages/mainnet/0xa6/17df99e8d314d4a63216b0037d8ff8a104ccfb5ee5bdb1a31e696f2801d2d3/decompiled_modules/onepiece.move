module 0xa617df99e8d314d4a63216b0037d8ff8a104ccfb5ee5bdb1a31e696f2801d2d3::onepiece {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE>(arg0, 9, b"onepiece", b"One Piece", b"ONEPIECE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/576/460/large/-2.jpg?1727937341")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONEPIECE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPIECE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEPIECE>>(v1);
    }

    // decompiled from Move bytecode v6
}

