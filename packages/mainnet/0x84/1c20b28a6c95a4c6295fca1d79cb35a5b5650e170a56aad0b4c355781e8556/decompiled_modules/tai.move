module 0x841c20b28a6c95a4c6295fca1d79cb35a5b5650e170a56aad0b4c355781e8556::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAI>(arg0, 9, b"TAI", b"Trump AI", b"Trump AI bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/399f8bca-223b-4754-b450-337bacef8e75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

