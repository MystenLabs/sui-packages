module 0xbd134ff9ecc89ea72ac6e6cbd25cc64cf5d0c3fd2a2828562a4542bedb76d6d9::akira {
    struct AKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIRA>(arg0, 6, b"Akira", b"Akira on SUI", x"48692069206d20416b6972610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ld_W3j_Pm_H_400x400_1_981503593f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

