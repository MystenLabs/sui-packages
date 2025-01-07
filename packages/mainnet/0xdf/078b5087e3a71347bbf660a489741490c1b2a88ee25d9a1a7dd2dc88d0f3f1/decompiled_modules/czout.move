module 0xdf078b5087e3a71347bbf660a489741490c1b2a88ee25d9a1a7dd2dc88d0f3f1::czout {
    struct CZOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZOUT>(arg0, 6, b"CZOUT", b"CZNOUTNOW", b"As CZ prepares to walk free from jail this meme coin captures the power of his influence and his legendary status in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/35634_a37a5086d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

