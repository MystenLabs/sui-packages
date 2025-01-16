module 0x1e662022acad932e6c78ae43d570756330543e6a5cba0e55f1d43a284b86ffe9::code {
    struct CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CODE>(arg0, 6, b"CODE", b"Kernel Code by SuiAI", b"Empowering Developers with AI-Driven Code Efficiency Code Smarter, Not Harder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2171_e5810dd336.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CODE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

