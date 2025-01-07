module 0xa079e5a74b93952cb124999db8026af32b154b52da06e6ac830e9e77a6e0d6cc::moonix {
    struct MOONIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONIX>(arg0, 9, b"MOONIX", b"MOON", b"Meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90d50a7c-97fa-4974-9754-e103664cac24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

