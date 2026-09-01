module 0xc73be57124c02f8219cde01154986a6e28f65d6f9ea3d7f79db45bc5d018cbf7::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-02_at_00.06.51-adKnsBUW1KsbThXlhARld6gcxVm8Ua.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-02_at_00.06.51-adKnsBUW1KsbThXlhARld6gcxVm8Ua.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"Golden Goose", b"the goose lays gold  the gold makes you money.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GG>>(0x2::coin::mint<GG>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

