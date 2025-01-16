module 0x423685b77cee7cb22ced94126074c56e5559259f042820ac1538d1b1c83b7425::nlm {
    struct NLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLM>(arg0, 6, b"NLM", b"Neurolink AI", x"244e4c4d20697320796f757220656e74727920746f6b656e20746f20746865204e6575726f6c696e6b41492065636f73797374656d2e20e2809c5468696e6b2e20436f6e6e6563742e205472616e73666f726d2e20f09fa496204e6575726f4c696e6b20414920627269646765732074686520676170206265747765656e2068756d616e20636f676e6974696f6e20616e6420746563686e6f6c6f677920776974682063757474696e672d6564676520627261696e2d706f776572656420414920736f6c7574696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737018144615.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

