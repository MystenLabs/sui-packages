module 0x2cdd6fc799412bc9eeefa923cb12b5228434109d9291f478a8268de1c9b565e9::silver {
    struct SILVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/cashcat-OjO9rPYHf85lVIUXrEOsTqcj9nz4IL.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/cashcat-OjO9rPYHf85lVIUXrEOsTqcj9nz4IL.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SILVER>(arg0, 9, b"SILVER", b"Silver Cat", b"Silver", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILVER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILVER>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SILVER>>(0x2::coin::mint<SILVER>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

