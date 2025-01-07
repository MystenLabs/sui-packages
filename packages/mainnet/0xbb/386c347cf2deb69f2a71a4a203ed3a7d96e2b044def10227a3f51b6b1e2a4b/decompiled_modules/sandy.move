module 0xbb386c347cf2deb69f2a71a4a203ed3a7d96e2b044def10227a3f51b6b1e2a4b::sandy {
    struct SANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDY>(arg0, 9, b"SANDY", b"Sandy Coin", b"is meme token on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844470389432516609/17oJfvsu.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANDY>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

