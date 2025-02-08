module 0x2c729c053bd472974592343b577bfb1e7b75436544577b49b1d33ee4a951ab1d::chv {
    struct CHV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHV>(arg0, 6, b"CHV", b"ChainVest by SuiAI", b"ChainVest ($CHV) is an AI-powered cryptocurrency that provides real-time market insights, AI-driven trading signals, and automated portfolio management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/475953263_3860520434189561_3787087939475153172_n_e4fb9c6cfd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

