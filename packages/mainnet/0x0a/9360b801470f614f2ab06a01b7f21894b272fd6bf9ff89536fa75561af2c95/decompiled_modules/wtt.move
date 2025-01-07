module 0xa9360b801470f614f2ab06a01b7f21894b272fd6bf9ff89536fa75561af2c95::wtt {
    struct WTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTT>(arg0, 9, b"WTT", b"JWTT", b"World trusted token in sui wallet. You can explore in sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be0f47f3-aa84-4c36-9b6d-c39a6767391f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

