module 0xe03e63996d5cedc316a0cb33c22cec0bfe2aaf03a1893a2df7558c8062259ab7::sbae {
    struct SBAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAE>(arg0, 6, b"SBAE", b"Salt Bae", b"Inspired by the iconic Salt Bae meme, \"Salt Bae (SBAE)\" is a community-driven token. We're building a vibrant community with major partnerships, upcoming CEX listings, fast-tracked CMC & CG, airdrops, buybacks, and nonstop shilling. Join the Bae squad and claim your fair share today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sbae_32a0b26bd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

