module 0x32b70c5ff46030d049aec0f05e63014d7c3346cc5789bb1301b19d512c605547::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"walbirth", b"walrus birthday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e894c20e-b6a4-4f9b-bf6b-188e3bcaec0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

