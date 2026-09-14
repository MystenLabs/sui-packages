module 0xce63a2ad34c1df350dcbd5e1d2d59fc4db24d03bbc8b3641f9d70cc35e5d8f24::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/lockin-ohggLwdXhBoCsBKu2IAkWXCLcKU4NE.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/lockin-ohggLwdXhBoCsBKu2IAkWXCLcKU4NE.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEST2>(arg0, 9, b"TEST2", b"test2", x"7465737432e2808b", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST2>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST2>>(0x2::coin::mint<TEST2>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

