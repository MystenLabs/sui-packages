module 0x180b7f745563a170bb9e781d19fa3a5abb7df61fc7b84eaa790095824fac75b7::beavy {
    struct BEAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVY>(arg0, 6, b"BEAVY", b"Beavy", b"BEAVY is a fun and vibrant meme coin on the Sui blockchain inspired by the hardworking and resourceful nature of beavers. It represents community strength, creativity, and sustainability. With BEAVY, we aim to build a lively ecosystem where users can engage, laugh, and prosper together. Join the BEAVY movement and let's craft something remarkable, one block at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_bbc0ca67fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

