module 0x6cd767afc539ca6fcb45b1b67a9487aba346590ba856fd83c85244de6b146b13::aaadick {
    struct AAADICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADICK>(arg0, 6, b"AAADICK", b"aaaMobyDick", b"Inspired by the legendary Moby Dick, $aaaDick brings the power of the high seas to the blockchain! With its colossal presence, this token dives deep into the ocean of meme culture, capturing the relentless spirit of the iconic whale. Just like Captain Ahab's obsession, $aaaDick is here to make millys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_4_0fe6e68758.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

