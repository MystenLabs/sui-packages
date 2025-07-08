module 0xafb431722a4ca03c76bfd0eb37372d2b9e62afd11a3a66129e40398712bffeef::baldy {
    struct BALDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDY>(arg0, 6, b"BALDY", b"Baldy Man", b"Baldy Man is a meme token created for those who embrace boldness, simplicity, and humor. It has no grand promises, no elaborate roadmap, and no complex utility. Baldy Man represents a community that doesn't take itself too seriously and thrives on internet culture, satire, and shared laughs. It's about having fun, taking chances, and being part of something unapologetically different. No fluff, no filters, just a bald approach to the meme coin space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifsphoajabsrjrq63y72q5fqjjutct5vlpesfnhfyoa2xzqec6soe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BALDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

