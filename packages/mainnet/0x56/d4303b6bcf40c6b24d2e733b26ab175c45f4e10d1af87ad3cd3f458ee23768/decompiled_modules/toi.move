module 0x56d4303b6bcf40c6b24d2e733b26ab175c45f4e10d1af87ad3cd3f458ee23768::toi {
    struct TOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOI>(arg0, 6, b"TOI", b"Thick Of It", b"From the Screen  To the Ring  To the Pen  To the King ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TY_Dc_Ex_t_400x400_1_7a0c945f43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

