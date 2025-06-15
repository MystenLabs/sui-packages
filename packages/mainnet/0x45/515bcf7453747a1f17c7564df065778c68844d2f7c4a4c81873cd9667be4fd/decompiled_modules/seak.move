module 0x45515bcf7453747a1f17c7564df065778c68844d2f7c4a4c81873cd9667be4fd::seak {
    struct SEAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAK>(arg0, 6, b"SEAK", b"SEAKING", b"Swimming To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqvs2ux7htkgccu5q5its5kgn3x3npms7ix7s4qrchznggujsndi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

