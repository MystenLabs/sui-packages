module 0x8b84dc4d9e0be3d352aed954025343694a0fcfe363f2b6b98ec877ab109cfc6d::ponk {
    struct PONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK>(arg0, 6, b"PONK", b"PONK ON SUI", b"https://x.com/Balltzehk/status/1841509279465128426", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_e_I_cran_2024_10_02_a_I_20_38_12_9a14fe9732.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

