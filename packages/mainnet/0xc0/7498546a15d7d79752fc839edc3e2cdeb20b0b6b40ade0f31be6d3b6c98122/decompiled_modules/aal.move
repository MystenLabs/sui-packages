module 0xc07498546a15d7d79752fc839edc3e2cdeb20b0b6b40ade0f31be6d3b6c98122::aal {
    struct AAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAL>(arg0, 6, b"AAL", b"Agent Alien", b"Your Best Agent in Milky Way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alien_733b3a8e01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

