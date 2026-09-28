module 0x3b2fe754068aad1684ce37acc243cd65d4aa5ad9ab9d81df3cac00de003e13da::beta {
    struct BETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-28_at_3.29.17_PM-0Hdb60NdEAK4MYb2gmrEJ2dfSEj6Lj.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-28_at_3.29.17_PM-0Hdb60NdEAK4MYb2gmrEJ2dfSEj6Lj.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<BETA>(arg0, 9, b"BETA", b"beta", b"test", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BETA>>(0x2::coin::mint<BETA>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

