module 0x8e7ce9b7fd703c32d1918b2742932ce4cc70fecaf1ddcecc3b18c9f2de020938::boppy {
    struct BOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPPY>(arg0, 6, b"BOPPY", b"Boppy the Bat", b" Say hello to Boppy the Bat, the nights newest hero!  Hes flying straight outta the cave to shake up the meme coin game. Fast, fearless, and ready to take flight, Boppys here to bring the bat vibes to the sui blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_28_12_41_03_55a83e976f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

