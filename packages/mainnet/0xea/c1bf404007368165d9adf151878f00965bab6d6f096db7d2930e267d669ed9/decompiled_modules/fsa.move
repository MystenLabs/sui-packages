module 0xeac1bf404007368165d9adf151878f00965bab6d6f096db7d2930e267d669ed9::fsa {
    struct FSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSA>(arg0, 9, b"FSA", b"SA", b"DSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d5940ca-1aaf-4b5f-a98e-44216ce4e5a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

