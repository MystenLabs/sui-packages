module 0xe611631f54b5c1976fefa0d43514411e091b7e65010041471b835ee16ab1f697::prntszn {
    struct PRNTSZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRNTSZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRNTSZN>(arg0, 6, b"PrntSzn", b"Printing Season on Sui", x"49742773205072696e74696e6720536561736f6e206f6e205375692e200a0a41726520796f7520736964656c696e65643f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibfuswvvvwyvmdscdpixhhiwyonaiu7iatsa72xkob73qemr7nr7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRNTSZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRNTSZN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

