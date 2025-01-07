module 0x73bc65a08acf3b090479b0f7e2ea42d84a940540ea417b9cc082c86ddf655b3d::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEED>(arg0, 6, b"SPEED", b"SUISPEED", b"BARK!!! BARK!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_10_07_a_la_s_10_25_48a_p_m_3fda2c4fff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

