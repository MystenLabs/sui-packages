module 0xcfc3b943a46a437bb8cf30db6d946d92126b4bba1c136a6393b81a39c987aaa1::frg {
    struct FRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRG>(arg0, 9, b"FRG", b"THE FROG", b"A significant jump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64f29e6e-2b2d-4f04-8dcc-ded420e02550.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

