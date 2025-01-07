module 0x1a9fb459c0251edb21235f2ff998fa3b98a8675bc3f3c299fdb77b150b6b682b::noi {
    struct NOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOI>(arg0, 9, b"NOI", b"Noion", b"Token noi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd2bec23-3417-4a78-aaea-355181852a1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

