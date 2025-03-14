module 0x168f0e8f10501d6b84b51f5a3b3af9065f48a823394268f208d92d2c5c2d743d::rez {
    struct REZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: REZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REZ>(arg0, 9, b"REZ", b"reza", b"reza token on the wawe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ea7f1df-1e5d-498d-9440-8d92251667f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

