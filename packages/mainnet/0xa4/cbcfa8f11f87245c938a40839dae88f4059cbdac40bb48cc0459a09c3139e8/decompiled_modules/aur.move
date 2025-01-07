module 0xa4cbcfa8f11f87245c938a40839dae88f4059cbdac40bb48cc0459a09c3139e8::aur {
    struct AUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUR>(arg0, 6, b"AUR", b"aura$", x"617572612069732074686520656e6572677920796f7520656d6974200a0a65766572797468696e6720616e642065766572796f6e652068617320736f6d65206c6576656c206f662061757261200a0a686176696e6720226175726122206973206f6e65206f662074686520677265617465737420636f6d706c696d656e7473206f6e652063616e2072656365697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_1692a42983.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

