module 0x1c6c013f7e920c615f81235920ef9ee32ffa8c7e3619514ceeeb99e2e042b4da::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"HONK", b"HONK the BONK", x"4d65737320776974682074686520686f6e6b2c20616e6420796f75206765742074686520626f6e6b21204974277320676f6f73652074696d6521205061726f647920200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_c22b15031d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

