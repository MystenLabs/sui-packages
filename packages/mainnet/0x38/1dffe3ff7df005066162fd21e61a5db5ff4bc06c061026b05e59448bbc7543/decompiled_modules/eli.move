module 0x381dffe3ff7df005066162fd21e61a5db5ff4bc06c061026b05e59448bbc7543::eli {
    struct ELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELI>(arg0, 6, b"Eli", b"smoleliseo", b"this is a GoFundMe for our captain mrGoldr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibl3e4vuwjwrfax2m255kffqf4656leslgz64hst4k7zs53qb3s7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

