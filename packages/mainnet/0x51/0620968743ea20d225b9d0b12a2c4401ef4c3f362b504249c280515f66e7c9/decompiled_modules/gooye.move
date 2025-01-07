module 0x510620968743ea20d225b9d0b12a2c4401ef4c3f362b504249c280515f66e7c9::gooye {
    struct GOOYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOYE>(arg0, 6, b"GOOYE", b"Gooey on Sui", x"54686520537469636b7920537765657420546f6b656e20546861742057696c6c204d616b6520596f7520526963680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Pt_Ps3v_N_400x400_5646e2d426.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

