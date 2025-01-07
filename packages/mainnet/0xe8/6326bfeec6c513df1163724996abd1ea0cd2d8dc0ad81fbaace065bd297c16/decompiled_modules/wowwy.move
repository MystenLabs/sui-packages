module 0xe86326bfeec6c513df1163724996abd1ea0cd2d8dc0ad81fbaace065bd297c16::wowwy {
    struct WOWWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWWY>(arg0, 9, b"WOWWY", b"Daopensol", b"What the fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e234274-429b-424a-ae67-776a45da385b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

