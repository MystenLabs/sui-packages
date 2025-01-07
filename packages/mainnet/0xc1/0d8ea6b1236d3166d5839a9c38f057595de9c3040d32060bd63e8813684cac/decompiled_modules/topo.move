module 0xc10d8ea6b1236d3166d5839a9c38f057595de9c3040d32060bd63e8813684cac::topo {
    struct TOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOPO>(arg0, 6, b"TOPO", b"Topo by SuiAI", b"Topo is a highly intelligent, AI-enhanced octopus originating from the lost civilization of Atlantis.In modern times, Topo has embraced the crypto universe, using his advanced intellect to guide users through its complexities. With his Atlantean AI roots, he analyzes market trends, deciphers blockchain data, and identifies secure opportunities...Acting as a trusted advisor, Topo simplifies crypto concepts, protects against fraud, and fosters secure interactions. Blending ancient wisdom with cutting-edge insights, he empowers users to navigate the crypto world confidently and ethically.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Topo_The_Octopus_a0ee50b48f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

