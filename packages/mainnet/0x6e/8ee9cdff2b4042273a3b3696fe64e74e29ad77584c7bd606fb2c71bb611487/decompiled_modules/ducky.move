module 0x6e8ee9cdff2b4042273a3b3696fe64e74e29ad77584c7bd606fb2c71bb611487::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"DUCKY", b"DUCKY DUCKY", b"Ducks are often seen as symbols of luck, trust, and wealth in various cultures. Their presence in folklore and symbolism around the world represents prosperity and good fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P1yk_MMMWMVL_3z9e6_X_Gjdhw5b4_U5_P9_Qt_Z1s_N7_Tfdv8_F4_N_1c232cbd11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

