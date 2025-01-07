module 0x8945924ce48190a77827a52ff0e66fd072b11dfda0c835de8d557b6f09613d30::spin {
    struct SPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIN>(arg0, 6, b"SPIN", b"SuiSpin", x"54686520556c74696d617465205765623320436173696e6f20457870657269656e63652121210a5370696e20616e642057696e207768696c6520656e6a6f79696e672066617374207061796f75747320746f74616c20616e6f6e796d69747920616e642070726f7661626c7920666169722067616d696e6720657870657269656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suispin_logo_d5b6c23293.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

