module 0x4a72bcf44cba4ae6e73b0a148f9a740b96528b8cc1ce20bbe277b9ba7e956281::VC_SUI_USDC {
    struct VC_SUI_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VC_SUI_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VC_SUI_USDC>(arg0, 6, b"KD_MM1_VT", b"KriyaDeepbook-MM1-VaultToken", b"Vault token representing 1 unit of ownership in Kriya's Market Making Strategy on top of Deepbook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/NnGrFNF/cropped-image-2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VC_SUI_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VC_SUI_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

