module 0x131e4d18abd6dd7912fb0b8d8838a53517cb957861d9634177ccb847a7fe5be::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"FLOKI", b"Floksui", b"We're thrilled to have you join us as Floki takes its next big step onto the Sui Network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q0_vy0_Zc_400x400_9c87d0c393.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

