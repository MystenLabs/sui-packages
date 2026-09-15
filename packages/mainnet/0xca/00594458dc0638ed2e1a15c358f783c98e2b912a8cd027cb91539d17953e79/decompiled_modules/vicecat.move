module 0xca00594458dc0638ed2e1a15c358f783c98e2b912a8cd027cb91539d17953e79::vicecat {
    struct VICECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vicecat-1SWIlB6E6Lk4wgLBLtEqy5XFZreXGa.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vicecat-1SWIlB6E6Lk4wgLBLtEqy5XFZreXGa.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<VICECAT>(arg0, 9, b"VICECAT", b"Vice Cat", b"Vicefun's very own cat. 70% of fees to holders. 25% to burn VICEFUN. 5% to platform.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICECAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICECAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VICECAT>>(0x2::coin::mint<VICECAT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

