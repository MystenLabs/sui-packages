module 0xc16c97acc22e9a96b300060a1d800e2d2873c6a4bb1ca5ee0e54d5a2a69868d9::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"FRUG", b"FOMO FROG", b"FOMO FROG SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fomo_Frog_TQFK_5h_z_R8_Beo5dy7xu_393e29acd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

