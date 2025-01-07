module 0xdd07082a59e1b0f01efd396130b220bb7f6e0d7602ece24003c1c35f9806151::wake {
    struct WAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKE>(arg0, 9, b"WAKE", b"Wakeup", b"wake up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1845a7fd-e911-4ad1-a817-7baf1f37696c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

