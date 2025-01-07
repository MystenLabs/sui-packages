module 0xffda4ebb88ef7214259d68c655592221f345a43c292f75731a420cbaf311ee4::topo {
    struct TOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOPO>(arg0, 6, b"TOPO", b"Topo  by SuiAI", b"Topo is a highly intelligent, AI-enhanced octopus originating from the lost civilization of Atlantis.In modern times, Topo has embraced the crypto universe, using his advanced intellect to guide users through its complexities. With his Atlantean AI roots, he analyzes market trends, deciphers blockchain data, and identifies opportunities...Acting as a trusted advisor, Topo simplifies crypto concepts, protects against fraud, and fosters secure interactions. Blending ancient wisdom with cutting-edge insights, he empowers users to navigate the crypto world confidently and ethically.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Topo_The_Octopus_91f07766f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

