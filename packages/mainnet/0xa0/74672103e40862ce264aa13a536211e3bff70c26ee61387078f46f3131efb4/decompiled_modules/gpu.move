module 0xa074672103e40862ce264aa13a536211e3bff70c26ee61387078f46f3131efb4::gpu {
    struct GPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ChatGPT_Image_Sep_17__2026__05_50_53_PM-Vhsr47slpikSkbmkoh3F7Ump0PdFBW.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ChatGPT_Image_Sep_17__2026__05_50_53_PM-Vhsr47slpikSkbmkoh3F7Ump0PdFBW.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GPU>(arg0, 9, b"GPU", x"475055e2808b", x"4669727374204d656d6520706169722077697468205265616c2053746f636b73204e5644410a0a582068747470733a2f2f782e636f6d2f7468656770756f6e766963650a54656c656772616d2068747470733a2f2f742e6d652f2b6b552d574e4a2d546e5a4131596a686c", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPU>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPU>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GPU>>(0x2::coin::mint<GPU>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

