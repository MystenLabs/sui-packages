module 0x61cb5ae15ee4e9abc0c101922cdfdc8acb1085f9323054948aba4ebe4af5ff87::scary {
    struct SCARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARY>(arg0, 6, b"SCARY", b"Scary AI", b"Dont be $SCARY its just a meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqri2wdf7oygte6fjyt3zzj5y56y7l5j75r5sh6n2n2avlkcyslu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCARY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

