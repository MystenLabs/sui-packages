module 0x59e1afe008771f58d21bac5020cfc1d4f476e9556472d800ba1a793e1439c51d::sfree {
    struct SFREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFREE>(arg0, 6, b"SFree", b"Syrien", b"Habibi welcome to Damascus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061047_215e2183b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

