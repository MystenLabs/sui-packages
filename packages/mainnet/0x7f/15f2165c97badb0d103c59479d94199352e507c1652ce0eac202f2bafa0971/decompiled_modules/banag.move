module 0x7f15f2165c97badb0d103c59479d94199352e507c1652ce0eac202f2bafa0971::banag {
    struct BANAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANAG>(arg0, 9, b"BANAG", b"Bbzhag", b"BznNNn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f125de9f-5356-43e0-ac0e-48e49c25cb8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

