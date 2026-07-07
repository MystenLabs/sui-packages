module 0x5ee7c2452206ada2d99ea1980324adb14a499b7d84468a9335eab1acad306192::HAEDALVaultLPT {
    struct HAEDALVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDALVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDALVAULTLPT>(arg0, 9, b"HAEDAL Vault LPT", b"HAEDAL Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/haedalvaultlpt_fb32d1ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAEDALVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDALVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

