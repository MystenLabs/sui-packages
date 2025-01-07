module 0x4e12c41043a9b5d3b13ad2d0460277b855757189b6bd2f6a1dacb47f5ab113b2::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"Slug", b"SuiSlug", b"Sui slug may be slow, be he's here to stay and he's racing towards the finish line.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731275720547.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

