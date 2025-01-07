module 0x3c98dced87ba56f851d7b7206e2cb2bad2619173c61cec951d2ecd102336a78a::gbl {
    struct GBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBL>(arg0, 9, b"GBL", b"GOLDENBOOL", b"Bull Market Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21c6f3a8-799a-4bde-9f69-cfe2c2e87b1a-1000019199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

