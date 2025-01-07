module 0xd4deacd6770cb783e9ac0cb5256271780aa1e8c03ac52745b96eac0e5bdc62d1::xox {
    struct XOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XOX>(arg0, 9, b"XOX", b"X", b"XoXoX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b38ba943-6e79-4d78-a80c-6412a305d45e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

