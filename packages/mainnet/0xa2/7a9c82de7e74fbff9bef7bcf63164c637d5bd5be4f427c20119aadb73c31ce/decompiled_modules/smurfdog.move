module 0xa27a9c82de7e74fbff9bef7bcf63164c637d5bd5be4f427c20119aadb73c31ce::smurfdog {
    struct SMURFDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFDOG>(arg0, 6, b"SMURFDOG", b"SMURF DOG", b"Only one smurf dog in the world, and it is. LFG! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_21_173512_b31ef4c64e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

