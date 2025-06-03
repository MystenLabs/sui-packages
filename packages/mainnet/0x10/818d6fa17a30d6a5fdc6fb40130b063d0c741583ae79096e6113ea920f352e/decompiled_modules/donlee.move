module 0x10818d6fa17a30d6a5fdc6fb40130b063d0c741583ae79096e6113ea920f352e::donlee {
    struct DONLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONLEE>(arg0, 6, b"DONLEE", b"SUI GANGSTER", b"DONLEE THE SUI GANGSTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie24dora7j6ovsxwwsvhxeprcyteiumxftfzjn3ppbxlncca335ia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONLEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONLEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

