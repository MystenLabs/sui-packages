module 0x4609289602cb1b7d8ad3d6f41b4a27b88d4b00b7683b076dd0918f51a0c91774::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"TUSK", b"TUSKAR", b"The First Token Launchpad in Walrus Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c08aa4adda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

