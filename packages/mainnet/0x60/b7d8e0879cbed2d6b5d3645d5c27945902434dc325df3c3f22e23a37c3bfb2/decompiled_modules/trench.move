module 0x60b7d8e0879cbed2d6b5d3645d5c27945902434dc325df3c3f22e23a37c3bfb2::trench {
    struct TRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCH>(arg0, 6, b"TRENCH", b"THE TRENCH", b"Welcome to THE TRENCH (TRNCH), a community-driven and secure meme token on the Sui Blockchain. THE TRENCH is built to offer a fun yet reliable investment opportunity, combining the excitement of meme tokens with a focus on long-term growth and safety.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trench_9b05c82417.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

