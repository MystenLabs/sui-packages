module 0xba5ebfd0b4053dc81f1c394ecfab608c4d200d18758284bd453604f74e1f0dec::lopdt {
    struct LOPDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPDT>(arg0, 9, b"LOPDT", b"Lohhjj", x"4768626378c491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/924e496f-b75e-485f-98ab-29e0040a6388.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOPDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

