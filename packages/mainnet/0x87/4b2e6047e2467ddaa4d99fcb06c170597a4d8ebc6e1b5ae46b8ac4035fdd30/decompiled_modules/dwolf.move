module 0x874b2e6047e2467ddaa4d99fcb06c170597a4d8ebc6e1b5ae46b8ac4035fdd30::dwolf {
    struct DWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOLF>(arg0, 9, b"DWOLF", b"Dwolf", b"Dwolf is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62d980e6-351a-4153-8e85-71a6b7d470c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

