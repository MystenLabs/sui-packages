module 0x619489fc0ddebbce5b1af1020c3d18141c2edce00ce287e06f671fccaaf1f8b5::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: 0x2::coin::Coin<MEME>) {
        0x2::coin::burn<MEME>(arg0, arg1);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"BaBy", b"BaBy", b"A fun meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.memefi.club/landing/logo/memefi.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::coin::mint_and_transfer<MEME>(&mut v2, 1000000000000000000, @0xf0feaa6391efbbbf9064f725eb77949ddd016167feb83b7d9fbbf5694a936cae, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, @0xf0feaa6391efbbbf9064f725eb77949ddd016167feb83b7d9fbbf5694a936cae);
    }

    // decompiled from Move bytecode v6
}

