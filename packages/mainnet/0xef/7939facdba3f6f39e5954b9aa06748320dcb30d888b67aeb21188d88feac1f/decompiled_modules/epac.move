module 0xef7939facdba3f6f39e5954b9aa06748320dcb30d888b67aeb21188d88feac1f::epac {
    struct EPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPAC>(arg0, 6, b"EPAC", b"ELONS POLITICAL ACTION COMMITTEE", x"24455041432028454c4f4e5320504f4c49544943414c20414354494f4e20434f4d4d4954544545290a244550414320697320612066726565646f6d2073757065727061632062726f7567687420746f20796f752062792074686520776f726c64732072696368657374206d616e2c20454c4f4e204d55534b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_03_32_39_05dc5d69fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

