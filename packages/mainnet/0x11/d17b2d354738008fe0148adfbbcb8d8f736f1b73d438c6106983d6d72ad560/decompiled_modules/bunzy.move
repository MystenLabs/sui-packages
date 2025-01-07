module 0x11d17b2d354738008fe0148adfbbcb8d8f736f1b73d438c6106983d6d72ad560::bunzy {
    struct BUNZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNZY>(arg0, 6, b"BUNZY", b"Bunzy Hop Mascot", x"6c65742043544f207468697320696465610a0a436f6d6d756e69747920616c776179732077696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_18_at_16_39_40_c024bb776e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

