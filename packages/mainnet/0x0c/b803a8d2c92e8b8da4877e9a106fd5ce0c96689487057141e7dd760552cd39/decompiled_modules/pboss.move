module 0xcb803a8d2c92e8b8da4877e9a106fd5ce0c96689487057141e7dd760552cd39::pboss {
    struct PBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBOSS>(arg0, 6, b"PBOSS", b"BOSSPEPE", b"PepeBoss the  Meme Kings coin, powered by laughs, primed for gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maf_b7b1c52776.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

