module 0xb875233ee28521b5430c848ad59efe379777299cb4e227a7c68b412a5282cbd7::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 9, b"TWO", b"Twancom", b"Make everybody laugh for free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f943f74d-5830-4c7c-b94e-388209de8506.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

