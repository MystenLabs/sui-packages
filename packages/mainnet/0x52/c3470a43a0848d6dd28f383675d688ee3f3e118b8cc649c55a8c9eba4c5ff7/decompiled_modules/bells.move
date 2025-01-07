module 0x52c3470a43a0848d6dd28f383675d688ee3f3e118b8cc649c55a8c9eba4c5ff7::bells {
    struct BELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLS>(arg0, 9, b"BELLS", b"Bello616", b"Bell the bell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9668398-13f3-450d-ac7f-457b72c32b84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

