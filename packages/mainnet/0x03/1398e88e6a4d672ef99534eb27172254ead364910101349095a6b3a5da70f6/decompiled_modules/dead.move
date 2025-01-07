module 0x31398e88e6a4d672ef99534eb27172254ead364910101349095a6b3a5da70f6::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 9, b"DEAD", b"Deadpool", b"2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ee1bdfb-0b0c-4ffd-9fcc-74ca14f3c24f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

