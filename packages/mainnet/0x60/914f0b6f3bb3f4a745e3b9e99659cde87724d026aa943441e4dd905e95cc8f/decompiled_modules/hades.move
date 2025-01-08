module 0x60914f0b6f3bb3f4a745e3b9e99659cde87724d026aa943441e4dd905e95cc8f::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADES>(arg0, 6, b"HADES", b"KOLMOGOROV HADES AGENT", b"KOLMOGOROV HADES is an innovative project on the Sui blockchain, designed to empower users with AI-driven article generation and assistance, similar to ChatGPT. Launching on the Movepump launchpad, this project features a fair tokenomics model with only 5% allocated to the team. By combining blockchain technology with advanced AI capabilities, KOLMOGOROV HADES aims to become a valuable tool for knowledge sharing and user support.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KOLMOGOROV_HADES_c136b5a378.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HADES>>(v1);
    }

    // decompiled from Move bytecode v6
}

