module 0xcedf93e6082f7d7f7e3795820d82653b680c79f977a13a106321bb6f343ef828::wawetoken1 {
    struct WAWETOKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWETOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWETOKEN1>(arg0, 9, b"WAWETOKEN1", b"PHOENIX ", b"SUPPORT THIS PROJECT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81fb10ae-1018-4310-91a0-f4593b40e5c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWETOKEN1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWETOKEN1>>(v1);
    }

    // decompiled from Move bytecode v6
}

