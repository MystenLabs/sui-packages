module 0xa58a520c00bb419cf20bb80c19e45cb2ea17fd43516be422696f3abf0fbce348::shuimo {
    struct SHUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIMO>(arg0, 6, b"Shuimo", b"Shuimo on Sui", b"Shuimo is a community driven meme on SUI. 10% will be locked for 1 year. 3% for Marketing and 15% of trading fee will be used to buyback Shuimo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif24vh56tn6g4uxpelsnoyyblrggrvwhhmowshvvzagsz5ytj25lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHUIMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

