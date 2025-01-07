module 0x3e79bad1ab435bfcd58bddf8e90e23aa9dfa4c2615d74367820c5bf454e9c813::iusday {
    struct IUSDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSDAY>(arg0, 6, b"IUSDAY", b"IUS DAY", b"The IUS token is a memecoin of Sui Network, mirrors the narrative token of sui that is run by the community. We're building up the future of sui meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/458079976_1481095545875972_1164279931871181120_n_d1e73867d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUSDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

