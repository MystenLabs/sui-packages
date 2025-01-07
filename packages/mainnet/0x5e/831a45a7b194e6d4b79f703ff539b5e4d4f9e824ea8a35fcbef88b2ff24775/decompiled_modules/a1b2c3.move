module 0x5e831a45a7b194e6d4b79f703ff539b5e4d4f9e824ea8a35fcbef88b2ff24775::a1b2c3 {
    struct A1B2C3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A1B2C3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1B2C3>(arg0, 9, b"A1B2C3", b"Sumbal", b"This is good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b013157-c3ee-4afa-abe9-75b8aa67cb1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1B2C3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1B2C3>>(v1);
    }

    // decompiled from Move bytecode v6
}

