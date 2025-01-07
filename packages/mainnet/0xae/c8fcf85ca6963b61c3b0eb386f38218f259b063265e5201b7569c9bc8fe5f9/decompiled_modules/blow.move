module 0xaec8fcf85ca6963b61c3b0eb386f38218f259b063265e5201b7569c9bc8fe5f9::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 9, b"BLOW", b"$BLOW", b"A memecoin Design to Blow the mind of all people in the Universe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f1fc942-b5ba-40e4-8503-ee94ab4d2366.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

