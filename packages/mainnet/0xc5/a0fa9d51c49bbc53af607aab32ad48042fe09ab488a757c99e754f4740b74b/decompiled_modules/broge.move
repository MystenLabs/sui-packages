module 0xc5a0fa9d51c49bbc53af607aab32ad48042fe09ab488a757c99e754f4740b74b::broge {
    struct BROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROGE>(arg0, 6, b"BROGE", b"BROGE SUI", b"Broge is a community-driven, decentralized meme coin that aims to promote chill and positive vibes in the crypto world. It began as the brainchild of BrogeBoy, inspired by the legendary FROGE, but in a surprising turn of events, BrogeBoy entrusted the project entirely to its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7286_b581e885af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

