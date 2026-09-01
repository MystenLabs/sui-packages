module 0x9d821885bbe2f639f548d8bb865b726a1a502b4ade9e72fbec5fbe9686449922::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/images__6_-21KUf9EoH934RGlpcxHGmHRJrW8iTJ.jfif";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/images__6_-21KUf9EoH934RGlpcxHGmHRJrW8iTJ.jfif"))
        };
        let (v2, v3) = 0x2::coin::create_currency<AIDA>(arg0, 9, b"AIDA", x"41494441e2808b", x"41494441e2808be2808b", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<AIDA>>(0x2::coin::mint<AIDA>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

