module 0xb8651be66267c66e2f366f4ecf6c441bb181276817b8697511bb4e6d6a5ff1da::cyte {
    struct CYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYTE>(arg0, 6, b"CYTE", b"COYOTES", b"Sui  Coyotes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexjbigjbersjt24th4c53dgoxwjb5cl54orvbmx56fhat5l5mmay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CYTE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

