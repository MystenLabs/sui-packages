module 0x5c360e500bb6d6caf56185f94d61e212355916c0c33e81a7b080fef48fa233ea::arth {
    struct ARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTH>(arg0, 9, b"ARTH", b"Arthur Test", b"Inspiration from Arthur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmXFArA9w9166DFCR6xWAKH3suPkejAx2tSg1neTMWVxdB")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

