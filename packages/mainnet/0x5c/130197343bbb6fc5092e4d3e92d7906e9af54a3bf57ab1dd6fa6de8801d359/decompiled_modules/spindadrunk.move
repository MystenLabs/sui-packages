module 0x5c130197343bbb6fc5092e4d3e92d7906e9af54a3bf57ab1dd6fa6de8801d359::spindadrunk {
    struct SPINDADRUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDADRUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDADRUNK>(arg0, 6, b"SpindaDrunk", b"Spinda On SUI", b"Spinning memes into cosmic chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp26ibysbyt34jlaq7x7qrpz255dy3fuaoqjfcrikk7owj2snmfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDADRUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDADRUNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

