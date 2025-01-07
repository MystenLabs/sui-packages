module 0xac3634e7fb76224fe7582c9a32d48ed40eeca7eb7dcdce697388b6707a31adf5::suiby {
    struct SUIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBY>(arg0, 6, b"SUIBY", b"Suibydoo", b"Suiby, the delightful gem in the meme coin universe on the SUI blockchain. Suiby adds a cheerful spin with its Scooby-Doo!-inspired flair. Discover the whimsical world of SUIBY, where crypto dances with humor, and embark on the journey to the next big meme coin phenomenon on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_21672a0743.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

