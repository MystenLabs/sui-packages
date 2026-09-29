module 0xde8f8dd883fc9e9d924230981e0d09d9b4dbd3a29aa37dc556f5d2fc870ee2ba::asdfsdf {
    struct ASDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/DHfp9-5SWNuq1SOanMOZzp4cCRdHEsXh54jb.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/DHfp9-5SWNuq1SOanMOZzp4cCRdHEsXh54jb.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<ASDFSDF>(arg0, 9, b"ASDFSDF", b"asdfdf", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDFSDF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFSDF>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDFSDF>>(0x2::coin::mint<ASDFSDF>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

