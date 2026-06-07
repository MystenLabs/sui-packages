module 0x5cc8c3104d8a5d1da30e5b5dbf6a1bf65b0503aa1a7dfd1b2d4a20128ec18a2f::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"DROP", b"SuiDrop", b"Trustless File Transfer Protocol. SuiDrop encrypts in your browser, stores the blob on Walrus, and anchors a verifiable receipt on Sui. No server ever sees your file or your key.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjuz4ujvgifs5mhfhjb4pm3lavvbpecgyel22cwbnshdbr4e5sse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

