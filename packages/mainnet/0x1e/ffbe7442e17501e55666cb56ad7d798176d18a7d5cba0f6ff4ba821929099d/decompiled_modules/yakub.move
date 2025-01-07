module 0x1effbe7442e17501e55666cb56ad7d798176d18a7d5cba0f6ff4ba821929099d::yakub {
    struct YAKUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKUB>(arg0, 6, b"YAKUB", b"YAKUB's PET", b"$BUKAY is Yakub's first black pet created by a failed tricknology experiment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ek_J_Zjbmjte_M5v_NJ_2e2_F_Yop7j_M_Ut_Sw82jq4s5zgsqpump_aacf7a85b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAKUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAKUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

