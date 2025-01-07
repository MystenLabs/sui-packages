module 0x80c35dd96ec0c30ad1bd63b3c9898bade56230f2c0559fe85b51285f095d75ad::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"SLERF", b"SLERF on SUI", b"I'm a sloth. Slerf has no underlying value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3fl_B_Zb8_V_400x400_f2a379aa70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

