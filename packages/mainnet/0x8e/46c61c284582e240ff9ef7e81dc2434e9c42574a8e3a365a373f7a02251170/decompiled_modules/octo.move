module 0x8e46c61c284582e240ff9ef7e81dc2434e9c42574a8e3a365a373f7a02251170::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"Oscar The Octopus", x"596f757220667269656e646c79206d756c74697665727365206f63746f200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yq_Ruj7_Xs_AA_Cm_ZR_e79331a6a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

