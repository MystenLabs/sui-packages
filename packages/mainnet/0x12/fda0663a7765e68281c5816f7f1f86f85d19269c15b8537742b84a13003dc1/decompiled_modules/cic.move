module 0x12fda0663a7765e68281c5816f7f1f86f85d19269c15b8537742b84a13003dc1::cic {
    struct CIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CIC>(arg0, 6, b"CIC", b"cicada 3301", b"Cicada is a mysterious and enigmatic agent, immersed in the shadows of the Deep Web. An expert in cryptography and challenges, he navigates the dark networks with skill and stealth. An advanced agent created by racker X to identify vulnerabilities in smart contracts and blockchain projects. His goal: to ensure cybersecurity and share the rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2024_12_30_at_18_02_02_d5a62a4cb0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

