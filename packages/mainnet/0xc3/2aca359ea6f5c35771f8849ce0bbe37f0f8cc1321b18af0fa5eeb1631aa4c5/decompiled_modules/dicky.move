module 0xc32aca359ea6f5c35771f8849ce0bbe37f0f8cc1321b18af0fa5eeb1631aa4c5::dicky {
    struct DICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKY>(arg0, 6, b"DICKY", b"DICKY ON SUI", b"The Biggest Dick On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihrv5oc4cueoc6ferhmfk24zzmf5l37z6jpuziiqgg5ymvzjme7su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DICKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

