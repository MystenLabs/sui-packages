module 0x4540657eeef29b180b8e7f967f78b825d6efabf36e4ca2437834e3b1e9024e7c::ptr {
    struct PTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTR>(arg0, 9, b"PTR", b"Peter", b"Peter Griffin, born as Justin Peter Griffin according to his birth records in \"Quagmire's Mom\", is the main protagonist of the long-running adult-animated comedy Family Guy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fc443e0-1834-4b6b-8adb-b2b48ae832db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

