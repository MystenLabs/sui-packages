module 0xb986f670d0a5e0f82a02e55221ba3f843ee2e2c876bf8ed55f4898360ff93f9::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 9, b"BAD", b"Low", b"Not", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69a8d933-f227-455e-acc1-1e8049bced84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

