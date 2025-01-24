module 0xb342b533d4d1fd1ca156c39c8a9e3a40a80eb2572d01da245c0cd6ddddd9b2f5::nono {
    struct NONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONO>(arg0, 6, b"NONO", b"Nono The Elephant", b"More Than Just a Meme - At Nono, we believe in the transformative power of memes to bring delight and exhilaration to the world of crypto. Our mission is to build a token that transcends mere hype, fostering a vibrant community centered around values like transparency, inclusivity, and good-natured fun. Join us in shaping the future of finance with a touch of humor and a whole lot of heart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nono_logo_1_1_1d3172b78f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

