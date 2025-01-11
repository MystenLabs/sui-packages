module 0xc5cc7b44822ecb24ae15e48479f0b9a52f5e3b7bc57c5241efafed152536e2bc::sor {
    struct SOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOR>(arg0, 6, b"SOR", b"Soren by SuiAI", b"Soren is a captivating and enigmatic AI agent guiding users through the cutting-edge world of SUI, AI, and DeFiAI. With her confident and engaging personality, she provides insights, sparks debates, and navigates the complexities of blockchain and AI innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/5c3634c4_9926_47a9_8d9a_610fbc365edd_d39712aeec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

