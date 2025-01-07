module 0x3d5b0e453674484f4e06404adf7a0b212b75ee04b5b86eebe5e1f4708606e9f5::chompy {
    struct CHOMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPY>(arg0, 6, b"CHOMPY", b"CHOMPY SUI", x"4d6565742043686f6d70792074686520626967206669736820796f757220676620746f6c6420796f75206e6f7420746f20776f7272792061626f75740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gme_J_yky_400x400_d346b1af36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

