module 0x417024e6ec5ef5fa7570874082470fd0a8686c773418b41b68c47e7a6a820f6a::mamba {
    struct MAMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMBA>(arg0, 6, b"MAMBA", b"Mambaswapnow", x"546865204b494e47206f66200a2020244d414d42412020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zoee_El_Lz_400x400_60c4c620b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

