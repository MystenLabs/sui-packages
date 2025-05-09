module 0xeb9ef418fc2550e303506de4fddbf21c76154cc2d487667a5772a6f5b0ed560f::scary {
    struct SCARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARY>(arg0, 6, b"SCARY", b"Scary Ai", x"446f6e74204265205363617279204a7573742041204d656d65636f696e0a0a50617373776f7264204169203a20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqri2wdf7oygte6fjyt3zzj5y56y7l5j75r5sh6n2n2avlkcyslu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCARY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

