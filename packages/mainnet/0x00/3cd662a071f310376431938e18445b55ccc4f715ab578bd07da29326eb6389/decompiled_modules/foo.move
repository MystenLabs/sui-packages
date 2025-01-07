module 0x3cd662a071f310376431938e18445b55ccc4f715ab578bd07da29326eb6389::foo {
    struct FOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOO>(arg0, 9, b"FOO", b"football", b"technical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30c5dec7-ebb1-45b8-b125-ab283d8426a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

