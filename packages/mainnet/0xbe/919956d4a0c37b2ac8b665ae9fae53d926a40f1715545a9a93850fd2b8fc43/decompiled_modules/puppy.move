module 0xbe919956d4a0c37b2ac8b665ae9fae53d926a40f1715545a9a93850fd2b8fc43::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 2, b"Puppy", b"Dog Puppy", b"Dog Puppy who is always cheerful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://e7.pngegg.com/pngimages/385/464/png-clipart-dog-puppy-caricature-euclidean-cartoon-brown-dog-cartoon-character-comics.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPPY>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

