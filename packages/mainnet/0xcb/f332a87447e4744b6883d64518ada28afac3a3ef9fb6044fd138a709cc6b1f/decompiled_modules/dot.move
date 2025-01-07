module 0xcbf332a87447e4744b6883d64518ada28afac3a3ef9fb6044fd138a709cc6b1f::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 9, b"DOT", b"Dotx", b"Dotx ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ff96124-b904-4e3a-b3e2-0e638a6ade51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

