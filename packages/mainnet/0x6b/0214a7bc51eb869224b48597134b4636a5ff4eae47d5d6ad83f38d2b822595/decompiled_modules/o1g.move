module 0x6b0214a7bc51eb869224b48597134b4636a5ff4eae47d5d6ad83f38d2b822595::o1g {
    struct O1G has drop {
        dummy_field: bool,
    }

    fun init(arg0: O1G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O1G>(arg0, 9, b"O1G", b"Viktor O.", b"Freedom fighter, Husband, Father, Grandfather, Prime Minister of Hungary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7594deb6-0450-4d6c-9944-8db0eb4c7da8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O1G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O1G>>(v1);
    }

    // decompiled from Move bytecode v6
}

