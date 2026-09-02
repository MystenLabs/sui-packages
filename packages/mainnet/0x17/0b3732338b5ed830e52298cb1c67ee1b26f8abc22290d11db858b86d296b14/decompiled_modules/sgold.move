module 0x170b3732338b5ed830e52298cb1c67ee1b26f8abc22290d11db858b86d296b14::sgold {
    struct SGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/60FC7B21-272F-4BFE-96DF-F8F95B6E48EA-pqIgStX1lZvbxephQxcXFKhpi8G9Jf.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/60FC7B21-272F-4BFE-96DF-F8F95B6E48EA-pqIgStX1lZvbxephQxcXFKhpi8G9Jf.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SGOLD>(arg0, 9, b"SGOLD", b"SUI GOLD", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGOLD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOLD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SGOLD>>(0x2::coin::mint<SGOLD>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

