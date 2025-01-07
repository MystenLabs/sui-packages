module 0x81c54255a4b7206bd8c163dea09c420e6f3d2f843fa6ba6ed2163cf61e879de5::pythia {
    struct PYTHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYTHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYTHIA>(arg0, 6, b"PYTHIA", b"the world's first Cyber-Rodent", b"the world's first Cyber-Rodent PYTHIAAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X8_L91s_Cu_400x400_b17b75ac96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYTHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYTHIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

