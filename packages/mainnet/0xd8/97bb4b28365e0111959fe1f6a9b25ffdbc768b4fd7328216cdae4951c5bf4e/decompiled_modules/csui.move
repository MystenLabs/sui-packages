module 0xd897bb4b28365e0111959fe1f6a9b25ffdbc768b4fd7328216cdae4951c5bf4e::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 6, b"CSUI", b"SUICAT", x"54686520636174206f6e20746865206d6f6f6e20747279696e6720746f2067657420746f207468652073756e2e2e204a652073756973205375694361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MUNCAT_TJ_44_MB_FKFM_8_Y8eyh_H2_7b9d9c9ca1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

