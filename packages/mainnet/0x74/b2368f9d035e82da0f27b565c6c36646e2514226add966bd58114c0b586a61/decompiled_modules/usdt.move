module 0x74b2368f9d035e82da0f27b565c6c36646e2514226add966bd58114c0b586a61::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"United States Donald Trump", b"The USDT \"United States Donald Trump\" index is a satirical memecoin that combines cryptocurrency with the cultural and political influence of former U.S. President Donald Trump. Its designed as a digital asset within the memecoin category, where its value and popularity are often driven more by internet culture, meme status, and social media hype than by traditional economic fundamentals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_004454_904_7bc5b725a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

