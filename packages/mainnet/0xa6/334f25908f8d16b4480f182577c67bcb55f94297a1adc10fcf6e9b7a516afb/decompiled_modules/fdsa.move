module 0xa6334f25908f8d16b4480f182577c67bcb55f94297a1adc10fcf6e9b7a516afb::fdsa {
    struct FDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDSA>(arg0, 9, b"FDSA", b"gh", b"DSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f18e628b-d195-44aa-a171-bb4d6cfc9102.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

