module 0x99fa44445474e7548f2563e5e9cef5110bad1e2a0adf76ae84bfc0651acf1875::pup {
    struct PUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUP>(arg0, 6, b"PUP", b"SlopFatherPup", b"Pup & Slop, Pup & Slop, Pup & Slop, Pup & Slop. SlopFatherPup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5046_2023ac280e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

