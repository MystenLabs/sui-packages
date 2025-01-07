module 0x8086621a36202c11ed8ee5304ddaa6515ec21d60a63976bf2d8cddf5e9100ca7::wemush {
    struct WEMUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMUSH>(arg0, 9, b"WEMUSH", b"MUSHLO", b"MUSHLO is a meme inspired by the spirit of adventure and freedom. With MUSHLO, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df0f1bf2-88bd-4845-8a51-07132d8d9bbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

