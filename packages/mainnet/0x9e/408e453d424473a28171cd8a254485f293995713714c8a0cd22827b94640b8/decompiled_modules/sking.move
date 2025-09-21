module 0x9e408e453d424473a28171cd8a254485f293995713714c8a0cd22827b94640b8::sking {
    struct SKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKING>(arg0, 6, b"SKING", b"Sui King", b"House of Adeniyi, throne of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicbybkp4swpgdmrwv25732zisrbboualascls3tpmkknyzfitjyhu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

