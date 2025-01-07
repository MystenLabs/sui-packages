module 0x54191e98a11066dc42d7110e9a4c9f669e385b794d388174289bf53b530b0183::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 9, b"REAL", b"Realms", x"f09f90b2f09f94a554686520647261676f6e732061726520686572652120f09f94a5f09f90b20a0a5765277265206578636974656420746f20616e6e6f756e63652074686174206f7572204b6f6a696e2047656e6573697320436f6c6c656374696f6e20686173206d61646520697420746f207468652066696e616c207374616765206f662074686520636f6d6d756e69747920636f6c6c656374696f6e2070726f6772616d20746f206c61756e6368206f6e207468652040526f6e696e5f4e6574776f726b2e20f09f8c90f09f9a800a0a536f6f6e20796f752077696c6c2062652061626c6520746f20766f746520666f722075732120f09f97b3efb88f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43081269-bdf0-4a75-81c6-422ef177da1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

