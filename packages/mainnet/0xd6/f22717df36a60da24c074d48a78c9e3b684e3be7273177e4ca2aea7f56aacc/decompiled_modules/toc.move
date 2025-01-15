module 0xd6f22717df36a60da24c074d48a78c9e3b684e3be7273177e4ca2aea7f56aacc::toc {
    struct TOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOC>(arg0, 6, b"TOC", b"Terminal Of Cat by SuiAI", b"The terminal cat is a mysterious and independent feline who prefers to spend time alone exploring their surroundings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_15_131357_0df467f11b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

