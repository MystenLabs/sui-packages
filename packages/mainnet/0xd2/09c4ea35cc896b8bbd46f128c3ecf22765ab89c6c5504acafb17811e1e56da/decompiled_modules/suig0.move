module 0xd209c4ea35cc896b8bbd46f128c3ecf22765ab89c6c5504acafb17811e1e56da::suig0 {
    struct SUIG0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG0>(arg0, 9, b"SUIG0", b"SUIG0 Tok", x"546f6b656e207468617420426f6f6d206c617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35d144d9-0074-4c11-84d2-3ba3f73ba5da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIG0>>(v1);
    }

    // decompiled from Move bytecode v6
}

