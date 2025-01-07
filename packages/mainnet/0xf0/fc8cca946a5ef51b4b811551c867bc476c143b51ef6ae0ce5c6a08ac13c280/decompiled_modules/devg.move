module 0xf0fc8cca946a5ef51b4b811551c867bc476c143b51ef6ae0ce5c6a08ac13c280::devg {
    struct DEVG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVG>(arg0, 6, b"DEVG", b"DEVDOG", b"DEVDOG is meme when DEV cooked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_WQ_Wc8_DDPXJ_Rc_Yn6_Y7_P_Dti_Jua_Xunjs_DY_963_Yb7_Ns44_HX_9977f1e5b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVG>>(v1);
    }

    // decompiled from Move bytecode v6
}

