module 0x98d1559ecbe03144d8a3fb6c6ab1dba8902657792c53f644b7e401a88f78f9aa::ky {
    struct KY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KY>(arg0, 9, b"KY", b"Kyra", b"It's a community project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eccf2edf-46ea-4d27-8d7c-84c40ed7b81e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KY>>(v1);
    }

    // decompiled from Move bytecode v6
}

