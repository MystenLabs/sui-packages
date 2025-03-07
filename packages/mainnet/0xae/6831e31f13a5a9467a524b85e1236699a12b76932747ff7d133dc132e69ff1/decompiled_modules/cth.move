module 0xae6831e31f13a5a9467a524b85e1236699a12b76932747ff7d133dc132e69ff1::cth {
    struct CTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTH>(arg0, 9, b"CTH", b"Cthulhu", x"476f74206974212054686174e280997320612070657266656374206465736372697074696f6e20666f7220796f7572206d656d652e20496620796f75206e65656420616e797468696e6720656c7365206f722077616e7420746f20747765616b20697420667572746865722c206a757374206c6574206d65206b6e6f772e20486176652066756e207769746820796f7572204d6172696e654d656d652120f09f9099e29895f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ef494dc-be71-4285-a68c-b4300a13f97f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

