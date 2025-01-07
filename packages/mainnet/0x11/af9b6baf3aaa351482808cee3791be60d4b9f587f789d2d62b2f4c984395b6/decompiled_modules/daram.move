module 0x11af9b6baf3aaa351482808cee3791be60d4b9f587f789d2d62b2f4c984395b6::daram {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 6, b"DARAM", b"DARAM ON SUI", b"The author of this goose is my three-year-old daughter.Dexscreener paid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_28_990e2fb180.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

