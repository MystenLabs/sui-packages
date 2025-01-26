module 0x34a22572b417d103ed156e068a48122e406c3a35236b1d3e96738a6d1a0c19df::aone {
    struct AONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AONE>(arg0, 9, b"AONE", b"A ONE ", b"Lunching ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc91e207-a1aa-44d9-a7ce-7149b52cba15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

