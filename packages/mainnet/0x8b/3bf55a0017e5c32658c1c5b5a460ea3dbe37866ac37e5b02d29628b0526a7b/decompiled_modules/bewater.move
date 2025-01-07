module 0x8b3bf55a0017e5c32658c1c5b5a460ea3dbe37866ac37e5b02d29628b0526a7b::bewater {
    struct BEWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWATER>(arg0, 6, b"BEWATER", b"Bruce Lee", b"Introducing $BEWATER. Bruce Lee on Sui. Inspired by the legendary quote, \"Be water, my friend,\" this token flows through the Sui network with the flexibility and strength of water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vjbhrxhv_Q0_K_Yml_Hrv_Ae58_Q_1_e7ce0d47fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

