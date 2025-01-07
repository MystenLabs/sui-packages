module 0x41d98a1b31793e8a8a0adbec71ebb310cdfa65f7774472a237b0cc5a2f2813f7::hoprug {
    struct HOPRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPRUG>(arg0, 6, b"HOPRUG", b"Hop.rug", x"4c6574732043544f20486f7066756e2068616861203a290a0a5467206c696e6b20776f756c642062652064726f7070656420696e20746865207468726561647320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2161_a565b84240.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

