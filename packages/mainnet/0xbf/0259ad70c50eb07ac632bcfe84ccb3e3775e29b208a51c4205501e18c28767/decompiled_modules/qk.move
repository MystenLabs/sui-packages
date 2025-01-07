module 0xbf0259ad70c50eb07ac632bcfe84ccb3e3775e29b208a51c4205501e18c28767::qk {
    struct QK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QK>(arg0, 9, b"QK", b"Alaalak", b"Qp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4909d26-9271-451e-a868-a5579c7d7d8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QK>>(v1);
    }

    // decompiled from Move bytecode v6
}

