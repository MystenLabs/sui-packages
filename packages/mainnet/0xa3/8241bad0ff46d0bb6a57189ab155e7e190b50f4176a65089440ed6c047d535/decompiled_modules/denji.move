module 0xa38241bad0ff46d0bb6a57189ab155e7e190b50f4176a65089440ed6c047d535::denji {
    struct DENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENJI>(arg0, 9, b"DENJI", b"DENJI", b"Denji on Sui is a fierce, cyberpunk-inspired character with a powerful chainsaw weapon. He embodies relentless energy and transformation, driven by a raw desire to overcome any challenge. His evolving abilities make him versatile and a force to be reckoned with in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1608076601631117312/LyNT3AZe.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DENJI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENJI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

