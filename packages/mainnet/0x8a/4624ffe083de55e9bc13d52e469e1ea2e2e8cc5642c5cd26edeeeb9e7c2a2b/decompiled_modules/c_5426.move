module 0x8a4624ffe083de55e9bc13d52e469e1ea2e2e8cc5642c5cd26edeeeb9e7c2a2b::c_5426 {
    struct C_5426 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_5426, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_5426>(arg0, 6, b"5426", b"48", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_5426>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_5426>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

