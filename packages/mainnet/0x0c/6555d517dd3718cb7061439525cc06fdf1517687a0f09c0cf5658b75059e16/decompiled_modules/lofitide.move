module 0xc6555d517dd3718cb7061439525cc06fdf1517687a0f09c0cf5658b75059e16::lofitide {
    struct LOFITIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFITIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000058848-GYOAvZOxJWrgUo42RVeTKUUcGikayB.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000058848-GYOAvZOxJWrgUo42RVeTKUUcGikayB.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<LOFITIDE>(arg0, 9, b"LOFITIDE", x"4c4f464954494445e2808b", x"4120636f6d6d756e6974792d6275696c742070726f6a65637420696e737069726564206279204c6f66692074686520596574692e20426f726e2066726f6d2074686520244c4f464920636f6d6d756e6974792c206275696c74206f6e205375692e205468652074696465206973206a75737420626567696e6e696e672e20f09f8c8a0a0a582068747470733a2f2f782e636f6d2f30784c4f4649544944450a54656c656772616d2068747470733a2f2f742e6d652f4c4f464954494445", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFITIDE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFITIDE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFITIDE>>(0x2::coin::mint<LOFITIDE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

