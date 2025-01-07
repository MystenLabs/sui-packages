module 0xd0a0feb502fa88f34822144f8d7915a04a01e4a4ce7915c10cec6fbaa5a6fab2::mizan {
    struct MIZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZAN>(arg0, 9, b"MIZAN", b"Noob", b"It's a gamic token .blast royel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a29746be-1a6e-441a-b7d1-c5e82ed32327.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

