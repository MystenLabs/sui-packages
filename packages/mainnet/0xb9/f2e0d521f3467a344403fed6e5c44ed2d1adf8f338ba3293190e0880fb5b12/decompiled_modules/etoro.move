module 0xb9f2e0d521f3467a344403fed6e5c44ed2d1adf8f338ba3293190e0880fb5b12::etoro {
    struct ETORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETORO>(arg0, 6, b"eToro", b"etoro", x"5468697320746f6b656e206861732061206675747572652e20546865207465616d20776f726b696e67206f6e20697420636f6e7369737473206f662032372070726f66657373696f6e616c7320696e3a204d61726b6574696e672c2049542c204445562c20536563757269747920616e64206574632e2057652061726520612067726f757020776974682070726f76656e2070726f6a6563747320746861742077696c6c206265636f6d6520636c656172657220696e20746865206675747572652e2054686520676f616c206f66207468697320746f6b656e20697320746f2072656163682062696c6c696f6e73206f66204d6361702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yo_Q_Ta_DG_13tv_Zn_C8_Ug_A_Jnp_Vh4_Ev_Jit_Hma5_Ngjei_Gn_S_Wna_0044b648fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

