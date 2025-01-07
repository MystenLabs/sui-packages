module 0x6d4ede96d0df9a809db5d302b0e2034460e1083b6c4658e0c3a70f3a47bb1303::lsm {
    struct LSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSM>(arg0, 6, b"LSM", b"Laugh-o-SuiMatic", b"The new AI agent that tells jokes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_06_12_46_31_A_futuristic_AI_represented_as_a_humanoid_robot_with_a_cheerful_face_standing_on_a_comedy_stage_holding_a_microphone_and_telling_jokes_The_setting_85d93a2aa1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

