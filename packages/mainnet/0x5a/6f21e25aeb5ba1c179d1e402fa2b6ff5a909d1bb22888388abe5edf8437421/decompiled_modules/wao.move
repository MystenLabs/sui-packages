module 0x5a6f21e25aeb5ba1c179d1e402fa2b6ff5a909d1bb22888388abe5edf8437421::wao {
    struct WAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAO>(arg0, 9, b"WAO", b"WE ARE ONE", b"Viet Nam & Indonesia Is Good Friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/245deef2-d0ec-4d95-a0ad-729644e6aebf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

