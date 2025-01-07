module 0x3436f22a9cfa68e11b6ef0a80808c4ad1d1939b6e2e96ff16696c9f9b7c58c4f::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"PURPLE", b"STIMULATING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fc25416-9fd1-4529-a2e0-d21b440af0fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

