module 0xb59e935e5e62720d7b8d1186fcab7f262ee2a26cc1a62986fc1006d9b6615347::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 9, b"SUIB", x"53756962612049c3b175", x"53756962612049c3b1752069732061206d656d6520636f696e206f6e205375692065636f73797374656d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/916cb5d7-4676-4f6a-a80f-f4a21e83fc01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

