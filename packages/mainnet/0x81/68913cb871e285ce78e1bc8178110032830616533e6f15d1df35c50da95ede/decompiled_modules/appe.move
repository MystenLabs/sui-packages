module 0x8168913cb871e285ce78e1bc8178110032830616533e6f15d1df35c50da95ede::appe {
    struct APPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPE>(arg0, 9, b"APPE", b"APE", b"APES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5287401-37b6-403a-9e4e-7e01c0ff097c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

