module 0xa81e8f62bfcd3c04545cee5209d434574c7ebe7fbfcb0e52eb58de8974eff3a7::bewater {
    struct BEWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWATER>(arg0, 6, b"BEWATER", b"Bruce Lee", x"496e74726f647563696e672024424557415445522e204272756365204c6565206f6e205375692e20496e73706972656420627920746865206c6567656e646172792071756f74652c202242652077617465722c206d7920667269656e6427270a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vjbhrxhv_Q0_K_Yml_Hrv_Ae58_Q11_1_8e97be1e1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

