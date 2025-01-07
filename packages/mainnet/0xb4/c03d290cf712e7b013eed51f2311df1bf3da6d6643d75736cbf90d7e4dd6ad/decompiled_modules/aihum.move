module 0xb4c03d290cf712e7b013eed51f2311df1bf3da6d6643d75736cbf90d7e4dd6ad::aihum {
    struct AIHUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIHUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIHUM>(arg0, 6, b"AIHUM", b"AI VS HUMAN by SuiAI", b"BELIEVE IN HUMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_19_50_17_A_futuristic_and_dynamic_illustration_showing_a_robotic_hand_and_a_human_hand_reaching_toward_each_other_symbolizing_collaboration_and_competition_T_57ff8faac2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIHUM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIHUM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

