module 0x36e8234cb27b93fe41cd367b5374a067107644bd559b46b14f6af086c1be6276::suisilv {
    struct SUISILV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISILV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000720910-IsUJ6sJmFgrPkhC6lVLag4JQLzP7RR.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000720910-IsUJ6sJmFgrPkhC6lVLag4JQLzP7RR.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUISILV>(arg0, 9, b"SUISILV", b"SUI SILVER", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISILV>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISILV>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISILV>>(0x2::coin::mint<SUISILV>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

