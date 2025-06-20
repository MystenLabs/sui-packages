module 0x7ff53946ac8e12ff4ebaa3b147a61a35ccb7184d0257e8397c1f31ffb579d6c1::rucci {
    struct RUCCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUCCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUCCI>(arg0, 6, b"RUCCI", b"SUI RUCCI", b"Rucci is a revolutionary ocean themed crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiajcjr2l7rohvfyxek6wb5acp4ml4mzr4vd545bytx6clchh2e5by")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUCCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUCCI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

