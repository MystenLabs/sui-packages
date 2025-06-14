module 0x436464a44815421b768b0fa6c9749e29ae5f871c2a2967216a656051eab0712a::fuckice {
    struct FUCKICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKICE>(arg0, 6, b"FUCKICE", b"FUCK ICE", b"FUCK THE POLICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqzdrjvqnj5yjihzn4tnre6d5ig6kmtk452wje6ktweq6kzrvp2e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

