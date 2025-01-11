module 0x5a44e894904f760a6aaff7b0675203c65434ac22a287de8609a490efb5ac1178::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SUIDeFAI by SuiAI", b"SUIDeFAI integrates DeFi and AI to form an AI-Powered DAO driven by crowd intelligence. Built on the SUI blockchain, it redefines decision-making in DeFi using advanced AI algorithms within a decentralized framework. Leveraging SUIs scalability, speed, and low costs, SUIDeFAI introduces a new standard for DeFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Asset_61344_75655a5f0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

