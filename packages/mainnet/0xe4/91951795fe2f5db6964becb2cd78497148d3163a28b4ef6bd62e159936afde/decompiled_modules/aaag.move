module 0xe491951795fe2f5db6964becb2cd78497148d3163a28b4ef6bd62e159936afde::aaag {
    struct AAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAG>(arg0, 6, b"Aaag", b"aaaGiraffe", x"4d6f737420726574617264696f2047697261666665206f6e205355490a0a43544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giraffe_aaa_1b9b56b790.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

