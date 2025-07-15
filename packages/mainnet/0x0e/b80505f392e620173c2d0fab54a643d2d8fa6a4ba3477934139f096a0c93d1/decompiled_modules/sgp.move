module 0xeb80505f392e620173c2d0fab54a643d2d8fa6a4ba3477934139f096a0c93d1::sgp {
    struct SGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGP>(arg0, 6, b"SGP", b"Sui Guard Protection", b"SUI GUARD IS HERE , BE AWARE FROM ANY SCAM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzqwpmfw4kswvxvfkazmb7qag2mnp4fmf7p4yivihmdnbmtldsjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

