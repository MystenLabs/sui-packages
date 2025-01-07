module 0x933f2e347e2bc8d6d121b018180ed8233bc3329d13669cebfbcb7ceae6d146c7::timosha {
    struct TIMOSHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMOSHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMOSHA>(arg0, 9, b"TIMOSHA", b"Mycat", b"16", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80d9e979-3bfc-44da-afdb-9634d9aea373.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMOSHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMOSHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

