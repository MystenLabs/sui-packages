module 0x1078373ee47fb9c74df9227d8f12fe70bb8e58a46f702275f8055fc5f81e27d0::raulstream {
    struct RAULSTREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAULSTREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAULSTREAM>(arg0, 9, b"RAULSTRM", b"Raul sream", b"dont buy this im just testing the Raul stream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRii3qBH5ewMV1vDDvb1H6YgETdQkGvYWRNTpV9Y5H5VM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAULSTREAM>(&mut v2, 1000000000000000000, @0x3004d90dae38a1f9f6e9890aa7332c5679cc7ae59d69940a55fe8a27711937f3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAULSTREAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAULSTREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

