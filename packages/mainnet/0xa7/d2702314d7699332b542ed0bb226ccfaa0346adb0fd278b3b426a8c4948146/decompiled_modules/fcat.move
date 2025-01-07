module 0xa7d2702314d7699332b542ed0bb226ccfaa0346adb0fd278b3b426a8c4948146::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 9, b"FCAT", b"FAIRY CAT", b"A FAIRY CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6abc387-e65e-4388-a8a9-ce1b76947de0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

