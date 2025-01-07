module 0x29d6a26f870e1707b58939d5178619ca444c9b1f195a86906ca7e2f8d38f686b::goozi {
    struct GOOZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOZI>(arg0, 6, b"GOOZI", b"Sui Goozi", b"Goozi is a psycho goose who doesnt care about anything unless its cocaine. He doesnt even feel it anymore, he just needs it to stay woke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_19_T162654_166_95af6221b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

