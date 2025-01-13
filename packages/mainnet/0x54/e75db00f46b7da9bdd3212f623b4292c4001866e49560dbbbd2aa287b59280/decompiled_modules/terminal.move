module 0x54e75db00f46b7da9bdd3212f623b4292c4001866e49560dbbbd2aa287b59280::terminal {
    struct TERMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINAL>(arg0, 6, b"TERMINAL", b"TERMINAL OF SUI", b"Terminal Of Sui is an innovative project on the Sui blockchain designed to revolutionize user interaction within the ecosystem. With a focus on sustainability and community growth, the project will launch on the Movepump Launchpad, leveraging its robust platform for a successful introduction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_8d38a82919.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

