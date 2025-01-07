module 0xe31ca2f4e4102d54744744526e7e63d408667a01ce006fac2f48d821b478d28a::mine {
    struct MINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINE>(arg0, 9, b"MINE", b"Mine", b"Myseft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e5df7a8-613c-415f-b047-f421ec5020cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

