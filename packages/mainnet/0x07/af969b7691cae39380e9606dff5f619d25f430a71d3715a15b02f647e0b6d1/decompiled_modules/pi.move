module 0x7af969b7691cae39380e9606dff5f619d25f430a71d3715a15b02f647e0b6d1::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"PI", b"Pi UwU", b"Pi is the future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f4b4afb-5b78-446c-9661-648774cbf253.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

