module 0xcfdde47b089435640ec868ac2c61b8412ca94188b752ea253d5afadd76c3cd67::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"BWAL", b"Baby Walrus", b"BWAL may stand out due to its strong community support, a key factor in the growth of meme coins. If the project has a smart marketing strategy, such as leveraging social media like X to spread the message, or collaborating with influencers (KOLs), t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747930318125.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

