module 0x170c88cd8952b13b96299b18dbf356ad32a6d740c0c061e62e6fe79f3e4c3a9d::bewater {
    struct BEWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWATER>(arg0, 6, b"BEWATER", b"Bruce Lee", x"496e74726f647563696e67204272756365204c65652c2024424557415445522e20496e73706972656420627920746865206c6567656e646172792071756f74652c202242652077617465722c206d7920667269656e642c22207468697320746f6b656e20666c6f7773207468726f7567682074686520537569206e6574776f726b20776974682074686520666c65786962696c69747920616e6420737472656e677468206f662077617465722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vjbhrxhv_Q0_K_Yml_Hrv_Ae58_Q11_1_48c4141cbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

