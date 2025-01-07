module 0x61c6eefcddcb987121d637298b9204781fa1cbbd07dc55f73cb8e0cd8b6067b1::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"Suiii", x"222053756969693a20546865204352372d696e737069726564206d656d65636f696e20746861742079656c6c7320474f414c2120776974682065766572792070756d7020207c204272696e67696e672074686520474f415420656e6572677920746f2063727970746f20207c20526561647920746f2073636f726520776974682075733f20202353756969692023546f5468654d6f6f6e220a0a53554949494949494949", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_ee1c0fb912.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

