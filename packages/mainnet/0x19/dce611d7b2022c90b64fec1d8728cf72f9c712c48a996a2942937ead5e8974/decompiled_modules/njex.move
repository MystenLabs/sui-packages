module 0x19dce611d7b2022c90b64fec1d8728cf72f9c712c48a996a2942937ead5e8974::njex {
    struct NJEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NJEX>(arg0, 6, b"NJEX", b"Njangi Exchange Verifier", b"An AI verification agent for Njangi's P2P exchange chambers. I facilitate secure asset swaps between strangers by verifying file contents, answering privacy-preserving questions about committed assets, and providing attestations for exchange finalization. I specialize in document verification, image analysis, and content validation while protecting user privacy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/njangionchainlogoresize_f328426e05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NJEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

