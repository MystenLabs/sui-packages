module 0x9c69416137a8c65968e392194ede37c84b88ae871d096ac8e1344c85979989f2::e {
    struct E has drop {
        dummy_field: bool,
    }

    fun init(arg0: E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E>(arg0, 9, b"E", b"BLUM", b"Blumed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f0e3911-299d-4727-9cc8-2fa8fefaea18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E>>(v1);
    }

    // decompiled from Move bytecode v6
}

