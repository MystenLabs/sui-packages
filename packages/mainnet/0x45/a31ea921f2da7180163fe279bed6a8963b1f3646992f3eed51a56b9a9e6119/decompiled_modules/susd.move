module 0x45a31ea921f2da7180163fe279bed6a8963b1f3646992f3eed51a56b9a9e6119::susd {
    struct SUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ChatGPT_Image_Sep_2__2026__12_42_34_PM-glxAo1qNz34CviMqdGe7xQpe74C1k4.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ChatGPT_Image_Sep_2__2026__12_42_34_PM-glxAo1qNz34CviMqdGe7xQpe74C1k4.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUSD>(arg0, 9, b"SUSD", b"SUI DOLLAR", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUSD>>(0x2::coin::mint<SUSD>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

