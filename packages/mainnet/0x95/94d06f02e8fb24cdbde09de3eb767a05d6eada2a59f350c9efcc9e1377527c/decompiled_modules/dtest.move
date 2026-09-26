module 0x9594d06f02e8fb24cdbde09de3eb767a05d6eada2a59f350c9efcc9e1377527c::dtest {
    struct DTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_2549-qKBpOcjIiKT0RwyV52r3AJQRmXzCZM.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_2549-qKBpOcjIiKT0RwyV52r3AJQRmXzCZM.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<DTEST>(arg0, 9, b"DTEST", b"Dog test", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTEST>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DTEST>>(0x2::coin::mint<DTEST>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

