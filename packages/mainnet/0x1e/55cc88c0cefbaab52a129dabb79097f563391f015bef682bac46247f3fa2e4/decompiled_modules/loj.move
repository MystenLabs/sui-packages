module 0x1e55cc88c0cefbaab52a129dabb79097f563391f015bef682bac46247f3fa2e4::loj {
    struct LOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOJ>(arg0, 6, b"LOJ", b"MKLOJ2025", b"Maria Kreyn, Life on Jupiter, 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arttoo.co/artworks/coin/loj.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

