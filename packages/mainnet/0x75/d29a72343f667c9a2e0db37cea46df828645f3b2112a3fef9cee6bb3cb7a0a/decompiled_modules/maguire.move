module 0x75d29a72343f667c9a2e0db37cea46df828645f3b2112a3fef9cee6bb3cb7a0a::maguire {
    struct MAGUIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGUIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGUIRE>(arg0, 6, b"MAGUIRE", b"MAGUIRE by SuiAI", b"MAGUIRE MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ggjafs_GWQA_An_CCM_bf8c1cf4bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGUIRE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGUIRE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

