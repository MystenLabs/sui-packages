module 0xea3d461da4cf610debcf0265b287e7904cb9cfc85835b7aa491f6e5b824bf2c9::aaadick {
    struct AAADICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADICK>(arg0, 6, b"aaaDick", b"aaaMobyDick", b"Inspired by the legendary Moby Dick, $aaaDick brings the power of the high seas to the blockchain! With its colossal presence, this token dives deep into the ocean of meme culture, capturing the relentless spirit of the iconic whale. Just like Captain Ahab's obsession, $aaaDick is here to make waves, becoming a force to be reckoned with in the crypto space. Whether you're chasing fortune or fun, dont miss out on the wild ride aboard this whale!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_4_5d20d32297.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

