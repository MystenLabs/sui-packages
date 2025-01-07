module 0xc8c365adec328714b6a189915f94ecbec16840403d7f5168b5113bac1598a3d5::krira_27 {
    struct KRIRA_27 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIRA_27, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIRA_27>(arg0, 9, b"KRIRA_27", b"KRIRA", b"Save tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebc3a20d-7493-46e2-b9e4-094128bb9926.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIRA_27>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIRA_27>>(v1);
    }

    // decompiled from Move bytecode v6
}

