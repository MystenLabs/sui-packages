module 0xeb1a529d57fc8e47c0834a656b63030dd70cc1b0611d2c3eda37830fef15ed42::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 9, b"BOBR", b"Bobr Kurwa", x"546865202242c3b36272204b7572776122206d656d65206170706561726564206261636b20696e20417072696c20323032322120426561766572204b7572776120282042c3b36272204b75727761206a612070696572646f6c6529", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99ffc745-0ad4-416b-843a-abf302bf2993.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

