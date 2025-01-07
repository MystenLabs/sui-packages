module 0x5096ed9e195b765bfffe8f05d18b0b4966332e37ab703b9f97dc6d3388d25dc0::suifemoon {
    struct SUIFEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFEMOON>(arg0, 6, b"SUIFEMOON", b"Suifemoon", x"53756966656d6f6f6e206973206120746f6b656e206c61756e63686564206f6e2074686520537569206e6574776f726b2c20636f6d62696e696e6720696e6e6f766174696f6e20616e642072617069642067726f77746820706f74656e7469616c2e20496e73706972656420627920746865206d6f6f6e2c2069742061696d7320746f2072656163682074686520746f70206f6620746865206d61726b657420776974682061207374726f6e6720636f6d6d756e69747920616e6420616363656c65726174656420617070726563696174696f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_05_214008_08b51403a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

