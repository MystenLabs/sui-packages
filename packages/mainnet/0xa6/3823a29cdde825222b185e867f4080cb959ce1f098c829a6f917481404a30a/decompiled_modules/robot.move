module 0xa63823a29cdde825222b185e867f4080cb959ce1f098c829a6f917481404a30a::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"WEROBOT AI", b"WEROBOT AI: The First On-Chain AI Robot for Everyone Introducing your AI companion on-chain. WEROBOT AI stands as a competitor to ChatGPT, offering a more transparent platform that champions free speech. Join us in experiencing a new era of AI interaction!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wo_Cm_T9_T7_W6_U_Knwtc4_C3_L39_Raaz_E_Dz_Na_Hp_HA_Gudm26x_Up_bd9c800dd5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

