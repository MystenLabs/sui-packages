module 0x386ffabc06601c916f84a0318f84ef3413bedec617d9ccd43b7cfcf308af0113::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"Be Water, My Friend!", x"496e74726f647563696e67202442525543452e204272756365204c6565206f6e205375692e20496e73706972656420627920746865206c6567656e646172792071756f74652c202242652077617465722c206d7920667269656e642c22207468697320746f6b656e20666c6f7773207468726f7567682074686520537569206e6574776f726b20776974682074686520666c65786962696c69747920616e6420737472656e677468206f662077617465722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Pbrc_4878a5ed13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

