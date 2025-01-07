module 0xfa105d280d2033c528e62590cbcabd1dd77bddf3d79d5fe09b9e79ad3324ceed::gbl {
    struct GBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBL>(arg0, 9, b"GBL", b"GOLDENBOOL", b"Bull Market Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2cef6e3-f09f-4cb0-a307-73012671cce6-1000019199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

