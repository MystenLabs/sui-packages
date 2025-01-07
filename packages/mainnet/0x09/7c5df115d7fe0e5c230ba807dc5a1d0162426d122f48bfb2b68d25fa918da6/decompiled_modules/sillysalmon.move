module 0x97c5df115d7fe0e5c230ba807dc5a1d0162426d122f48bfb2b68d25fa918da6::sillysalmon {
    struct SILLYSALMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLYSALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLYSALMON>(arg0, 6, b"SILLYSALMON", b"SillySalmon Sui", b"The splashiest meme token on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000129_96c1ba8a98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLYSALMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLYSALMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

