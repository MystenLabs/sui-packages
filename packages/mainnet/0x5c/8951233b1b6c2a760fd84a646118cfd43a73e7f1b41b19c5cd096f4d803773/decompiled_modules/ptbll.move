module 0x5c8951233b1b6c2a760fd84a646118cfd43a73e7f1b41b19c5cd096f4d803773::ptbll {
    struct PTBLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTBLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTBLL>(arg0, 6, b"PTBLL", b"Pitbull", b"READY TO BITE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Al_Ae_nt_Ae_s_Ae_35b3101049.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTBLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTBLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

