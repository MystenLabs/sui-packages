module 0xd94386c246378ca075f737e2838ef1cbc9c6b0d3d5f47a335eb03b65c1547d15::snrkl {
    struct SNRKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNRKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNRKL>(arg0, 6, b"SNRKL", b"SNORKEL", b"The original aquatic enigma - Snorkel is the most iconic fish on SUI! Swim with SNRKL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibull7zsu6ac6u5jnj3p4a37qtdm7puj6kwvt7brki5novvn3zwdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNRKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNRKL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

