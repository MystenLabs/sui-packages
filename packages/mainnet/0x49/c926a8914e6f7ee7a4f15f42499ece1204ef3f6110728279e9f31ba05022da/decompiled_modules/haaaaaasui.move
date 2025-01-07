module 0x49c926a8914e6f7ee7a4f15f42499ece1204ef3f6110728279e9f31ba05022da::haaaaaasui {
    struct HAAAAAASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAAAAAASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAAAAAASUI>(arg0, 6, b"Haaaaaasui", b"Haaaaasui", b"Sneezing sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DA_941484_4_C4_E_40_CE_8370_1_E82_D84_B0_C55_d8e9a84bcc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAAAAAASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAAAAAASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

