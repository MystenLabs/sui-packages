module 0xe08b0d67da7463d5cf224f63dffbf40abf19169c5c27d44c46b7a52f42a8b36d::csc {
    struct CSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSC>(arg0, 9, b"CSC", b"Cisco", b"A Token worthy of lasting for long liquidity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/627c32c0-ce0c-4624-98ac-e880e34c97a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

