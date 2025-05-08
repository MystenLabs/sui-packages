module 0x7e0767be754675ec9980a12c4b289d81cdfa1c6a392d209e488e959b4ccd5860::kiss {
    struct KISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISS>(arg0, 6, b"KISS", b"FREHLEYS COIN", b"Lets pump this shit to the moon, Screw Simmons!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhpsj6krm2h4yytghgl3ksrhhhmdxt53zq4ixn2j5bx2lpu2ubfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KISS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

