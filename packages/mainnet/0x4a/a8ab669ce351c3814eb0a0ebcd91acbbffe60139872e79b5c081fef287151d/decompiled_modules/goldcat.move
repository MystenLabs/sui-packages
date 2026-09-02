module 0x4aa8ab669ce351c3814eb0a0ebcd91acbbffe60139872e79b5c081fef287151d::goldcat {
    struct GOLDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/292F2E95-2B37-404E-B40F-ABC39BCEC905-DXopoIqhPrj2lzx4IAtWITGdWCwI28.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/292F2E95-2B37-404E-B40F-ABC39BCEC905-DXopoIqhPrj2lzx4IAtWITGdWCwI28.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GOLDCAT>(arg0, 9, b"GOLDCAT", b"gold CAT", x"5765206e6565646564206120676f6c644341540a0a582068747470733a2f2f782e636f6d2f676f6c646361745f78797a", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDCAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDCAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDCAT>>(0x2::coin::mint<GOLDCAT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

