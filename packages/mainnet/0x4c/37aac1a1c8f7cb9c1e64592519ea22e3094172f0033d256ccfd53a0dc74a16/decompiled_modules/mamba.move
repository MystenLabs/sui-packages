module 0x4c37aac1a1c8f7cb9c1e64592519ea22e3094172f0033d256ccfd53a0dc74a16::mamba {
    struct MAMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMBA>(arg0, 6, b"MAMBA", b"Suinake Mamba", b"just a snake mamba on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mamba_d2344b73f3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

