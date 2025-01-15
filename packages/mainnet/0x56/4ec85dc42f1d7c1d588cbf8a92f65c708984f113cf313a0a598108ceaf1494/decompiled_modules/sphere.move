module 0x564ec85dc42f1d7c1d588cbf8a92f65c708984f113cf313a0a598108ceaf1494::sphere {
    struct SPHERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHERE>(arg0, 9, b"SPHERE", b"Sphere AI", b"Sphere AI is a platform that allows users to use different AI models. It is built on the Solana blockchain and uses the SPHERE token as its native currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaCY44VP5XzCQmpqdqd25pxhb2mNcMLjASFYYw1BmBWEs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPHERE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPHERE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHERE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

