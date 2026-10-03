module 0x9cdb3e8621f34e71d01dc29b9bb706c0d9169e51b43329191117e33ebaace1f1::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_6310-5ACUjWOmAicib4JweP5IcQmJjA0VFP.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_6310-5ACUjWOmAicib4JweP5IcQmJjA0VFP.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<FUCK>(arg0, 9, b"FUCK", b"Fuck David", b"SKIP and just HODL $LOFI", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<FUCK>>(0x2::coin::mint<FUCK>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

