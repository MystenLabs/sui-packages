module 0xcb8faca0c1b5a15f8ccdc15a46c1018798922670084edd0f3d964e0590e272a8::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GT>(arg0, 9, b"GT", b"Go ten ", b"GO TEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75b017eb-9ffd-4cdd-b317-a637f3da05a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GT>>(v1);
    }

    // decompiled from Move bytecode v6
}

