module 0x2bebe1e7f29cdd4bb6df44b5b914bc3151e0a380695e3a85a2bff1cf17c81cf8::esm {
    struct ESM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESM>(arg0, 9, b"ESM", b"ELYSIUM", b"Token Juggernaut Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d21de2e9-df3e-4d43-bd27-75cfba78deb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESM>>(v1);
    }

    // decompiled from Move bytecode v6
}

