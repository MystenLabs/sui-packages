module 0x836e431fcb6029a5610db59e9bb5e0633f84db1ab328cf9e88b4c8902f0c1613::asmash {
    struct ASMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASMASH>(arg0, 6, b"ASMASH", b"Abstract Smash", b"ere Abstract Bross Smash  the upcoming token on the Abstract Network for internet meme culture and crypto. Featuring a beautiful and fantastic meme that whether youre here to relive your arcade days,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suihead3_b69bcb25ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASMASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASMASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

