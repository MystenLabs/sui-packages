module 0xc3cbb0df3c432aeb071240b72be29b83febb2ec12c353058da521cd068348ba4::xt {
    struct XT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XT>(arg0, 9, b"XT", b"Xetter", b"Xetterment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a6ea9ac-2d81-47ed-9db7-58ac244d588f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XT>>(v1);
    }

    // decompiled from Move bytecode v6
}

