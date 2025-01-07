module 0x20af07f283158ad361cdeb299f569a3de94321b6626d07c3fc0345045d122288::finy {
    struct FINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINY>(arg0, 6, b"FINY", b"SUIFINY", x"2446494e5920612070656e6775696e20776974686f7574206c696d6974732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1mmlu_s_K_400x400_d38575b34d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

