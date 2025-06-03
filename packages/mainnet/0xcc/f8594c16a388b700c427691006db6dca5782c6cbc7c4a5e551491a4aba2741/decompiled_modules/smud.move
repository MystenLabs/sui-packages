module 0xccf8594c16a388b700c427691006db6dca5782c6cbc7c4a5e551491a4aba2741::smud {
    struct SMUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUD>(arg0, 6, b"SMUD", b"Mudkips", b"i herd u liek them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamjtqizymkdtvdwnqhbqrs62pxmk43gy35z24sbrkhfq5seemxpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMUD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

