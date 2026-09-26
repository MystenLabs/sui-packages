module 0x329bf21adcd5fc0af19f27ef96e406cbd2ac97cc42aab0e79f970cd51cc4156a::glofi2 {
    struct GLOFI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOFI2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/gold-token-pfp-6PxbMj5GjF5TGppvWUHnwNPOOMhcqV.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/gold-token-pfp-6PxbMj5GjF5TGppvWUHnwNPOOMhcqV.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GLOFI2>(arg0, 9, b"GLOFI2", b"gold lofi2", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOFI2>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOFI2>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOFI2>>(0x2::coin::mint<GLOFI2>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

