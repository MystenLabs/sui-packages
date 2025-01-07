module 0xc26a51c74ff777751c02d2783b9093796414329d97c29fcbd166c0c02f02af40::bijanalavi {
    struct BIJANALAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIJANALAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIJANALAVI>(arg0, 9, b"BIJANALAVI", b"SBA", b" i love old building", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8430cc20-2bd3-4acb-9c6a-4ae50a46b4d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIJANALAVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIJANALAVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

