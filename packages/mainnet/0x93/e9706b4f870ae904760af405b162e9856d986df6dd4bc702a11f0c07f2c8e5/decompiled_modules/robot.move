module 0x93e9706b4f870ae904760af405b162e9856d986df6dd4bc702a11f0c07f2c8e5::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"werobot", b"WEROBOT AI: The First On-Chain AI Robot for Everyone Introducing your AI companion on-chain. WEROBOT AI stands as a competitor to ChatGPT, offering a more transparent platform that champions free speech. Join us in experiencing a new era of AI interaction!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wo_Cm_T9_T7_W6_U_Knwtc4_C3_L39_Raaz_E_Dz_Na_Hp_HA_Gudm26x_Up_8b1d58e550.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

