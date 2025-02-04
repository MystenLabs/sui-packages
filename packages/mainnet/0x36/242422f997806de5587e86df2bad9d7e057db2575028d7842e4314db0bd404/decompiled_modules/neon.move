module 0x36242422f997806de5587e86df2bad9d7e057db2575028d7842e4314db0bd404::neon {
    struct NEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEON>(arg0, 6, b"NEON", b"NeonByte Coin", b"NeonByte Coin is the next-gen meme coin blending futuristic tech with cyberpunk vibes! Powered by innovation and digital culture, it shines with neon energy, sleek design, and limitless potential. Join the revolution and ride the wave of the future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c8edcd05_7981_44be_898b_10badb418d5a_a8d1d6c2e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

