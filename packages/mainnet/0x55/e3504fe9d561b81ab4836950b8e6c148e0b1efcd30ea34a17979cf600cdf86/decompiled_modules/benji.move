module 0x55e3504fe9d561b81ab4836950b8e6c148e0b1efcd30ea34a17979cf600cdf86::benji {
    struct BENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJI>(arg0, 6, b"Benji", b"Benji For Sui", x"42656e6a692062657374206d656d6520746f6b656e20627574206e6f7420686572652062757420776879206e6f7420686572652e20436f6d65206f6e2e0a0a6966206d6361702032306b2075702069206275726e206d7920746f6b656e7320253530", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/benji_446d590430.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

