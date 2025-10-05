module 0xddd8910135ff2fc1a77a0d5f4386857fdf5870af1486a2beafc3a9cc1319fe1d::myfam {
    struct MYFAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYFAM>(arg0, 6, b"MYFAM", b"My Fam Consultant AI", b"MyFamConsultantAI is an AI-powered smart contract consultant and automation advisor built on the Sui blockchain. It helps businesses design, audit, and optimize their smart contracts and tokenomics while automating blockchain workflows for transparency and growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/MF_3933f4a1ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYFAM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYFAM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

