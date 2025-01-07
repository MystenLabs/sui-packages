module 0x8550680d5b400887fd825a58833fdd5d763a90b3632badf6ea58c61303ebd6f7::dogbit {
    struct DOGBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBIT>(arg0, 6, b"Dogbit", b"DOGBIT", b"Dogbit is a meme coin that combines humor with fast, secure, and low-cost transactions. Its community-driven and embraces internet culture, aiming to create a fun and accessible platform for crypto enthusiasts and meme lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/231_76c020b76f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

