module 0x8d18126a1f0473e9532eeb25f1afaa2ecc7b396961e0c7aeaeb2277e57d63bc::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS>(arg0, 6, b"Turbos", b"Turbo on Turbos", x"547572626f206f6e20547572626f73206973206f6e65206f6620746865206669727374204d656d6520746f6b656e7320696e20547572626f732066696e616e63652e20204661737465737420436861696e205355492066617374206d656d652e205769746820737065656420746f20746865206d6f6f6e20f09f8c9920f09f9a80200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957433051.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

