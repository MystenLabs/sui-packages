module 0x2e0c5cc05e94a80d18ccddf2e459a633961520d7fe1485cf266a2a916ca0a1e7::juju {
    struct JUJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJU>(arg0, 9, b"JUJU", b"JUJU on SUI", b"JUJU is not art, let alone AI.\\r\\nit is just a meme.\\r\\n\\r\\n TIRED OF  FAKE  AI  AGENT  SCAM \\r\\n\\r\\n TAKES YOU  BACK  TO THE  REAL MEME  WORLD \\r\\n\\r\\n JUJU  LOVE  YOU  ALL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSN4EDccJDyB29XgqeDBvUZCwGokBr82tBpDRM2JRrou9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUJU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUJU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

