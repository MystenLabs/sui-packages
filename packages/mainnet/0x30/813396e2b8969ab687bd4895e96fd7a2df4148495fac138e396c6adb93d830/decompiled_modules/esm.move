module 0x30813396e2b8969ab687bd4895e96fd7a2df4148495fac138e396c6adb93d830::esm {
    struct ESM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESM>(arg0, 9, b"ESM", b"ELYSIUM", b"Token Juggernaut Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b25602a-9bca-4a1c-87e5-692f52722c2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESM>>(v1);
    }

    // decompiled from Move bytecode v6
}

