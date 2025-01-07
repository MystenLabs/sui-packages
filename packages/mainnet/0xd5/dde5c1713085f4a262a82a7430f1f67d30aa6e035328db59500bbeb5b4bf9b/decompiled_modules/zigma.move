module 0xd5dde5c1713085f4a262a82a7430f1f67d30aa6e035328db59500bbeb5b4bf9b::zigma {
    struct ZIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIGMA>(arg0, 6, b"ZIGMA", b"Zigma", x"5a49474d4120210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RS_Ssst_S_Yvv_UK_1q5_Zin_WZE_4_Pfcg15_S3_KZJ_Xx_Emxkcr3_Le_73b09c3358.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

