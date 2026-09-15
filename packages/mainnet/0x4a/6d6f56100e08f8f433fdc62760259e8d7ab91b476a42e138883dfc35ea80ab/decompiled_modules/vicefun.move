module 0x4a6d6f56100e08f8f433fdc62760259e8d7ab91b476a42e138883dfc35ea80ab::vicefun {
    struct VICEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vice-character-icon-6KQveH7cmgVV9GiGKXPe20J0lZvScB.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vice-character-icon-6KQveH7cmgVV9GiGKXPe20J0lZvScB.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<VICEFUN>(arg0, 9, b"VICEFUN", b"Vicefun", x"54686520746f6b656e20706c6174666f726d20666f72205669636566756e0a0a582068747470733a2f2f782e636f6d2f5669636546756e0a54656c656772616d2068747470733a2f2f742e6d652f5669636546756e0a576562736974652068747470733a2f2f7669636566756e2e636f6d", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICEFUN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICEFUN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VICEFUN>>(0x2::coin::mint<VICEFUN>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

