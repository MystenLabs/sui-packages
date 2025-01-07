module 0x3152d0a352029d58ddefc685353cedc59891f35348517e2092ae22c812d1ea53::ops {
    struct OPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPS>(arg0, 9, b"OPS", b"Optimusui", b" \"Sui the Guardian Robot.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3eb3a1a0-fe6e-4689-835c-0a34792f3942.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

