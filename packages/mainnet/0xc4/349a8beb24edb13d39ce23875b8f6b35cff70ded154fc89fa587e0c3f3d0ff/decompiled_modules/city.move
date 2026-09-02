module 0xc4349a8beb24edb13d39ce23875b8f6b35cff70ded154fc89fa587e0c3f3d0ff::city {
    struct CITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12694-3P6twJFazDh0cmSgIT99HGkNu2nJt0.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12694-3P6twJFazDh0cmSgIT99HGkNu2nJt0.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<CITY>(arg0, 9, b"CITY", b"Vice City", x"5669636520436974790a0a582068747470733a2f2f782e636f6d2f56696365636974797375690a54656c656772616d2068747470733a2f2f742e6d652f5669636563697479737569", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CITY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CITY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CITY>>(0x2::coin::mint<CITY>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

