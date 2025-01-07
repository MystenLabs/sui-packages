module 0xbbd626fe1538dacc4ad5d8581756ff490bc1dcd600a23dbeeb961780b6c3caf2::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"HANA", b"HANA SUI", b"Hana is token on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CS_7y_X_As47_Y9_Mhf_QK_5aigdu3_P74j_GLLM_1a4_NQ_8d51_Y_Uf8_739fe57f85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

