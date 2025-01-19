module 0xb5458cd2fe0c0c34db89754091555d2239943c6d89e59c8689f7ffbed75ff3ad::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA TRUMP", x"546865204f6666696369616c204d656c616e6961204d656d65206973206c697665206f6e20535549210a0a596f752063616e2062757920244d454c414e4941206e6f772e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ghr1e_Is_Xo_A_Ehk_Sx_b91e829852.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

