module 0x7bf488c05179ac143fffabc568e63203594a6ed347048e0a38bae29a1b751361::suitato {
    struct SUITATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATO>(arg0, 6, b"SUITATO", b"Just Suitato", b"just a potato but looks like sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictcxuzsy5ntb6ckfffru2q7za4uz4kdrartdzxeecf3o6k7jregu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

