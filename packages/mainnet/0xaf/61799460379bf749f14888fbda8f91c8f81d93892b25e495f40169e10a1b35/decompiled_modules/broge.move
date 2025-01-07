module 0xaf61799460379bf749f14888fbda8f91c8f81d93892b25e495f40169e10a1b35::broge {
    struct BROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROGE>(arg0, 6, b"BROGE", b"BROGE SUI", b"Meet BROGE, the laid-back meme token on #SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe8e55a847bb446d967ef92f4580162fb8f2d3f38_9f99c3d92e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

