module 0xdcdb06745dce6d5f313acbaf107683896922ded0fb23b0f6d4c1ce910c1ffe9f::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKA>(arg0, 6, b"KAKA", b"KA KA is the new future", b"kaka on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

