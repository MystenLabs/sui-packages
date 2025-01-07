module 0x1829695673542e781b310f2cdc9ea6fa6298a8a16d64d2c8257ad9228c00b1b7::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 9, b"AKA", b"Akas", b"a very potetial token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/343009ed-a5c6-4979-abed-900e2dbb59ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

