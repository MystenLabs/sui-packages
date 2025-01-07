module 0x9e42cdb6f2391521f9683c5c9bebe3a1e6bfb3d1e528331bbe1114fcd5a231a3::fl {
    struct FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL>(arg0, 9, b"FL", b"Florida", b"Let's send a rescue team now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73146dbc-c6b0-462f-b85c-42d8c4877222.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL>>(v1);
    }

    // decompiled from Move bytecode v6
}

