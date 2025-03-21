module 0xd6554e18bb0f20c162fd26cf8a9ac155870e78877657e3b32c6fbc86278ad0cc::snog {
    struct SNOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOG>(arg0, 6, b"SNOG", b"Snog", b"In the digital ocean of Sui, there lived a mythical & adorable seahorse named Snog. His shimmering scales were the colors of the rainbow. Snog is the guardian spirit of the Sui blockchain, ensuring its harmony, security, and community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742516729774.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

