module 0xa5194cbaf94c9fcd978e20b1ef337c5540e5ed9ded7dd93f112f92c9a9f1a926::rush {
    struct RUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/goldrush-fJMAAHc5of9t9OCfptxsVVi47qIDWi.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/goldrush-fJMAAHc5of9t9OCfptxsVVi47qIDWi.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<RUSH>(arg0, 9, b"RUSH", b"Gold Rush", b"The Sui Gold Rush is here", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUSH>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSH>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<RUSH>>(0x2::coin::mint<RUSH>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

