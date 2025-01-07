module 0xd81945019d01c619db662f0e29132c71c0f021d57a6dfe5b288c37f862f985e8::bigtinpo {
    struct BIGTINPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGTINPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGTINPO>(arg0, 9, b"BIGTINPO", b"tinp0", b"sexSymbol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86a3bfb4-2ac0-4cfd-9289-73af53cfc145.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGTINPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGTINPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

